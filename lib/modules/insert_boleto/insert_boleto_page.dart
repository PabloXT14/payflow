import 'package:flutter/material.dart';

class InsertBoletoPage extends StatefulWidget {
  const InsertBoletoPage({super.key});

  @override
  State<InsertBoletoPage> createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  String? barcode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Lê o argumento passado pelo Navigator
    barcode = ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(barcode ?? 'Nenhum código recebido')),
    );
  }
}
