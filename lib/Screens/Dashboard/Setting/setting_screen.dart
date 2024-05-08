import 'package:bible_app/Controller/settingController.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Screens/Dashboard/Setting/hive_demo_screen.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Controller/bible_controller.dart';
import '../../../Controller/tts_player_controller.dart';
import '../../../Utils/constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = Get.put(SettingController());
  BibleController bibleController = Get.put(BibleController());
  TTSPlayerController ttsPlayerController = Get.put(TTSPlayerController());

  @override
  void initState() {
    // TODO: implement initState
    // callMethodOnInit();
    // bibleController.  AllBibleData();

    super.initState();
  }


  callMethodOnInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // bibleController.getBibleData(testament: "OT");
      // Add Your Code here.

    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// account
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: CustomWidgets.text1(LanguageConstant.account.tr,
                fontSize: 13.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),

          /// edit profile
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
              },
              child: CustomWidgets.text1(LanguageConstant.editProfile.tr,
                  fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
            ),
          ),

          /*   /// notification
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            child: InkWell(
              onTap: (){
                Get.toNamed(Routes.NOTIFICATION_SCREEN);
              },
              child: CustomWidgets.text1(LanguageConstant.notificationSetting,
                  fontSize: 9.sp,
                  color: AppColors.whiteColor,
                    fontWeight: FontWeight.w300,
                  letterSpacing: 1),
            ),
          ),*/

          /// remove ads
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HiveDemoScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
              child: CustomWidgets.text1(LanguageConstant.removeAds.tr,
                  fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
            ),
          ),
          Divider(
            color: AppColors.yellowColor,
            thickness: 0.6,
            height: 4.h,
          ),

          /// genereal
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: CustomWidgets.text1(LanguageConstant.general.tr,
                fontSize: 13.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),

          /// language
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.LANGUAGE_SCREEN);
              },
              child: CustomWidgets.text1(LanguageConstant.language.tr,
                  fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
            ),
          ),
          /* Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            child: CustomWidgets.text1(LanguageConstant.dynamicFeature,
                fontSize: 9.sp,
                color: AppColors.whiteColor,
                  fontWeight: FontWeight.w300,
                letterSpacing: 1),
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            child: CustomWidgets.text1(LanguageConstant.downloadImage.tr,
                fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
            child: CustomWidgets.text1(LanguageConstant.autoDetect.tr,
                fontSize: 9.sp, color: AppColors.texfeildColor, fontWeight: FontWeight.w300, letterSpacing: 1),
          ),

          /*      /// theme
          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.THEME_SCREEN);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
              child: CustomWidgets.text1(LanguageConstant.lowLight.tr,
                  fontSize: 9.sp,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
            child: CustomWidgets.text1(LanguageConstant.off.tr,
                fontSize: 9.sp,
                color: AppColors.texfeildColor,
                fontWeight: FontWeight.w300,
                letterSpacing: 1),
          ),*/
          Divider(
            color: AppColors.yellowColor,
            thickness: 0.6,
            height: 4.h,
          ),

          /// bible reading
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: CustomWidgets.text1(LanguageConstant.bibleReading.tr,
                fontSize: 13.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: CustomWidgets.text1(LanguageConstant.font.tr,
                fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomWidgets.text1(LanguageConstant.audioTrackingBar.tr,
                        fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600, letterSpacing: 1),
                    CustomWidgets.text1(LanguageConstant.whenAvailable.tr,
                        fontSize: 8.5.sp, color: AppColors.texfeildColor, fontWeight: FontWeight.w300, letterSpacing: 1),
                  ],
                ),
              ),
              Obx(() => Switch(
                    inactiveTrackColor: AppColors.texfeildColor,
                    value: ttsPlayerController.isShowScrollIndi.value,
                    activeColor: AppColors.yellowColor,
                    onChanged: (bool value) {
                      setState(() {
                        ttsPlayerController.isShowScrollIndi.value = value;
                      });
                    },
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: CustomWidgets.text1(LanguageConstant.clearSearch.tr,
                fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: CustomWidgets.text1(LanguageConstant.manageFont.tr,
                fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: CustomWidgets.text1(LanguageConstant.manageVersion.tr,
                fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
          ),
          Divider(
            color: AppColors.yellowColor,
            thickness: 0.6,
            height: 4.h,
          ),

          /// Notification
          ///
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomWidgets.text1(LanguageConstant.notification.tr,
                        fontSize: 12.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600, letterSpacing: 1),
                    Container(
                      width: 70.w,
                      child: CustomWidgets.text1(LanguageConstant.turnOn.tr,
                          fontSize: 7.5, color: AppColors.texfeildColor, fontWeight: FontWeight.w300, maxLine: 2, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
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

          SizedBox(
            height: 1.h,
          ),
          Divider(
            color: AppColors.yellowColor,
            thickness: 0.6,
            height: 4.h,
          ),

          /// more
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: CustomWidgets.text1(LanguageConstant.more.tr,
                fontSize: 13.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: CustomWidgets.text1(LanguageConstant.clearLocalCache.tr,
                fontSize: 9.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w300, letterSpacing: 1),
          ),

          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }
}
