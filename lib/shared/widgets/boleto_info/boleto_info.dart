import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class BoletoInfo extends StatelessWidget {
  final int totalBoletos;

  const BoletoInfo({super.key, required this.totalBoletos});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        spacing: 24,
        children: [
          Image.asset(
            AppImages.logoMini,
            color: AppColors.background,
            width: 56,
            height: 34,
          ),
          Container(width: 1, height: 32, color: AppColors.background),
          Text.rich(
            TextSpan(
              text: "Você tem ",
              style: AppTextStyles.textSm.copyWith(color: AppColors.white),
              children: [
                TextSpan(
                  text: "$totalBoletos boletos\n",
                  style: AppTextStyles.textSmBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text: "cadastrados para pagar",
                  style: AppTextStyles.textSm.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
