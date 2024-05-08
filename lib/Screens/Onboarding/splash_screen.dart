import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/network_controller.dart';
import '../../Routes/routes.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/string_constant.dart';
import '../../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NetworkController networkController = Get.put(NetworkController(), permanent: true);

  @override
  void initState() {
    // navigatToRoute();
    Get.offAllNamed(Routes.SHARE_IMAGE_SCREEN);
    super.initState();
  }

  ///
  /// navigate according login users
  ///
  navigatToRoute() async {
    if (GetStorage().read(onboarding) == null || GetStorage().read(onboarding) == false) {
      Future.delayed(
        const Duration(seconds: 3),
      ).then((value) async {
        Get.offAllNamed(Routes.ONBOADING_SCREEN);
      });
    } else {
      if (GetStorage().read(userData) != null) {
        Future.delayed(
          const Duration(seconds: 3),
        ).then((value) async {
          bool exists = await Hive.boxExists(bibleDataBox);
          if(exists == true){
            print(exists);
            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
          }else{ print(exists);
          Get.offAllNamed(Routes.LOCAL_ALERT_SCREEN);
          }
          // Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        });
      } else {
        Future.delayed(
          const Duration(seconds: 3),
        ).then((value) async {
          // Get.offAllNamed(Routes.LOGIN_SCREEN);
          Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.aapbarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Image.asset(
                Assets.imagesOnboadingVerse,
                scale: 3,
              )),
        ),
      ),
    );
  }
}
