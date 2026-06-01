import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;

  CameraController? cameraController;

  BarcodeScannerStatus({
    this.isCameraAvailable = false,
    this.cameraController,
    this.error = '',
    this.barcode = '',
  });

  factory BarcodeScannerStatus.available(CameraController cameraController) =>
      BarcodeScannerStatus(
        isCameraAvailable: true,
        cameraController: cameraController,
      );

  factory BarcodeScannerStatus.error(String errorMessage) =>
      BarcodeScannerStatus(error: errorMessage);

  factory BarcodeScannerStatus.barcode(String barcode) =>
      BarcodeScannerStatus(barcode: barcode);

  bool get showCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
