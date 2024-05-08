// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:developer';
import 'dart:io';
import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Bible/bible_bottomSheet.dart';
import 'package:bible_app/Screens/Dashboard/Bible/bible_screen.dart';
import 'package:bible_app/Screens/Dashboard/Friends/friend_screen.dart';
import 'package:bible_app/Screens/Dashboard/drawer_screen.dart';
import 'package:bible_app/Utils/Custom_Package/src/bar_item.dart';
import 'package:bible_app/Utils/Custom_Package/src/build_nav_bar.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/constants.dart';
import 'package:bible_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/dashboard_controller.dart';
import '../../Controller/language_controller.dart';
import '../../Models/signUp_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/myicon_icons.dart';
import '../../Utils/string_constant.dart';
import '../../Widgets/custom_widget.dart';
import '../../generated/assets.dart';
import 'Home/home_screen.dart';
import 'Setting/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  BibleController bibleController = Get.put(BibleController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController pageController;

  LanguageController languageController = Get.put(LanguageController());
  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      /*  if (dashboardController.selectedIndex == Get.arguments) {
        log("already tab");
        dashboardController.selectedIndex = 0.obs;
        dashboardController.selectedIndex = Get.arguments;
      } else { */
      languageController.selectedLang.value = "english";
      dashboardController.selectedIndex = Get.arguments;

      // }
    }
    callMethodOnInit();
    pageController = PageController(initialPage: dashboardController.selectedIndex.value);
    // print("[Auth Token] =====> ${LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!}");
  }

  callMethodOnInit() async {
    bibleController.getHighlight();
    bibleController.getBookmark();
    if (languageController.selectedLang.value == "english") {
      await bibleController.getLocalBible(key: "englishBible");
    } else {
      await bibleController.getLocalBible(key: "frenchBible");
    }
  }

  @override
  void dispose() {
    dashboardController.selectedIndex.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          // systemNavigationBarColor: AppColors.aapbarColor,
          // systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: isDarkMode.value ? AppColors.aapbarColor.withOpacity(0.5) : AppColors.aapbarColor,
          systemNavigationBarIconBrightness: isDarkMode.value ? Brightness.light : Brightness.dark,
        ),
        child: Obx(() {
          return WillPopScope(
            onWillPop: () async {
              dashboardController.selectedIndex.value = 0;
              return false;
            },
            child: Scaffold(
              key: _scaffoldKey,
              drawer: DrawerScreen(),
              backgroundColor: isDarkMode.value ? AppColors.bgColor.withOpacity(0.5) : AppColors.bgColor,
              appBar: CustomAppbar.appbar(
                  scaffoldKey: _scaffoldKey,
                  title: getTitle(dashboardController.selectedIndex.value),
                  ontap: () {
                    Get.toNamed(Routes.VERSE_INDEX_SCREEN, arguments: "bible")!.then((value) {
                      // bibleController.verseData.value = value;
                      // log("return value =========${bibleController.verseData.toJson()}");
                    });
                  },
                  actions: getActions(dashboardController.selectedIndex.value),
                  isBackIcon: false,
                  centerTitle: getCenterTitle(dashboardController.selectedIndex.value)),
              body: PageView(
                /*  onPageChanged: (value) {
                  log("page view index ======= $value");
                  dashboardController.selectedIndex = Get.arguments;
                }, */
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: <Widget>[_selectPage()],
              ),
              bottomNavigationBar: SizedBox(
                height: (Platform.isAndroid) ? 70 : 80,
                child: WaterDropNavBar(
                  bottomPadding: (Platform.isIOS) ? 10 : 0,
                  backgroundColor: isDarkMode.value ? AppColors.aapbarColor.withOpacity(0.5) : AppColors.aapbarColor,
                  waterDropColor: Colors.white,
                  iconSize: 16.sp,
                  onItemSelected: (int index) {
                    dashboardController.selectedIndex.value = index;
                    // pageController.animateToPage(
                    //     dashboardController.selectedIndex.value,
                    //     duration: const Duration(milliseconds: 400),
                    //     curve: Curves.easeOutQuad);
                  },
                  selectedIndex: dashboardController.selectedIndex.value,
                  barItems: <BarItem>[
                    BarItem(filledIcon: Myicon.home, outlinedIcon: Myicon.home_outline, title: LanguageConstant.home.tr),
                    BarItem(filledIcon: Myicon.bible, outlinedIcon: Myicon.bible_outline, title: LanguageConstant.bible.tr),
                    BarItem(filledIcon: Myicon.frd, outlinedIcon: Myicon.frd_outline, title: LanguageConstant.myFriend.tr),
                    BarItem(filledIcon: Myicon.setting, outlinedIcon: Myicon.setting_outline, title: LanguageConstant.setting.tr),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  /// Called when index chnage of navbarindex change and return the screen according
  _selectPage() {
    print('_selectPage --->  ${dashboardController.selectedIndex.value}');
    switch (dashboardController.selectedIndex.value) {
      case HOME_INDEX:
        return HomeScreen();
      case BIBLE_INDEX:
        return BibleScreen();
      case FRIEND_INDEX:
        return FriendScreen();
      case SETTING_INDEX:
        return SettingScreen();
      default:
    }
  }

  getCenterTitle(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return true;
      case 1:
        return true;
      case 2:
        return true;
      case 3:
        return true;
    }
  }

  getActions(int selectedIndex) {
    // print(controller.index);
    switch (selectedIndex) {
      case 0:
        return [
          Container(),
        ];
      case 1:
        return [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    BottomSheets().fontBottomSheet(context);
                  },
                  child: Image.asset(
                    Assets.iconFilter1,
                    scale: 10,
                  ),
                ),
                Container(
                  height: 10,
                  child: VerticalDivider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    BottomSheets().showDialogVolume(context);
                  },
                  child: Image.asset(
                    Assets.iconFilter2,
                    scale: 10,
                  ),
                ),
                Container(
                  height: 10,
                  child: VerticalDivider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SEARCH_SCREEN);
                    },
                    child: Image.asset(
                      Assets.iconSearch,
                      scale: 10,
                    ),
                  ),
                ),
              ],
            ),
          )
        ];
      case 2:
        return [Container()];
      case 3:
        return [Container()];
    }
  }

  getTitle(int selectedIndex) {
    // print("INDEX------->" + controller.index.toString());
    switch (dashboardController.selectedIndex.value) {
      case 0:
        return LanguageConstant.welcome.tr;
      case 1:
        // return "Genesis 1";
        return bibleController.singleVerseData.value.verseKey != null
            ? bibleController.singleVerseData.value.verseKey
            : bibleController.oldTestamentList.isNotEmpty
                ? bibleController.oldTestamentList.first.chapters!.first.verse!.first.verseKey
                : "";
      case 2:
        return LanguageConstant.myFriend.tr;
      case 3:
        return LanguageConstant.setting.tr;
    }
  }
}
