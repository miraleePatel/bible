import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/constants.dart';

class CustomAppbar {
  static AppBar appbar({
     GlobalKey<ScaffoldState>? scaffoldKey,
    required String title,
    bool? centerTitle,
    bool isBackIcon = false,
    List<Widget>? actions,
    Function()? ontap,
    BuildContext? context,
  }) {
    return AppBar(
      // backgroundColor: AppColors.aapbarColor,
      backgroundColor: isDarkMode.value
          ? AppColors.aapbarColor.withOpacity(0.5) : AppColors.aapbarColor ,
      elevation: 3,
      centerTitle: centerTitle ?? true,
      title: InkWell(
        onTap: ontap,
        child: CustomWidgets.text1(
          title,
         fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1,
        ),
      ),
      leading: isBackIcon
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
              ),
            )
          : InkWell(
              onTap: () {
                scaffoldKey!.currentState!.openDrawer();
              },
              child: Image.asset(
                Assets.iconMenu,
                scale: 8,
              ),
            ),
      actions: actions ?? [Container()],
    );
  }
}
