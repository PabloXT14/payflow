import 'package:payflow/shared/store/boletos_store.dart';
import 'package:signals/signals_hooks.dart';

class ExtractController {
  final _boletosStore = BoletosStore.instance;

  late final paidBoletos = computed(() {
    return _boletosStore.boletos.value
        .where((boleto) => boleto.paid == true)
        .toList();
  });
}
