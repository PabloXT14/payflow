import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

import 'package:payflow/shared/models/boleto_model.dart';

class BoletosStore {
  BoletosStore._();

  static final instance = BoletosStore._();

  final boletos = signal<List<BoletoModel>>([]);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList('boletos') ?? [];

    boletos.value = raw.map((e) => BoletoModel.fromJson(e)).toList();
  }

  Future<void> add(BoletoModel boleto) async {
    final prefs = await SharedPreferences.getInstance();
    final boletesUpdated = [boleto, ...boletos.value];

    boletos.value =
        boletesUpdated; // notifica automaticamente quem estiver observando

    await prefs.setStringList(
      'boletos',
      boletesUpdated.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> markBoletoAsPaid(BoletoModel boleto) async {
    final prefs = await SharedPreferences.getInstance();

    final boletesUpdated = boletos.value.map((b) {
      if (b.id == boleto.id) {
        return b.copyWith(paid: true);
      }
      return b;
    }).toList();

    boletos.value = boletesUpdated;

    await prefs.setStringList(
      'boletos',
      boletesUpdated.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    boletos.value = [];

    await prefs.remove('boletos');
  }
}
