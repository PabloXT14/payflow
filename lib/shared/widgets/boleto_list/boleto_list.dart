import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';

import 'package:payflow/shared/widgets/boleto_tile/boleto_tile.dart';

class BoletoList extends StatefulWidget {
  final List<BoletoModel> boletos;

  const BoletoList({super.key, required this.boletos});

  @override
  State<BoletoList> createState() => _BoletoListState();
}

class _BoletoListState extends State<BoletoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: widget.boletos
          .map((boleto) => BoletoTile(data: boleto))
          .toList(),
    );
  }
}
