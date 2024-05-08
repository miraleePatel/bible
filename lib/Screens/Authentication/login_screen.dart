// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bible_app/Controller/authentication_controller.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/widgets/custom_textformfeild.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/app_colors.dart';
import '../../generated/assets.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationController authenticationController = AuthenticationController();
  final formaKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    authenticationController.clearLoginData();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          // backgroundColor: AppColors.aapbarColor,
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          /* leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
            ),
          ), */
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(6)),
                  alignment: Alignment.center,
                  child: Form(
                    key: formaKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        CustomWidgets.text1(
                          LanguageConstant.login.tr.toUpperCase(),
                          color: AppColors.aapbarColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                        ),
                        Divider(
                          color: AppColors.aapbarColor,
                          thickness: 1,
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomTextformFeild(
                            controller: authenticationController.loginUserNameCon,
                            hintText: LanguageConstant.email.tr,
                            image: Image.asset(
                              Assets.iconUsername,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LanguageConstant.reqEmail.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: CustomTextformFeild(
                            controller: authenticationController.loginPasswordCon,
                            hintText: LanguageConstant.password.tr,
                            obscureText: true,
                            image: Image.asset(
                              Assets.iconPassword,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LanguageConstant.validPass.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.FORGOTPASSWORD_SCREEN);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomWidgets.text1(
                                  LanguageConstant.forgotPassword.tr + "?",
                                  fontSize: 7.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: CustomGoldButton(
                            onTap: () {
                              if (formaKey.currentState!.validate()) {
                                authenticationController.signIn(context);
                              }
                            },
                            text: LanguageConstant.login.tr.toUpperCase(),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            authenticationController.signUpWithGoogle();
                          },
                          child: Image.asset(
                            Assets.iconGoogle,
                            scale: 8,
                          )),
                      GestureDetector(
                          onTap: () {
                            authenticationController.signInWithFacebook();
                            print("click");
                          },
                          child: Image.asset(
                            Assets.iconFacebook,
                            scale: 8,
                          )),
                      GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            Assets.iconTwitter,
                            scale: 8,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: (Platform.isAndroid) ? 35 : 50,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10),
          child: RichText(
            text: TextSpan(
              text: LanguageConstant.dontHave.tr,
              style: TextStyle(fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                    text: " " + LanguageConstant.signUp.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.yellowColor, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        authenticationController.clearLoginData();
                        Get.toNamed(Routes.SIGNUP_SCREEN);
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
