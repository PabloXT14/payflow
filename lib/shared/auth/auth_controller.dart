import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:payflow/shared/models/user_model.dart';

class AuthController {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;
  final List<String> _scopes = ['email'];

  UserModel? _user;

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

  UserModel? get user => _user;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      storeUser(user);

      _user = user;

      Navigator.pushReplacementNamed(context, "/home", arguments: user);

      return;
    }

    _user = null;

    Navigator.pushReplacementNamed(context, "/login");
  }

  Future<void> storeUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setString("user", user.toJson());

    return;
  }

  Future<void> getStoredUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();

    if (!instance.containsKey("user")) {
      setUser(context, null);
      return;
    }

    final json = instance.getString("user") as String;

    setUser(context, UserModel.fromJson(json));

    return;
  }
}
