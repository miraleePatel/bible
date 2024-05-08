// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Controller/profile_controller.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:bible_app/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/string_constant.dart';
import '../Menu/Language/language_constant.dart';
import '../../../Utils/permission_service.dart';
import '../../../widgets/custom_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomWidgets.appBar(
          title: LanguageConstant.editProfile.tr,
        ),
        body: Obx(() {
          return isInternetAvailable.value == true ?
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Obx(() =>
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // ignore: unnecessary_null_comparison
                            (profileController.imagePath.value != "")
                                ? CircleAvatar(
                              maxRadius: 50,
                              backgroundColor: AppColors.whiteColor,
                              backgroundImage: FileImage(
                                  File(profileController.imagePath.value)),
                            )
                                : (profileController.profileImg.value
                                .isNotEmpty)
                                ? CustomWidgets.shimmerImage(
                              height: 13.h ,
                                width: 13.h,
                                image: APIManager.baseUrl +
                                    profileController.profileImg.value)
                                : CircleAvatar(
                              maxRadius: 50,
                              backgroundColor: AppColors.whiteColor,
                            ),
                            GestureDetector(
                              onTap: () {
                                uploadProfileImage(context);
                              },
                              child: Image.asset(
                                Assets.iconIconEdit,
                                scale: 12,
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 4.h,
                    ),

                    /// User name textfield
                    TextFormField(
                      controller: profileController.userNameController,
                      cursorColor: AppColors.bgColor,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: AppColors.blackColor),
                      decoration: InputDecoration(
                        hintText: LanguageConstant.editUserName.tr,
                        hintStyle: GoogleFonts.poppins(color: AppColors
                            .blackColor, fontSize: 11.sp),
                        contentPadding: EdgeInsets.only(top: 1.h,
                            left: 8.w,
                            right: 3.w),
                        hintTextDirection: TextDirection.ltr,
                        border: InputBorder.none,
                        fillColor: AppColors.texfeildColor,
                        filled: true,
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              Assets.iconIconUser,
                              scale: 9,
                              color: AppColors.blackColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    /// Mobile number textfield
                    TextFormField(
                      controller: profileController.mobileNoController,
                      cursorColor: AppColors.bgColor,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: AppColors.blackColor),
                      decoration: InputDecoration(
                        hintText: LanguageConstant.mobileNo.tr,
                        hintStyle: GoogleFonts.poppins(color: AppColors
                            .blackColor, fontSize: 11.sp),
                        contentPadding: EdgeInsets.only(top: 1.h,
                            left: 8.w,
                            right: 3.w),
                        hintTextDirection: TextDirection.ltr,
                        border: InputBorder.none,
                        fillColor: AppColors.texfeildColor,
                        filled: true,
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              Assets.iconIconCall,
                              scale: 9,
                              color: AppColors.blackColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    /// Date of birth textfield
                    TextFormField(
                      controller: profileController.dobController,
                      cursorColor: AppColors.bgColor,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: AppColors.blackColor),
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: LanguageConstant.editDob.tr,
                        hintStyle: GoogleFonts.poppins(color: AppColors
                            .blackColor, fontSize: 11.sp),
                        contentPadding: EdgeInsets.only(top: 1.h,
                            left: 8.w,
                            right: 3.w),
                        hintTextDirection: TextDirection.ltr,
                        border: InputBorder.none,
                        fillColor: AppColors.texfeildColor,
                        filled: true,
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              Assets.iconIconCalender,
                              scale: 9,
                              color: AppColors.blackColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                      ),
                      onTap: () {
                        profileController.selectDate(context);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    /// Location textfield
                    TextFormField(
                      controller: profileController.locationController,
                      cursorColor: AppColors.bgColor,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: AppColors.blackColor),
                      decoration: InputDecoration(
                        hintText: LanguageConstant.location.tr,
                        hintStyle: GoogleFonts.poppins(color: AppColors
                            .blackColor, fontSize: 11.sp),
                        contentPadding: EdgeInsets.only(top: 1.h,
                            left: 8.w,
                            right: 3.w),
                        hintTextDirection: TextDirection.ltr,
                        border: InputBorder.none,
                        fillColor: AppColors.texfeildColor,
                        filled: true,
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              Assets.iconIconLocation,
                              scale: 9,
                              color: AppColors.blackColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    /// Email textfield
                    TextFormField(
                      controller: profileController.emailController,
                      cursorColor: AppColors.bgColor,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      style: TextStyle(color: AppColors.blackColor),
                      decoration: InputDecoration(
                        hintText: LanguageConstant.editEmail.tr,
                        hintStyle: GoogleFonts.poppins(color: AppColors
                            .blackColor, fontSize: 11.sp),
                        contentPadding: EdgeInsets.only(top: 1.h,
                            left: 8.w,
                            right: 3.w),
                        hintTextDirection: TextDirection.ltr,
                        border: InputBorder.none,
                        fillColor: AppColors.texfeildColor,
                        filled: true,
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              Assets.iconEmail,
                              scale: 6.5,
                              color: AppColors.blackColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          ) : Image.asset(Assets.imagesNoIntenet, fit: BoxFit.cover,);
        }),
        bottomNavigationBar: Obx(() {
          return isInternetAvailable.value == true ?
            Padding(
            padding: const EdgeInsets.all(20),
            child: CustomGoldButton(
              onTap: () {
                profileController.editUserDetails();
              },
              text: LanguageConstant.saveProfile.tr,
              fontSize: 11.sp,
            ),
          )  : SizedBox();
        }));
  }

  /// upload Image
  void uploadProfileImage(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.bgColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(7),
          ),
        ),
        builder: (BuildContext bc) {
          return Builder(builder: (context) {
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: AppColors.whiteColor,
                      ),
                      title: CustomWidgets.text1(
                          'Photo Library', color: AppColors.whiteColor),
                      onTap: () async {
                        profileController.imagePath.value = "";
                        await PermissionHandlerPermissionService
                            .handlePhotosPermission(context).then((
                            bool galleryPermission) async {
                          if (galleryPermission == true) {
                            await profileController.openImagePicker(
                                ImageSource.gallery).then((value) async {
                              if (value.path.isNotEmpty || value.path != "") {
                                profileController.imageName.value = value.path
                                    .split("/")
                                    .last;
                                profileController.imagePath.value = value.path;
                              }
                              print("Image Name :::: ${profileController
                                  .imageName}");
                              print("Image Path :::: ${profileController
                                  .imagePath}");
                            });
                          }
                        });
                        Get.back();
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.photo_camera,
                        color: AppColors.whiteColor,
                      ),
                      title: CustomWidgets.text1(
                          'Camera', color: AppColors.whiteColor),
                      onTap: () async {
                        Platform.isIOS
                            ? await profileController.openImagePicker(
                            ImageSource.camera).then((value) async {
                          if (value.path.isNotEmpty || value.path != "") {
                            profileController.imageName.value = value.path
                                .split("/")
                                .last;
                            profileController.imagePath.value = value.path;
                          }
                          print(
                              "Image Name :::: ${profileController.imageName}");
                          print(
                              "Image Path :::: ${profileController.imagePath}");
                        })
                            : await PermissionHandlerPermissionService
                            .handleCameraPermission(context).then((
                            bool cameraPermission) async {
                          if (cameraPermission == true) {
                            await profileController.openImagePicker(
                                ImageSource.camera).then((value) async {
                              if (value.path.isNotEmpty || value.path != "") {
                                profileController.imageName.value = value.path
                                    .split("/")
                                    .last;
                                profileController.imagePath.value = value.path;
                              }
                              print("Image Name :::: ${profileController
                                  .imageName}");
                              print("Image Path :::: ${profileController
                                  .imagePath}");
                            });
                          }
                        });
                        Get.back();
                      }),
                ],
              ),
            );
          });
        });
  }
}
