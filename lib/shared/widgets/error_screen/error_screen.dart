import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class ErrorScreen extends StatelessWidget {
  final String? message;

  const ErrorScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.primary,
              size: 80,
            ),
            Text(
              message ?? 'Ocorreu um erro',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingMd.copyWith(color: AppColors.heading),
            ),
            Text(
              'Tente novamente mais tarde',
              textAlign: TextAlign.center,
              style: AppTextStyles.textMd.copyWith(color: AppColors.body),
            ),
          ],
        ),
      ),
    );
  }
}
