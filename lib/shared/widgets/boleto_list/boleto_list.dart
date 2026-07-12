import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:payflow/shared/models/boleto_model.dart';

import 'package:payflow/shared/widgets/boleto_tile/boleto_tile.dart';
import 'package:payflow/shared/widgets/empty_list/empty_list.dart';

class BoletoList extends StatefulWidget {
  final List<BoletoModel> boletos;
  final String? emptyListTitle;

  const BoletoList({super.key, required this.boletos, this.emptyListTitle});

  @override
  State<BoletoList> createState() => _BoletoListState();
}

class _BoletoListState extends State<BoletoList> {
  @override
  Widget build(BuildContext context) {
    return widget.boletos.isEmpty
        ? EmptyList(title: widget.emptyListTitle ?? 'Nenhum boleto cadastrado.')
        : ListView.separated(
            itemCount: widget.boletos.length,
            itemBuilder: (context, index) {
              return BoletoTile(data: widget.boletos[index])
                  .animate(delay: (index * 100).ms)
                  .fadeIn()
                  .moveX(
                    begin: 50, // Começa 50px à direita
                    end: 0, // Termina na posição original
                    duration: 400.ms, // Duração da animação
                    curve: Curves.easeOut, // Curva de animação
                  );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 32);
            },
            padding: const EdgeInsets.only(bottom: 128),
          );
  }
}
