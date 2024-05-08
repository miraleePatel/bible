// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/authentication_controller.dart';
import '../../Routes/routes.dart';
import '../../Utils/app_colors.dart';
import '../../generated/assets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textformfeild.dart';
import '../../widgets/custom_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  AuthenticationController authenticationController = AuthenticationController();
  final formaKey = GlobalKey<FormState>();
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
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    child: Form(
                      key: formaKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomWidgets.text1(
                            LanguageConstant.forgotPassword.tr.toUpperCase(),
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
                              controller: authenticationController.forgotpassController,
                              hintText: LanguageConstant.email.tr,
                              image: Image.asset(
                                Assets.iconEmail,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LanguageConstant.reqEmail.tr;
                                } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                  return LanguageConstant.validEmail.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(Routes.LOGIN_SCREEN);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomWidgets.text1(
                                  LanguageConstant.backSignIn.tr,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
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
                                  print("hello");
                                  authenticationController.forgotPasswordApi();
                                }
                              },
                              text: LanguageConstant.send.tr.toUpperCase(),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
