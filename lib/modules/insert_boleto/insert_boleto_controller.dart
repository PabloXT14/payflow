import 'package:flutter/material.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();

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
    // formKey.currentState?.validate();
  }

  void registerBoleto() {
    final form = formKey.currentState;

    if (form != null && form.validate()) {
      // ✅ Aqui você pode implementar a lógica para registrar o boleto
      // Por exemplo, salvar os dados em um banco de dados ou chamar uma API
      print('Boleto registrado com sucesso!');
    } else {
      print('Formulário inválido. Verifique os campos e tente novamente.');
    }
  }
}
