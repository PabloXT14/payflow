import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

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
    return ListTile(
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
    );

    // return Container(
    //   width: double.maxFinite,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Column(
    //         spacing: 6,
    //         children: [
    //           Text(
    //             'Tia maria',
    //             style: AppTextStyles.headingSm.copyWith(
    //               color: AppColors.heading,
    //             ),
    //           ),
    //           Text(
    //             'Vence em 16/11/26',
    //             style: AppTextStyles.textSm.copyWith(color: AppColors.body),
    //           ),
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             'R\$ ',
    //             style: AppTextStyles.textLg.copyWith(color: AppColors.heading),
    //           ),
    //           Text(
    //             '2.131,33',
    //             style: AppTextStyles.textLgSemiBold.copyWith(
    //               color: AppColors.heading,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
