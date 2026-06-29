import 'package:flutter/material.dart';

import 'package:payflow/modules/extract/extract_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list.dart';
import 'package:signals/signals_hooks.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({super.key});

  @override
  State<ExtractPage> createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = ExtractController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,

      child: Column(
        children: [
          // MEUS EXTRATOS
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Meus extratos",
                        style: AppTextStyles.headingMd.copyWith(
                          color: AppColors.heading,
                        ),
                      ),
                      SignalBuilder(
                        builder: (context) {
                          return Text(
                            "${controller.paidBoletos.value.length} pagos",
                            style: AppTextStyles.textSm.copyWith(
                              color: AppColors.body,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Divider(height: 1, color: AppColors.stroke, thickness: 1),
                  Expanded(
                    child: SignalBuilder(
                      builder: (context) {
                        return BoletoList(
                          boletos: controller.paidBoletos.value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
