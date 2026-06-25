import 'package:signals/signals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:payflow/shared/models/user_model.dart';

class UserStore {
  UserStore._();

  static final instance = UserStore._();

  final user = signal<UserModel?>(null);

  Future<void> load() async {
    final instance = await SharedPreferences.getInstance();

    final json = instance.getString("user") as String;

    user.value = UserModel.fromJson(json);
  }

  Future<void> save(UserModel newUser) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setString("user", newUser.toJson());

    user.value = newUser;
  }
}
