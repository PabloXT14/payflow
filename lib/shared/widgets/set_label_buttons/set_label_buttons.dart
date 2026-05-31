import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';

import 'package:payflow/shared/widgets/divider/divider_vertical.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;

  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;

  final bool enablePrimaryColor;

  const SetLabelButtons({
    super.key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.stroke)),
      ),
      child: Row(
        children: [
          Expanded(
            child: LabelButton(
              label: primaryLabel,
              onPressed: primaryOnPressed,
              textStyle: enablePrimaryColor
                  ? TextStyle(color: AppColors.primary)
                  : null,
            ),
          ),
          DividerVertical(),
          Expanded(
            child: LabelButton(
              label: secondaryLabel,
              onPressed: secondaryOnPressed,
            ),
          ),
        ],
      ),
    );
  }
}
