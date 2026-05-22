import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_page.dart';

import 'package:payflow/shared/themes/app_colors.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(primaryColor: AppColors.primary),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
