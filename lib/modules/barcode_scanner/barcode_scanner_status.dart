import 'package:camera/camera.dart';

enum ScannerState { idle, cameraAvailable, barcode, error }

class BarcodeScannerStatus {
  final ScannerState state;
  final CameraController? cameraController;
  final String barcode;
  final String error;

  const BarcodeScannerStatus._({
    required this.state,
    this.cameraController,
    this.barcode = '',
    this.error = '',
  });

  // Factory constructors for different states
  const BarcodeScannerStatus.idle() : this._(state: ScannerState.idle);

  const BarcodeScannerStatus.available(CameraController cameraController)
    : this._(
        state: ScannerState.cameraAvailable,
        cameraController: cameraController,
      );

  const BarcodeScannerStatus.barcode(String value)
    : this._(state: ScannerState.barcode, barcode: value);

  const BarcodeScannerStatus.error(String message)
    : this._(state: ScannerState.error, error: message);

  bool get showCamera => state == ScannerState.cameraAvailable;
  bool get hasBarcode => state == ScannerState.barcode;
  bool get hasError => state == ScannerState.error;
}
