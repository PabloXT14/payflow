import 'package:flutter/material.dart';
import 'package:payflow/shared/store/user_store.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/button/button.dart';

class LogoutModal extends StatelessWidget {
  const LogoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sair da Conta", style: AppTextStyles.headingMd),
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Text.rich(
        TextSpan(
          text: "Tem certeza que deseja sair da sua conta?\n",
          style: AppTextStyles.textMd.copyWith(color: AppColors.heading),
          children: [
            TextSpan(
              text: "Seu progresso sera perdido.",
              style: AppTextStyles.textMdBold.copyWith(
                color: AppColors.heading,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          spacing: 16,
          children: [
            Button(
              label: "Cancelar",
              onTap: () {
                Navigator.of(context).pop();
              },
              variant: ButtonVariant.secondary,
            ),
            Button(
              label: "Sair",
              onTap: () async {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (_) => false,
                );
                await UserStore.instance.clear();
              },
            ),
          ],
        ),
      ],
    );
  }
}
