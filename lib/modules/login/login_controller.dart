import 'package:payflow/services/auth_service.dart';

class LoginController {
  AuthService authService = AuthService();

  Future<void> googleSignIn() async {
    await authService.signInWithGoogle();
  }
}
