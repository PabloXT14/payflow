import 'package:flutter/material.dart';

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
  bool _showBottomSheet = false;

  void _toggleBottomSheet() {
    setState(() {
      _showBottomSheet = !_showBottomSheet;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showBottomSheet) {
      return AppBottomSheet(
        title: "Não foi possível identificar um código de barras.",
        subtitle: "Tente escanear novamente ou digite o código do seu boleto.",
        primaryLabel: "Escaneie novamente",
        primaryOnPressed: () {
          _toggleBottomSheet();
        },
        secondaryLabel: "Digitar código",
        secondaryOnPressed: () {},
      );
    }

    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1, // Gira a tela em 90 graus no sentido horário
        child: Scaffold(
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
              Expanded(flex: 2, child: Container(color: Colors.transparent)),
              Expanded(child: Container(color: AppColors.black)),
            ],
          ),
          bottomNavigationBar: SetLabelButtons(
            primaryLabel: "Inserir código do boleto ",
            primaryOnPressed: () {
              _toggleBottomSheet();
            },
            secondaryLabel: "Adicionar da galeria",
            secondaryOnPressed: () {
              _toggleBottomSheet();
            },
          ),
        ),
      ),
    );
  }
}
