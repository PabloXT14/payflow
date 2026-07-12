import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class EmptyList extends StatelessWidget {
  final String? title;

  const EmptyList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(vertical: (32)),
      child: Text(
        title ?? 'No items found',
        textAlign: TextAlign.center,
        style: AppTextStyles.textSm.copyWith(color: AppColors.body),
      ),
    );
  }
}
