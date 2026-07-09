import 'package:signals/signals.dart';

import 'package:payflow/shared/store/boletos_store.dart';

class MyBoletosController {
  final _boletosStore = BoletosStore.instance;

  late final unpaidBoletos = computed(() {
    return _boletosStore.boletos.value
        .where((boleto) => boleto.paid == false)
        .toList();
  });
}
