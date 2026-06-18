import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtractController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>([]);

  List<BoletoModel> get boletos => boletosNotifier.value;

  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  ExtractController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();

      final boletosString = instance.getStringList("boletos") ?? [];

      boletos = boletosString
          .map((boleto) => BoletoModel.fromJson(boleto))
          .toList();
    } catch (error) {
      boletos = [];
      print(error);
    }

    boletosNotifier.value = boletos;
  }
}
