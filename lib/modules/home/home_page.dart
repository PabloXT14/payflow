import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(184),
        child: Container(
          height: 184,
          color: AppColors.primary,
          child: Padding(
            padding: EdgeInsets.only(left: 24, top: 48, right: 24),
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "Olá, ",
                  style: AppTextStyles.headingMdRegular.copyWith(
                    color: AppColors.white,
                  ),
                  children: [
                    TextSpan(
                      text: "John",
                      style: AppTextStyles.headingMd.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                "Mantenha suas contas em dia",
                style: AppTextStyles.textSm.copyWith(color: AppColors.box),
              ),
              trailing: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
