import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';

class AuthController {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;
  List<String> _scopes = ['email'];

  var _isAuthenticated = false;
  var _user;

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

  get user => _user;

  void setUser(BuildContext context, var user) {
    if (user != null) {
      _isAuthenticated = true;
      _user = user;

      Navigator.pushReplacementNamed(context, "/home");

      return;
    }

    _isAuthenticated = false;
    _user = null;

    Navigator.pushReplacementNamed(context, "/login");
  }
}
