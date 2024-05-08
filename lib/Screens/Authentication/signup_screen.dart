// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bible_app/Controller/authentication_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Routes/routes.dart';
import '../Dashboard/Menu/Language/language_constant.dart';
import '../../Utils/app_colors.dart';
import '../../generated/assets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfeild.dart';
import '../../widgets/custom_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  final formaKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authenticationController.clearRegisterData();

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
          backgroundColor: AppColors.aapbarColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(6)),
                  alignment: Alignment.center,
                  child: Form(
                    key: formaKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        CustomWidgets.text1(
                          LanguageConstant.signUp.tr.toUpperCase(),
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

                        /// userName
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomTextformFeild(
                            controller: authenticationController.signUpUsernameController,
                            hintText: LanguageConstant.userName.tr,
                            image: Image.asset(
                              Assets.iconUsername,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LanguageConstant.validUsername.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),

                        /// Email
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomTextformFeild(
                            controller: authenticationController.signupEmailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: LanguageConstant.email.tr,
                            image: Image.asset(
                              Assets.iconEmail,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LanguageConstant.reqEmail.tr;
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return LanguageConstant.validEmail.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),

                        /// Password
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomTextformFeild(
                            controller: authenticationController.signUppassController,
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
                        SizedBox(
                          height: 1.h,
                        ),

                        /// confirm password
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomTextformFeild(
                            controller: authenticationController.signUpConfirmPassController,
                            hintText: LanguageConstant.confirmPassWordHint.tr,
                            obscureText: true,
                            image: Image.asset(
                              Assets.iconPassword,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LanguageConstant.validPass.tr;

                              }
                              else if(authenticationController.signUppassController.text != authenticationController.signUpConfirmPassController.text){
                                return LanguageConstant.confirmPass.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),

                        /// Create account button
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: CustomGoldButton(
                            onTap: () {
                              if (formaKey.currentState!.validate()) {
                                authenticationController.signUp(context);
                              }
                            },
                            text: LanguageConstant.createAccount.tr.toUpperCase(),
                            fontSize: 10.sp,
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
                  height: 7.h,
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
              text: LanguageConstant.alreadyHave.tr,
              style: TextStyle(fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                    text: " " + LanguageConstant.login.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.yellowColor,
                        fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        authenticationController.clearRegisterData();
                        Get.toNamed(Routes.LOGIN_SCREEN);
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
