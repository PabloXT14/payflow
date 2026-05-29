import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

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
        title: Text(
          'Escaneie o código de barras do boleto',
          style: AppTextStyles.textMd.copyWith(color: AppColors.white),
        ),
        leading: BackButton(color: AppColors.white),
      ),
      body: Center(child: Text('Barcode Scanner Page')),
    );
  }
}
