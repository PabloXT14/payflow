import 'package:flutter/material.dart';
import 'package:payflow/modules/my_boletos/my_boletos_page.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/shared/models/user_model.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

import 'package:payflow/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final pages = [MyBoletosPage(), ExtractPage()];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller.loadBoletosFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(184),
        child: Container(
          height: 152,
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
                      text: widget.user.name,
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
                  image: DecorationImage(
                    image: NetworkImage(widget.user.photoUrl ?? ""),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      extendBody: true,
      body: pages[controller.currentPageIndex],
      bottomNavigationBar: Container(
        height: 149,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.background,
              AppColors.background.withValues(alpha: 0.5),
              AppColors.background.withValues(alpha: 0.0),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 56,
          children: [
            IconButton(
              onPressed: () {
                controller.changePage(0);
                setState(() {});
              },
              icon: Icon(
                Icons.home,
                size: 24,
                color: controller.currentPageIndex == 0
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/barcode_scanner');
                Navigator.pushNamed(context, '/barcode_scanner');
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  size: 24,
                  color: AppColors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.changePage(1);
                setState(() {});
              },
              icon: Icon(
                Icons.description_outlined,
                size: 24,
                color: controller.currentPageIndex == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
