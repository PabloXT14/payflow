import 'package:flutter/material.dart';
import 'package:signals/signals_hooks.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:payflow/modules/my_boletos/my_boletos_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list.dart';

class MyBoletosPage extends StatefulWidget {
  const MyBoletosPage({super.key});

  @override
  State<MyBoletosPage> createState() => _MyBoletosPageState();
}

class _MyBoletosPageState extends State<MyBoletosPage> {
  final controller = MyBoletosController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,

      child: Column(
        children: [
          // HEADER
          Stack(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                color: AppColors.primary,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SignalBuilder(
                  builder: (context) {
                    return BoletoInfo(
                          totalBoletos: controller.unpaidBoletos.value.length,
                        )
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .moveY(
                          begin: -50, // Começa 50px acima
                          end: 0, // Termina na posição original
                          duration: 400.ms, // Duração da animação
                          curve: Curves.easeOut, // Curva de animação
                        );
                  },
                ),
              ),
            ],
          ),

          // MEUS BOLETOS
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,

                children: [
                  Row(
                    children: [
                      Text(
                        "Meus boletos",
                        style: AppTextStyles.headingMd.copyWith(
                          color: AppColors.heading,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1, color: AppColors.stroke, thickness: 1),
                  Expanded(
                    child: SignalBuilder(
                      builder: (context) {
                        return BoletoList(
                          boletos: controller.unpaidBoletos.value,
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
