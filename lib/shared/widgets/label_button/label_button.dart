import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  const LabelButton({
    super.key,
    required this.label,
    this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.box),
          shape: WidgetStatePropertyAll(LinearBorder()),
          overlayColor: WidgetStatePropertyAll(
            AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.textMd
              .copyWith(color: AppColors.heading)
              .merge(textStyle),
        ),
      ),
    );
  }
}
