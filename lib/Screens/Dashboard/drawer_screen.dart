// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Controller/authentication_controller.dart';
import 'package:bible_app/Models/signUp_model.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/string_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/dashboard_controller.dart';
import '../../Models/signUp_model.dart' as userdata;
import '../../Utils/app_colors.dart';
import '../../Utils/constants.dart';
import '../../generated/assets.dart';
import '../../widgets/custom_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  AuthenticationController authenticationController = Get.put(AuthenticationController());
  userdata.Data currentUser = userdata.Data();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = LoginSuccessModel.fromJson(GetStorage().read(userData)).data!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizerUtil.deviceType == DeviceType.tablet ? 60.w : 75.w,
      child: Drawer(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(color: AppColors.bgColor),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 7.h),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      CustomWidgets.shimmerImage( image:
                      APIManager.baseUrl + currentUser.profileImage.toString()),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomWidgets.text1(
                            currentUser.userName.toString(),
                            // "Bible genesis",
                            color: AppColors.whiteColor,
                            fontSize: SizerUtil.deviceType == DeviceType.tablet ? 10 : 12,
                            height: 1,

                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: 160,
                            child: CustomWidgets.text1(
                              currentUser.email.toString(),
                              // "bible@genesis.com",
                              color: AppColors.whiteColor,
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                              fontSize: SizerUtil.deviceType == DeviceType.tablet ? 10 : 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),

                      /*  SizedBox(
                        width: 13.w,
                      ), */

                      /// logout
                      GestureDetector(
                          onTap: () async {
                            alertDialogWidget(context:context,onPressed: () async {
                              authenticationController.logout(context);
                              await GoogleSignIn().signOut();
                              await FacebookLogin().logOut();
                            });

                          },
                          child: Image.asset(
                            Assets.iconMenuLogout,
                            scale: 7,
                          )),
                      SizedBox(
                        width: 3.w,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.greyColor,
                ),
                /// home
                DrawerItem(
                  title: LanguageConstant.home.tr,
                  icon: Assets.iconMenuHome,
                  callback: (index) {
                    dashboardController.selectedIndex.value = 0;
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// bible
                DrawerItem(
                  title: LanguageConstant.bible.tr,
                  icon: Assets.iconMenuBible,
                  callback: (index) {
                    dashboardController.selectedIndex.value = 1;
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// myHighlight
                DrawerItem(
                  title: LanguageConstant.myHighlight.tr,
                  icon: Assets.iconMenuHlighlight,
                  callback: (index) {
                    Get.toNamed(Routes.HIGHLIGHT_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// myBookmarks
                DrawerItem(
                  title: LanguageConstant.myBookmarks.tr,
                  icon: Assets.iconMenuBookmark,
                  callback: (index) {
                    Get.toNamed(Routes.BOOKMARK_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// myNotes
                DrawerItem(
                    title: LanguageConstant.myNotes.tr,
                    icon: Assets.iconMenuNote,
                    callback: (index) {
                      Get.toNamed(Routes.NOTES_SCREEN);
                    }
                    // callbackIndex: HOME_INDEX,
                    ),
                SizedBox(
                  height: 1.h,
                ),
                /// myVideo
                DrawerItem(
                  title: LanguageConstant.myVideo.tr,
                  icon: Assets.iconMenuVideo,
                  callback: (index) {
                    Get.toNamed(Routes.MY_VIDEO_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// myPhoto
                DrawerItem(
                  title: LanguageConstant.myPhoto.tr,
                  icon: Assets.iconMenuPhoto,
                  callback: (index) {
                    Get.toNamed(Routes.MY_PHOTOS_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// myFriend
                DrawerItem(
                  title: LanguageConstant.myFriend.tr,
                  icon: Assets.iconMenuFrd,
                  callback: (index) {
                    dashboardController.selectedIndex.value = 2;
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// myAudio
                DrawerItem(
                  title: LanguageConstant.myAudio.tr,
                  icon: Assets.iconMenuAudio,
                  callback: (index) {
                    Get.toNamed(Routes.MY_AUDIO_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// setting
                DrawerItem(
                  title: LanguageConstant.setting.tr,
                  icon: Assets.iconMenuSetting,
                  callback: (index) {
                    dashboardController.selectedIndex.value = 3;
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// verseOfDay
                DrawerItem(
                  title: LanguageConstant.verseOfDay.tr,
                  icon: Assets.iconMenuVofday,
                  callback: (index) {
                    Get.toNamed(Routes.VERSE_DAY_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// aboutUs
                DrawerItem(
                  title: LanguageConstant.aboutUs.tr,
                  icon: Assets.iconMenuAbout,
                  callback: (index) {},
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// topic
                DrawerItem(
                  title: LanguageConstant.topic.tr,
                  icon: Assets.iconMenuTopic,
                  callback: (index) {
                    Get.toNamed(Routes.TOPIC_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// language
                DrawerItem(
                  title: LanguageConstant.language.tr,
                  icon: Assets.iconMenuLanguage,
                  callback: (index) {
                    Get.toNamed(Routes.LANGUAGE_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// version
                DrawerItem(
                  title: LanguageConstant.version.tr,
                  icon: Assets.iconMenuVersion,
                  callback: (index) {
                    Get.toNamed(Routes.VERSE_INDEX_SCREEN, arguments: "version");
                  },

                ),
                SizedBox(
                  height: 1.h,
                ),
                /// removeAds
                DrawerItem(
                  title: LanguageConstant.removeAds.tr,
                  icon: Assets.iconMenuRads,
                  callback: (index) {},
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// shareApp
                DrawerItem(
                  title: LanguageConstant.shareApp.tr,
                  icon: Assets.iconMenuShare,
                  callback: (index) {},
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// readingProgress
                DrawerItem(
                  title: LanguageConstant.readingProgress.tr,
                  icon: Assets.iconReadingProgress,
                  callback: (index) {
                    Get.toNamed(Routes.READING_PROGRESS_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 1.h,
                ),
                /// searchMenu
                DrawerItem(
                  title: LanguageConstant.searchMenu.tr,
                  icon: Assets.iconSearch,
                  callback: (index) {
                    Get.toNamed(Routes.SEARCH_SCREEN);
                  },
                  // callbackIndex: HOME_INDEX,
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key, this.title, this.callback, this.callbackIndex, this.icon, this.notificationCOunt}) : super(key: key);

  final String? title;
  final String? icon;
  final Function(int?)? callback;
  final int? callbackIndex;
  final int? notificationCOunt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
        Get.back();
        return callback!(callbackIndex);
      },
      child: Container(
        margin: EdgeInsets.only(top: 2.2.h),
        padding: EdgeInsets.only(left: 5.5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.0.h,
              width: 3.0.h,
              child: Image.asset(
                icon!,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(width: 4.0.w),
            CustomWidgets.text1(
              title!,
              color: AppColors.whiteColor,
              fontSize: SizerUtil.deviceType == DeviceType.tablet ? 10 : 11,
              fontWeight: FontWeight.w400,
              height: SizerUtil.deviceType == DeviceType.tablet ? 0.7 : 1.2,
            ),
          ],
        ),
      ),
    );
  }
}
