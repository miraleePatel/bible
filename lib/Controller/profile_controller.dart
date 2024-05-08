// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:bible_app/Api/dio_api_manager.dart';
import 'package:bible_app/Controller/authentication_controller.dart';
import 'package:bible_app/Models/signUp_model.dart' as userdata;
import 'package:bible_app/Repository/profile_repository.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/Utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as formdata;
import '../Api/api_manager.dart';
import '../Models/signUp_model.dart';
import '../Utils/constants.dart';

class ProfileController extends GetxController {
  AuthenticationController authenticationController = Get.put(AuthenticationController());
  ProfileRepository profileRepository = ProfileRepository(APIManager(), DioAPIManager());
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var imageName = ''.obs;
  var imagePath = ''.obs;
  var profileImg = "".obs;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.aapbarColor,
              onPrimary: AppColors.whiteColor,
              onSurface: AppColors.blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.aapbarColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

      dobController.text = DateFormat("dd/MM/yyyy").format(selectedDate);
    }
  }

  /// Image Picker
  Future<File> openImagePicker(ImageSource sourceData) async {
    XFile? xFile = await ImagePicker().pickImage(
      source: sourceData,
      requestFullMetadata: true,
    );
    return File(xFile!.path);
  }

  // ************************  Get User Profile Data *****************************
  getProfileData() {
    userdata.Data profileData = LoginSuccessModel.fromJson(GetStorage().read(userData)).data!;
    log("profile data --------- ${profileData.toJson()}");
    userNameController.text = profileData.userName!;
    emailController.text = profileData.email!;
    mobileNoController.text = profileData.mobileNo != null ? profileData.mobileNo! : "";
    dobController.text = profileData.dateOfBirth != null ? profileData.dateOfBirth! : "";
    locationController.text = profileData.location != null ? profileData.location! : "";
    profileImg.value = profileData.profileImage != null ? profileData.profileImage! : "";
    log("profile image -------- ${profileImg.value}");
  }
  // ************************  Get User Profile Data *****************************

  // ************************  Patch edit profile  *****************************
  var sendImg;
  editUserDetails() async {
    //call api
    print(imagePath.value);
    userdata.Data profileData = LoginSuccessModel.fromJson(GetStorage().read(userData)).data!;

    if (imagePath.value != "" && imagePath.value != null) {
      sendImg = await formdata.MultipartFile.fromFile(
        imagePath.value,
        filename: imagePath.value,
        // basename(imagePath.value),ok
      );
      // sendImg = selectedProfileImg.value.path;
    } else {
      sendImg = profileData.profileImage;
    }

    formdata.FormData formData = formdata.FormData.fromMap({
      "userName": userNameController.text,
      "mobile_no": mobileNoController.text,
      "location": locationController.text,
      "dateOfBirth": dobController.text,
      'profile_image': sendImg
    });
    print(formData);
    authenticationController.signUpDetails.value = await
    profileRepository.editProfileApiCall(sendData: formData);

    // success message & navigation

    if (authenticationController.signUpDetails.value.status == 1) {
      successSnackBar(message: authenticationController.signUpDetails.value.message);
      GetStorage().write(userData, authenticationController.signUpDetails.value.toJson());
      Get.offAllNamed(Routes.DASHBOARD_SCREEN);
    } else {
      errorSnackBar(message: authenticationController.signUpDetails.value.message);
    }
  }
}
