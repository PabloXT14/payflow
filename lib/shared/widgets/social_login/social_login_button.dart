import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.box,
          border: Border.all(color: AppColors.stroke),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: AppColors.stroke)),
              ),
              child: SvgPicture.asset(
                AppImages.googleLogo,
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              flex: 1,
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 4,
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Entrar com Google",
                        style: AppTextStyles.textMd.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
