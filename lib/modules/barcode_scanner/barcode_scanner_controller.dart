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
    BarcodeScannerStatus.idle(),
  );

  BarcodeScannerStatus get status => statusNotifier.value;
  set _status(BarcodeScannerStatus newStatus) =>
      statusNotifier.value = newStatus;

  final _barcodeScanner = BarcodeScanner();
  Timer? _timeoutTimer;
  bool _disposed = false;

  // ─── câmera ──────────────────────────────────────────────────────────────

  Future<void> getAvailableCameras() async {
    if (_disposed) return;

    _timeoutTimer?.cancel();
    await _disposeCamera();
    _status = BarcodeScannerStatus.idle();

    try {
      final cameras = await availableCameras();
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
      );

      final controller = CameraController(
        back,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );
      await controller.initialize();

      if (_disposed) {
        await controller.dispose();
        return;
      }

      _status = BarcodeScannerStatus.available(controller);
      _startTimeout();
      _startCameraStream();
    } catch (error) {
      if (!_disposed) {
        _status = BarcodeScannerStatus.error(error.toString());
      }
    }
  }

  void _startCameraStream() {
    final controller = status.cameraController;

    // ✅ Checagem robusta para garantir que o controller está pronto para iniciar o stream
    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.isStreamingImages) {
      return;
    }

    controller.startImageStream((image) async {
      // Ignora frames enquanto já não estiver mais em streaming
      // (stream foi parado logo abaixo antes do await)
      if (_disposed || !status.showCamera) return;

      // Para o stream ANTES de qualquer await para bloquear novos frames
      try {
        await controller.stopImageStream();
      } catch (_) {}

      if (_disposed || !status.showCamera) return;

      debugPrint('[Scanner] processando frame da câmera');

      final inputImage = _buildInputImage(image);
      await _processImage(inputImage);
    });
  }

  InputImage _buildInputImage(CameraImage image) {
    final allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    return InputImage.fromBytes(
      bytes: allBytes.done().buffer.asUint8List(),
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  // ─── galeria ─────────────────────────────────────────────────────────────
  Future<void> scanWithImagePicker() async {
    if (_disposed) return;

    _timeoutTimer?.cancel();
    await _disposeCamera();

    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (picked == null) {
        // Usuário cancelou: reinicia câmera normalmente
        await getAvailableCameras();
        return;
      }

      final inputImage = InputImage.fromFilePath(picked.path);

      debugPrint('[Scanner] INPUT IMAGE FROM GALLERY: ${inputImage.toJson()}');

      await _processImage(inputImage, fromGallery: true);
    } catch (error) {
      if (!_disposed) {
        _status = BarcodeScannerStatus.error(error.toString());
      }

      await getAvailableCameras();
    }
  }

  // ─── processamento comum ─────────────────────────────────────────────────

  Future<void> _processImage(
    InputImage inputImage, {
    bool fromGallery = false,
  }) async {
    if (_disposed || status.hasError) return;

    debugPrint('[Scanner] INPUT IMAGE: ${inputImage.toJson()}');

    try {
      final barcodes = await _barcodeScanner.processImage(inputImage);

      if (_disposed || status.hasError) return;

      final value = barcodes
          .map((b) => b.displayValue)
          .firstWhere((v) => v != null && v.isNotEmpty, orElse: () => null);

      debugPrint('[Scanner] BARCODE: $value');

      if (value != null) {
        _timeoutTimer?.cancel();
        await _disposeCamera();
        _status = BarcodeScannerStatus.barcode(value);
      } else if (fromGallery) {
        // Galeria sem barcode → reinicia câmera completa com timeout
        await getAvailableCameras();
      } else {
        // Câmera sem barcode neste frame → continua o stream
        _startCameraStream();
      }
    } catch (error) {
      debugPrint('[Scanner] erro em processImage: $error');
      if (!_disposed && !status.hasBarcode) {
        if (fromGallery) {
          await getAvailableCameras();
        } else {
          _startCameraStream();
        }
      }
    }
  }

  // ─── timeout ─────────────────────────────────────────────────────────────

  void _startTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(const Duration(seconds: 15), () {
      if (!_disposed) {
        _stopStream();
        _status = BarcodeScannerStatus.error(
          'Tempo esgotado. Tente escanear novamente.',
        );
      }
    });
  }

  // ─── helpers de câmera ───────────────────────────────────────────────────

  Future<void> _stopStream() async {
    final controller = status.cameraController;

    if (controller != null &&
        controller.value.isInitialized &&
        controller.value.isStreamingImages) {
      try {
        await controller.stopImageStream();
      } catch (_) {}
    }
  }

  Future<void> _disposeCamera() async {
    await _stopStream();

    try {
      await status.cameraController?.dispose();
    } catch (_) {}
  }

  // ─── lifecycle ───────────────────────────────────────────────────────────

  Future<void> dispose() async {
    _disposed = true;
    _timeoutTimer?.cancel();
    await _disposeCamera();
    _barcodeScanner.close();
    statusNotifier.dispose();
  }
}
