import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'package:payflow/shared/widgets/bottom_sheet/app_bottom_sheet.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    super.initState();

    controller.getAvailableCameras();

    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        // ✅ Garante que o widget ainda está montado antes de navegar
        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          "/insert_boleto",
          arguments: controller.status.barcode,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, _) {
              if (status.showCamera) {
                return Container(
                  child: status.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1, // Gira a tela em 90 graus no sentido horário
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: AppColors.black,
                centerTitle: true,
                title: Text(
                  'Escaneie o código de barras do boleto',
                  style: AppTextStyles.textMd.copyWith(color: AppColors.white),
                ),
                leading: BackButton(color: AppColors.white),
              ),
              body: Column(
                children: [
                  Expanded(child: Container(color: AppColors.black)),
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.transparent),
                  ),
                  Expanded(child: Container(color: AppColors.black)),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Inserir código do boleto ",
                primaryOnPressed: () {},
                secondaryLabel: "Adicionar da galeria",
                secondaryOnPressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, _) {
              if (status.hasError) {
                return AppBottomSheet(
                  title: "Não foi possível identificar um código de barras.",
                  subtitle:
                      "Tente escanear novamente ou digite o código do seu boleto.",
                  primaryLabel: "Escaneie novamente",
                  primaryOnPressed: () {
                    controller.getAvailableCameras();
                  },
                  secondaryLabel: "Digitar código",
                  secondaryOnPressed: () {},
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
