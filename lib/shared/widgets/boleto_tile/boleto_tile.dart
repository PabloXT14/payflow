import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/bottom_sheet/edit_boleto_bottom_sheet.dart';

class BoletoTile extends StatelessWidget {
  final BoletoModel data;
  final _formatter = CurrencyTextInputFormatter.currency(
    locale: "pt_BR",
    symbol: "",
    decimalDigits: 2,
  );

  BoletoTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return EditBoletoBottomSheet(data: data);
          },
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            data.name!,
            style: AppTextStyles.headingSm.copyWith(color: AppColors.heading),
          ),
        ),
        subtitle: Text(
          'Vence em ${data.dueDate}',
          style: AppTextStyles.textSm.copyWith(color: AppColors.body),
        ),
        trailing: Text.rich(
          TextSpan(
            text: "R\$ ",
            style: AppTextStyles.textLg.copyWith(color: AppColors.heading),
            children: [
              TextSpan(
                text: _formatter.formatDouble(data.value!),
                style: AppTextStyles.textLgSemiBold.copyWith(
                  color: AppColors.heading,
                ),
              ),
            ],
          ),
        ),
        titleAlignment: ListTileTitleAlignment.top,
      ),
    );
  }
}
