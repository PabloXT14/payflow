import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_page.dart';

import 'package:payflow/shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

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
      home: LoginPage(),
    );
  }
}
