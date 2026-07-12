import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/button/button.dart';
import 'package:payflow/shared/models/boleto_model.dart';

class DeleteBoletoModal extends StatelessWidget {
  final BoletoModel data;
  final Future<void> Function() onConfirm;

  const DeleteBoletoModal({
    super.key,
    required this.data,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Deletar boleto", style: AppTextStyles.headingMd),
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Text.rich(
        TextSpan(
          text: "Tem certeza que deseja deletar o boleto ",
          style: AppTextStyles.textMd.copyWith(color: AppColors.heading),
          children: [
            TextSpan(
              text: "${data.name}?",
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
              label: "Deletar",
              onTap: () async {
                Navigator.of(context).pop();
                await onConfirm();
              },
            ),
          ],
        ),
      ],
    );
  }
}
