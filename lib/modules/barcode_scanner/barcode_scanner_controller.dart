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

  void getAvailableCameras() async {
    // Lógica para obter as câmeras disponíveis
    try {
      final response = await availableCameras();

      final camera = response.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      final cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      await cameraController.initialize();

      status = BarcodeScannerStatus.available(cameraController);

      scanWithCamera();
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }
  }

  void scanWithCamera() {
    Future.delayed(Duration(seconds: 10)).then((value) {
      if (status.cameraController != null &&
          status.cameraController!.value.isStreamingImages) {
        status.cameraController!
            .stopImageStream(); // Parar o streaming de imagens para evitar processamento contínuo
      }

      status = BarcodeScannerStatus.error(
        'Tempo esgotado para leitura do código de barras. Tente novamente.',
      );
    });

    listenCamera();
  }

  void scanWithImagePicker() async {
    await status.cameraController?.stopImageStream();

    final response = await ImagePicker().pickImage(source: ImageSource.gallery);

    final inputImage = InputImage.fromFilePath(response!.path);

    scannerBarcode(inputImage);
  }

  Future<void> scannerBarcode(InputImage inputImage) async {
    try {
      if (status.cameraController != null &&
          status.cameraController!.value.isStreamingImages) {
        status.cameraController!
            .stopImageStream(); // Parar o streaming de imagens para evitar processamento contínuo
      }

      final barcodes = await barcodeScanner.processImage(inputImage);

      var barcode;

      for (Barcode item in barcodes) {
        barcode = item.displayValue; // Obter o valor do código de barras
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        status.cameraController?.dispose(); // Liberar os recursos da câmera
      } else {
        getAvailableCameras(); // Reiniciar a câmera para tentar novamente
      }

      return;
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }
  }

  void listenCamera() {
    if (status.cameraController!.value.isStreamingImages == false) {
      status.cameraController!.startImageStream((cameraImage) async {
        // Lógica para processar a imagem da câmera e prepará-la para o scanner de código de barras
        try {
          final WriteBuffer allBytes = WriteBuffer();

          for (Plane plane in cameraImage.planes) {
            allBytes.putUint8List(plane.bytes);
          }

          final bytes = allBytes.done().buffer.asUint8List();

          final Size imageSize = Size(
            cameraImage.width.toDouble(),
            cameraImage.height.toDouble(),
          );

          final InputImageRotation imageRotation =
              InputImageRotation.rotation0deg;

          // Some platforms may not provide a mapping helper; default to nv21
          final InputImageFormat inputImageFormat = InputImageFormat.nv21;

          final inputImageData = InputImageMetadata(
            size: imageSize,
            rotation: imageRotation,
            format: inputImageFormat,
            bytesPerRow: cameraImage.planes.first.bytesPerRow,
          );

          final inputImageCamera = InputImage.fromBytes(
            bytes: bytes,
            metadata: inputImageData,
          );

          await Future.delayed(Duration(seconds: 3));

          await scannerBarcode(inputImageCamera);
        } catch (error) {
          status = BarcodeScannerStatus.error(error.toString());
        }
      });
    }
  }
}
