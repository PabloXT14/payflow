import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

import 'package:payflow/shared/widgets/social_login/social_login_button.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:signals/signals_hooks.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    print("IS_LOADING: ${controller.isLoading.value}");

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Stack(
          children: [
            Container(
              height: screenSize.height * 0.38,
              color: AppColors.primary,
            ),
            Positioned(
              // IMAGEM DA PESSOA
              top: screenSize.height * 0.08,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.person, width: 202, height: 362),
            ),
            Positioned(
              // LOGO E TEXTO
              top: screenSize.height * 0.53,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logoMini, width: 72, height: 44),
                  Padding(
                    padding: EdgeInsets.only(left: 70, right: 70, top: 20),
                    child: Text(
                      "Organize seus boletos em um só lugar",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headingLg.copyWith(
                        color: AppColors.heading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              // BOTÃO DE LOGIN
              bottom: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: SignalBuilder(
                  builder: (context) {
                    return SocialLoginButton(
                      onTap: () {
                        controller.googleSignIn(context);
                      },
                      isLoading: controller.isLoading.value,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
