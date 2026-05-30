import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: LabelButton(
              label: 'Inserir código do boleto',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: LabelButton(label: 'Adicionar da galeria', onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
