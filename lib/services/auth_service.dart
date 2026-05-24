import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;
  List<String> scopes = ['email'];

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

  Future<void> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    try {
      // Autenticar com o Google
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: scopes,
      );
      print("Login com Google: $account");
    } on GoogleSignInException catch (error) {
      print('Erro ao fazer login com Google: $error');
    }
  }
}
