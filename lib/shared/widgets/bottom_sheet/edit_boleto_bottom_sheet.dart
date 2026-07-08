import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/format_currency.dart';
import 'package:payflow/shared/widgets/button/button.dart';

class EditBoletoBottomSheet extends StatefulWidget {
  final BoletoModel data;

  const EditBoletoBottomSheet({super.key, required this.data});

  @override
  State<EditBoletoBottomSheet> createState() => _EditBoletoBottomSheetState();
}

class _EditBoletoBottomSheetState extends State<EditBoletoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Draggable indicator
          Container(
            width: 43,
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.input,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          // Text
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "O boleto ",
                style: AppTextStyles.headingMdRegular.copyWith(
                  color: AppColors.heading,
                ),
                children: [
                  TextSpan(
                    text: "${widget.data.name}\n",
                    style: AppTextStyles.headingMd.copyWith(
                      color: AppColors.heading,
                    ),
                  ),
                  TextSpan(
                    text: "no valor de R\$ ",
                    style: AppTextStyles.headingMdRegular.copyWith(
                      color: AppColors.heading,
                    ),
                  ),
                  TextSpan(
                    text: "${formatCurrency(value: widget.data.value!)}\n",
                    style: AppTextStyles.headingMd.copyWith(
                      color: AppColors.heading,
                    ),
                  ),
                  TextSpan(
                    text: "foi pago?",
                    style: AppTextStyles.headingMdRegular.copyWith(
                      color: AppColors.heading,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Button(
                  label: "Ainda não",
                  onTap: () {},
                  variant: ButtonVariant.secondary,
                ),
                Button(label: "Sim", onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
