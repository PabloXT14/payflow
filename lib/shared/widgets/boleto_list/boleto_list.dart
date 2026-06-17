import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';

import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile.dart';

class BoletoList extends StatefulWidget {
  const BoletoList({super.key});

  @override
  State<BoletoList> createState() => _BoletoListState();
}

class _BoletoListState extends State<BoletoList> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.boletosNotifier,
      builder: (context, boletos, child) {
        return Container(
          color: AppColors.background,
          padding: EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            spacing: 32,
            children: controller.boletos
                .map((boleto) => BoletoTile(data: boleto))
                .toList(),
          ),
        );
      },
    );
  }
}
