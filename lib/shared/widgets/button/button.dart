import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

enum ButtonVariant { primary, secondary }

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ButtonVariant variant;

  const Button({
    super.key,
    required this.label,
    required this.onTap,
    this.variant = ButtonVariant.primary,
  });

  Color _getBackgroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.primary;
      case ButtonVariant.secondary:
        return AppColors.box;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.white;
      case ButtonVariant.secondary:
        return AppColors.secondary;
    }
  }

  BorderSide? _getBorder() {
    switch (variant) {
      case ButtonVariant.primary:
        return BorderSide.none;
      case ButtonVariant.secondary:
        return BorderSide(color: AppColors.stroke, width: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 56,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: _getBackgroundColor(),
            foregroundColor: _getForegroundColor(),
            side: _getBorder(),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.textMd,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
