import 'package:flutter/material.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  AuthController authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final response = await authController.signInWithGoogle();

      final user = UserModel(
        name: response.displayName!,
        email: response.email,
        photoUrl: response.photoUrl!,
      );

      authController.setUser(context, user);
    } catch (error) {
      authController.setUser(context, null);

      print('Erro ao fazer login com Google: $error');

      return;
    }
  }
}
