import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Home')));
  }
}
