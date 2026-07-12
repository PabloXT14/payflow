import 'package:payflow/shared/store/boletos_store.dart';
import 'package:signals/signals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:payflow/shared/models/user_model.dart';

class UserStore {
  UserStore._();

  static final instance = UserStore._();

  final user = signal<UserModel?>(null);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("user")) {
      return;
    }

    final json = prefs.getString("user") as String;

    user.value = UserModel.fromJson(json);
  }

  Future<void> save(UserModel newUser) async {
    final prefs = await SharedPreferences.getInstance();

    user.value = newUser;

    await prefs.setString("user", newUser.toJson());
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("user");
    await BoletosStore.instance.clear();

    user.value = null;
  }
}
