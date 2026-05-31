import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class AppBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;

  const AppBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.box,
            child: Column(
              children: [
                Expanded(
                  child: Container(color: Colors.black.withValues(alpha: 0.6)),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.textMdBold.copyWith(
                              color: AppColors.heading,
                            ),
                          ),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.textMd.copyWith(
                              color: AppColors.heading,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SetLabelButtons(
                      primaryLabel: primaryLabel,
                      primaryOnPressed: primaryOnPressed,
                      enablePrimaryColor: true,
                      secondaryLabel: secondaryLabel,
                      secondaryOnPressed: secondaryOnPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
