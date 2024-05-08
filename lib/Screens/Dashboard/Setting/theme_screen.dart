import 'package:bible_app/Controller/settingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Menu/Language/language_constant.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/constants.dart';
import '../../../widgets/custom_widget.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode.value
          ? AppColors.bgColor.withOpacity(0.5) : AppColors.bgColor ,
      appBar: CustomWidgets.appBar(
        title: LanguageConstant.lowLight.tr,
      ),

      body: Obx(() {
        return Column(
          children: [

            /// System
            Container(
              height: 5.5.h,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: ListTile(
                onTap: () {
                  settingController.isThemeSelected.value = 0;
                  isDarkMode.value =
                      (SchedulerBinding.instance.window.platformBrightness ==
                          Brightness.dark) ;
                  themeData.write('darkmode', isDarkMode);
                },
                title: CustomWidgets.text1(
                  LanguageConstant.system.tr,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                trailing: settingController.isThemeSelected.value == 0
                    ? const Icon(Icons.done,color: AppColors.whiteColor,)
                    : const Text(" "),
              ),
            ),
            Divider(
              color: AppColors.yellowColor,
              thickness: 0.6,

            ),
            /// on
            Container(
              height: 5.5.h,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: ListTile(
                onTap: () {
                  settingController.isThemeSelected.value = 1;

                  isDarkMode.value = false;
                  themeData.write('darkmode', false);
                  Get.changeTheme(ThemeData.dark());
                },
                title: CustomWidgets.text1(
                  LanguageConstant.on.tr,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                trailing: settingController.isThemeSelected.value == 1
                    ? const Icon(Icons.done,color: AppColors.whiteColor,)
                    : const Text(" "),
              ),
            ),
            Divider(
              color: AppColors.yellowColor,
              thickness: 0.6,

            ),
            /// off
            Container(
              height: 5.5.h,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: ListTile(
                onTap: () {
                  settingController.isThemeSelected.value = 2;

                  isDarkMode.value = true;
                  themeData.write('darkmode', true);
                  Get.changeTheme(ThemeData.light());
                },
                title: CustomWidgets.text1(
                  LanguageConstant.off.tr,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
                trailing: settingController.isThemeSelected.value == 2
                    ? const Icon(Icons.done ,color: AppColors.whiteColor,)
                    : const Text(" "),
              ),
            ),
          ],
        );
      }),
    );
  }
}