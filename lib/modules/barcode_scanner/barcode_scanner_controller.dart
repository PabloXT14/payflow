import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';

import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController {
  // ValueNotifier para gerenciar o estado do scanner de código de barras e notificar os ouvintes sobre as mudanças de estado. (em nosso caso, a interface do usuário), sem precisar do setState() do StatefulWidget.
  final statusNotifier = ValueNotifier<BarcodeScannerStatus>(
    BarcodeScannerStatus(),
  );

  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus newStatus) =>
      statusNotifier.value = newStatus;

  final barcodeScanner = BarcodeScanner();

  // ✅ Guards para evitar processamento simultâneo
  bool _isProcessing = false;
  bool _disposed = false;
  Timer? _timeoutTimer;

  void getAvailableCameras() async {
    // ✅ Limpa estado anterior completamente antes de reiniciar
    _cancelTimeout();
    _isProcessing = false;

    await _disposeCameraController();

    // Lógica para obter as câmeras disponíveis
    try {
      final response = await availableCameras();

      final camera = response.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      final cameraController = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await cameraController.initialize();

      if (_disposed) {
        await cameraController.dispose();
        return;
      }

      status = BarcodeScannerStatus.available(cameraController);

      _startTimeout();
      _listenCamera();
    } catch (error) {
      if (!_disposed) {
        status = BarcodeScannerStatus.error(error.toString());
      }
    }
  }

  // ✅ Timeout gerenciado com Timer cancelável
  void _startTimeout() {
    _cancelTimeout();
    _timeoutTimer = Timer(Duration(seconds: 15), () {
      if (!_disposed && status.barcode.isEmpty) {
        _stopStream();
        status = BarcodeScannerStatus.error(
          'Tempo esgotado para leitura do código de barras. Tente novamente.',
        );
      }
    });
  }

  void _cancelTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
  }

  void scanWithImagePicker() async {
    _cancelTimeout();
    await _stopStream();

    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (response == null) return;

    final inputImage = InputImage.fromFilePath(response.path);

    await _scannerBarcode(inputImage);
  }

  Future<void> _scannerBarcode(InputImage inputImage) async {
    // ✅ Evita processamento paralelo
    if (_isProcessing || _disposed) return;
    _isProcessing = true;

    try {
      await _stopStream();

      final barcodes = await barcodeScanner.processImage(inputImage);

      String? barcode;
      for (Barcode item in barcodes) {
        barcode = item.displayValue; // Obter o valor do código de barras
      }

      if (_disposed) return;

      if (barcode != null && barcode.isNotEmpty) {
        _cancelTimeout();

        await _disposeCameraController();

        status = BarcodeScannerStatus.barcode(barcode);

        print("CÓDIGO LIDO: $barcode");
      } else {
        // ✅ Reinicia apenas o stream, não toda a câmera
        _isProcessing = false;
        _listenCamera();
      }
    } catch (error) {
      if (!_disposed) {
        status = BarcodeScannerStatus.error(error.toString());
      }
    } finally {
      // ✅ Garante reset do flag mesmo em caso de exceção inesperada
      if (status.barcode.isEmpty && !_disposed) {
        _isProcessing = false;
      }
    }
  }

  Future<void> _stopStream() async {
    try {
      if (status.cameraController != null &&
          status.cameraController!.value.isInitialized &&
          status.cameraController!.value.isStreamingImages) {
        await status.cameraController!.stopImageStream();
      }
    } catch (_) {}
  }

  Future<void> _disposeCameraController() async {
    try {
      await _stopStream();
      await status.cameraController?.dispose();
    } catch (_) {}
  }

  void _listenCamera() {
    if (_disposed) return;

    final controller = status.cameraController;
    if (controller == null || !controller.value.isInitialized) return;
    if (controller.value.isStreamingImages) return;

    controller.startImageStream((cameraImage) async {
      // ✅ Descarta frames enquanto já está processando
      if (_isProcessing || _disposed) return;

      try {
        final WriteBuffer allBytes = WriteBuffer();
        for (Plane plane in cameraImage.planes) {
          allBytes.putUint8List(plane.bytes);
        }

        final bytes = allBytes.done().buffer.asUint8List();

        final inputImageData = InputImageMetadata(
          size: Size(
            cameraImage.width.toDouble(),
            cameraImage.height.toDouble(),
          ),
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          bytesPerRow: cameraImage.planes.first.bytesPerRow,
        );

        final inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: inputImageData,
        );

        // ✅ Sem Future.delayed aqui — o _isProcessing já evita sobrecarga
        await _scannerBarcode(inputImage);
      } catch (_) {}
    });
  }

  void dispose() {
    _disposed = true;
    _cancelTimeout();
    statusNotifier.dispose();
    barcodeScanner.close();
    _disposeCameraController();
  }
}
