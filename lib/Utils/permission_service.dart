// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../Widgets/custom_widget.dart';
import '../main.dart';
import 'app_colors.dart';
import 'constants.dart';


class PermissionHandlerPermissionService {
  static Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  static Future<PermissionStatus> requestStoragePermission() async {
    return await Permission.storage.request();
  }
  static Future<PermissionStatus> requestMicroPhonePermission() async {
    return await Permission.microphone.request();
  }




  /// camare permission
  static Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus == PermissionStatus.denied) {
      errorSnackBar(message: "Camera Permission Denied!");
      return false;
    } else if (cameraPermissionStatus == PermissionStatus.permanentlyDenied) {
      await permissionDialog(
        context,
        title: 'Camera Permission',
        subTitle: 'Camera permission should be granted to use this feature, would you like to go to app settings to give camera permission?',
        onTap: () {
          Get.back();
          openAppSettings();
        },
      );
      return false;
    } else {
      return true;
    }
  }

  /// photo permission
  static Future<bool> handlePhotosPermission(BuildContext context) async {
    if (Platform.isAndroid && sdkInt > 30) {
      return true;
    } else {
      PermissionStatus photosPermissionStatus = await requestStoragePermission();
      if (photosPermissionStatus == PermissionStatus.denied) {
        errorSnackBar(message: "Photos Permission Denied!");
        return false;
      } else if (photosPermissionStatus == PermissionStatus.permanentlyDenied) {
        await permissionDialog(
          context,
          title: 'Photos Permission',
          subTitle: 'Photos permission should be granted to use this feature, would you like to go to app settings to give photos permission?',
          onTap: () {
            Get.back();
            openAppSettings();
          },
        );
        return false;
      } else {
        return true;
      }
    }
  }


  /// photo permission
  static Future<bool> handleMicrophonePermission(BuildContext context) async {
    if (Platform.isAndroid && sdkInt > 30) {
      return true;
    } else {
      PermissionStatus photosPermissionStatus = await requestMicroPhonePermission();
      if (photosPermissionStatus == PermissionStatus.denied) {
        errorSnackBar(message: "Microphone Permission Denied!");
        return false;
      } else if (photosPermissionStatus == PermissionStatus.permanentlyDenied) {
        await permissionDialog(
          context,
          title: 'Microphone Permission',
          subTitle: 'Microphone permission should be granted to use this feature, would you like to go to app settings to give microphone permission?',
          onTap: () {
            Get.back();
            openAppSettings();
          },
        );
        return false;
      } else {
        return true;
      }
    }
  }


}

Future permissionDialog(BuildContext context, {String? title, String? subTitle, Function()? onTap}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.only(top: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: CustomWidgets.text1(
          title!,
          textAlign: TextAlign.center,
          color: AppColors.blackColor,
          fontSize: 2.h,
          fontWeight: FontWeight.bold,
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: CustomWidgets.text1(
              subTitle!,
              textAlign: TextAlign.center,
              color: AppColors.blackColor,
              fontSize: 1.7.h,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration:  BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.greyColor),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                    child: CustomWidgets.text1(
                      textAlign: TextAlign.center,
                      "Cancel",
                      color: AppColors.blackColor,
                      fontSize: 2.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.only(top: 1.2.h, bottom: 1.h),
                    decoration:  BoxDecoration(
                      color: AppColors.aapbarColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        topLeft: Radius.circular(3),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: CustomWidgets.text1(
                      textAlign: TextAlign.center,
                      "Confirm",
                      color: AppColors.whiteColor,
                      fontSize: 2.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
