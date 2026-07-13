import 'package:firebase_core/firebase_core.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/widgets/error_screen/error_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:payflow/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppFirebase());
}

class AppFirebase extends StatefulWidget {
  const AppFirebase({super.key});

  @override
  State<AppFirebase> createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: ErrorScreen(message: 'Erro ao inicializar o Firebase'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return AppWidget();
        }

        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
        );
      },
    );
  }
}
