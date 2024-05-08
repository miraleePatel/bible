import 'dart:io';

import 'package:bible_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/custom_widget.dart';

const int HOME_INDEX = 0;
const int BIBLE_INDEX = 1;
const int FRIEND_INDEX = 2;
const int SETTING_INDEX = 3;

final themeData = GetStorage();
RxBool isDarkMode = false.obs;
RxBool isDark = false.obs;
RxString boxPath = ''.obs;
List boxNameList = [];

///
/// Show progress indicator when API call Or any other async method call
///
showProgressIndicator() {
  return EasyLoading.show(
    maskType: EasyLoadingMaskType.black,
    status: 'Loading',
    dismissOnTap: false,
  );
}

///
/// Dismiss progress indicator after API calling Or any other async method calling
///
dismissProgressIndicator() {
  return EasyLoading.dismiss();
}

///
/// Snackbar for showing error message
///
errorSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Error',
        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.0, fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      // backgroundColor: Colors.red.withOpacity(0.80),
      backgroundColor: AppColors.errorSnackColor,
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(
        seconds: 3,
      ),
    ),
  );
}

///
/// Snackbar for showing success message
///
successSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Success',
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.0, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message!,
        style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.0, fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      // backgroundColor: Colors.green.withOpacity(0.80),
      backgroundColor: AppColors.suscessSnackColor,
      icon: const Icon(Icons.task_alt_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

informationSnackBar({String? title, String? message,IconData? icon,}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      title: title,
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.infoSnackColor.withOpacity(0.8),
      icon:  Icon( icon ?? Icons.copy, size: 25.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}
/// color convert in to string
String colorToHex(Color color) {
  return '#' + color.value.toRadixString(16).substring(2).toUpperCase();
}
/// convert hexa to flutter color code
Color hexToColor(String hexColor) {
  final buffer = StringBuffer();
  if (hexColor.length == 6 || hexColor.length == 7) {
    buffer.write('ff'); // Add alpha channel if missing
  }
  buffer.write(hexColor.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
// Open hive box
Future<Box> openBox({required String boxName}) async {
  if (boxPath.value.isEmpty || boxPath.value == '') {
    Directory dir = await getApplicationDocumentsDirectory();
    boxPath.value = dir.path;
    print('[Box Path] => ${boxPath.value}');
  }
  Hive.init(boxPath.value);
  Box box = await Hive.openBox(boxName);
  boxNameList.add(boxName);
  boxNameList = boxNameList.toSet().toList();
  return box;
}


alertDialogWidget({required BuildContext context, void Function()? onPressed}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          scrollable: true,
          backgroundColor: AppColors.whiteColor,
          elevation: 5,
          title: Column(
            children: [
              Center(child: CustomWidgets.text1('Logout',fontSize: 13.sp,fontWeight: FontWeight.w600,color: AppColors.bgColor)),
              Container(height: 1.h,),
              Divider(color: AppColors.bgColor ,)
            ],
          ),
          content: Column(
            children: [

              Center(child: CustomWidgets.text1('Are you sure that you want to logout?',fontWeight: FontWeight.w500, fontSize: 9.sp)),
              Container(height: 2.h,)
            ],
          ),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.all(10),
          actionsAlignment: MainAxisAlignment.center,
          buttonPadding: EdgeInsets.all(20),

          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), border: Border.all(color: AppColors.bgColor)),
                      child: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: CustomWidgets.text1('Cancel', color: AppColors.bgColor,fontSize: 8.sp)),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      height: 5.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColors.bgColor),
                      child: MaterialButton(onPressed: onPressed, child: CustomWidgets.text1('Logout', color: AppColors.whiteColor,fontSize: 8.sp)),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ],
        );
      });
}
