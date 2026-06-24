import 'package:flutter/material.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/store/boletos_store.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  BoletoModel boletoModel = BoletoModel();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome do boleto é obrigatório.';
    }
    return null;
  }

  String? validateDueDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'A data de vencimento é obrigatória.';
    }

    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      return 'A data deve seguir o formato DD/MM/AAAA.';
    }

    return null;
  }

  String? validateValue(double value) {
    if (value <= 0) {
      return 'O valor deve ser maior que zero.';
    }
    // Adicione validação de formato de valor se necessário
    return null;
  }

  String? validateBarcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'O código de barras é obrigatório.';
    }
    return null;
  }

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    boletoModel = boletoModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> saveBoletoOnStorage() async {
    await BoletosStore.instance.add(boletoModel);

    return;
  }

  Future<void> onSubmit() async {
    final form = formKey.currentState;

    if (form != null && form.validate()) {
      await saveBoletoOnStorage();
    } else {
      print('Formulário inválido. Verifique os campos e tente novamente.');
    }
  }
}
