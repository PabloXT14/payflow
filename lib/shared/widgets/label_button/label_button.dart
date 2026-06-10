import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const LabelButton({
    super.key,
    required this.label,
    this.onPressed,
    this.textStyle,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(LinearBorder()),
          overlayColor: WidgetStatePropertyAll(
            AppColors.primary.withValues(alpha: 0.3),
          ),
        ).merge(buttonStyle),
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
