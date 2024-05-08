import 'package:bible_app/Controller/settingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Menu/Language/language_constant.dart';
import '../../../Utils/app_colors.dart';
import '../../../widgets/custom_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomWidgets.appBar(
          title: LanguageConstant.notification.tr,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomWidgets.text1(LanguageConstant.notification.tr,color: AppColors.whiteColor,fontWeight: FontWeight.w500),
                    CustomWidgets.text1(LanguageConstant.turnOn.tr,color: AppColors.whiteColor,fontWeight: FontWeight.w500,fontSize: 6.sp),
                  ],
                ),
                 Obx(() => Switch(
                    inactiveTrackColor: AppColors.texfeildColor,
                    value: settingController.isNotificationGet.value,
                    activeColor: AppColors.yellowColor,
                    onChanged: (bool value) {
                      setState(() {
                        settingController.isNotificationGet.value = value;
                      });
                    },
                  ))
              ],
            ),
            Divider(
              height: 30,
              color: AppColors.yellowColor,
            )
          ],
        ),
    );
  }
}