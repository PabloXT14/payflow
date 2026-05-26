import 'package:flutter/material.dart';
import 'package:payflow/shared/auth/auth_controller.dart';

class LoginController {
  AuthController authService = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final response = await authService.signInWithGoogle();
      authService.setUser(context, response);
    } catch (error) {
      authService.setUser(context, null);

      print('Erro ao fazer login com Google: $error');

      return;
    }
  }
}
