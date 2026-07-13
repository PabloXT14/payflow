import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/widgets/app_toast/app_toast.dart';

class LoginController {
  AuthController authController = AuthController();
  final isLoading = signal<bool>(false);

  Future<void> googleSignIn(BuildContext context) async {
    isLoading.value = true;

    try {
      final response = await authController.signInWithGoogle();

      final user = UserModel(
        name: response.displayName!,
        email: response.email,
        photoUrl: response.photoUrl!,
      );

      await authController.setUser(context, user);
    } catch (error) {
      await authController.setUser(context, null);

      debugPrint('Erro ao fazer login com Google: $error');

      AppToast.error(
        context,
        "Erro ao fazer login com Google. Tente novamente mais tarde.",
      );

      return;
    } finally {
      isLoading.value = false;
    }
  }
}
