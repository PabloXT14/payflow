import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  var currentPageIndex = 0;

  void changePage(int index) {
    currentPageIndex = index;

    print(currentPageIndex);
  }

  Future<void> loadBoletosFromStorage() async {
    final instance = await SharedPreferences.getInstance();

    final boletos = instance.getStringList('boletos') ?? [];

    print('Boletos carregados: $boletos');

    return;
  }
}
