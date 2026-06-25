import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/models/user_model.dart';

import 'package:payflow/shared/store/user_store.dart';

class AuthController {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;
  final List<String> _scopes = ['email'];

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (error) {
      print('Erro ao inicializar o Google Sign-In: $error');
    }
  }

  // Sempre verifique a inicialização do login do Google antes de usar
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    try {
      // Autenticar com o Google
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: _scopes,
      );

      return account;
    } on GoogleSignInException catch (error) {
      print('Erro ao fazer login com Google: $error');
      rethrow;
    }
  }

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      UserStore.instance.save(user);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> getStoredUser(BuildContext context) async {
    await UserStore.instance.load();

    final storedUser = UserStore.instance.user.value;

    if (storedUser != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }

    return;
  }
}
