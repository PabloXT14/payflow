import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:payflow/shared/themes/app_colors.dart';

import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key}) {
    // Trava a orientação da tela para modo retrato (portrait) e evita que o aplicativo seja exibido em modo paisagem (landscape). Só vira quando especificarmos no código.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        appBarTheme: AppBarTheme(
          // elevation: 0, // Remove the shadow (opcional)
          backgroundColor: AppColors.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/barcode_scanner': (context) => BarcodeScannerPage(),
      },
    );
  }
}
