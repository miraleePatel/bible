// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Controller/language_controller.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/bible_controller.dart';
import 'language_constant.dart';
import '../../../../widgets/custom_widget.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  LanguageController languageController = Get.put(LanguageController());
  BibleController bibleController = Get.put(BibleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.aapbarColor,
        elevation: 3,
        centerTitle: true,
        title: CustomWidgets.text1(
          LanguageConstant.language.tr,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
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
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 15),
                child: CustomWidgets.text1("App interface",
                    color: AppColors.whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgets.text1(
                        LanguageConstant.locales[0]['langName']
                            .toString()
                            .toUpperCase(),
                        letterSpacing: 1,
                        color: AppColors.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    Obx(() => Radio(
                          value: 0,
                          groupValue: languageController.selectLang.value,
                          activeColor: AppColors.whiteColor,
                          fillColor:
                              MaterialStatePropertyAll(AppColors.whiteColor),
                          onChanged: (value) async {
                            languageController.selectLang.value = value!;
                            languageController.selectedLang.value = "english";
                            languageController.storeSelectedLangValue(
                                LanguageConstant.locales[0]['locale']
                                    .toString());
                            // update locale in whole app
                            Get.updateLocale(
                              LanguageConstant.locales[0]['locale'] as Locale,
                            );

                             await bibleController.getLocalBible(key: "englishBible");

                            bibleController.verseList.clear();
                          },
                        ))
                  ],
                ),
              ),
           /*   Padding(
                padding: const EdgeInsets.only(left: 18),
                child: CustomWidgets.text1(
                  "64 Available languages",
                  letterSpacing: 1,
                  color: AppColors.whiteColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 16, top: 8),
                child: CustomWidgets.text1(
                    "This setting affects the language of the entire app interface and communications that you receive from YouVersion.",
                    letterSpacing: 1,
                    height: 1.3,
                    color: AppColors.whiteColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Divider(
            height: 30,
            color: AppColors.yellowColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgets.text1(
                        LanguageConstant.locales[1]['langName']
                            .toString()
                            .toUpperCase(),
                        letterSpacing: 1,
                        color: AppColors.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    Obx(() => Radio(
                          value: 1,
                          groupValue: languageController.selectLang.value,
                          activeColor: AppColors.whiteColor,
                          fillColor:
                              MaterialStatePropertyAll(AppColors.whiteColor),
                          onChanged: (value) async {
                            languageController.selectLang.value = value!;
                            print(value);
                            languageController.selectedLang.value = "french";
                            languageController.storeSelectedLangValue(
                                LanguageConstant.locales[1]['locale']
                                    .toString());
                            // update locale in whole app
                            Get.updateLocale(
                              LanguageConstant.locales[1]['locale'] as Locale,
                            );

                              await bibleController.getLocalBible(key: "frenchBible");
                            bibleController.verseList.clear();
                          },
                        ))
                  ],
                ),
              ),
           /*   Padding(
                padding: const EdgeInsets.only(left: 18),
                child: CustomWidgets.text1(
                  "64 langues disponibles",
                  letterSpacing: 1,
                  color: AppColors.whiteColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 16, top: 8),
                child: CustomWidgets.text1(
                    "Ce paramètre affecte la langue de toute l'interface de l'application et les communications que vous recevez de YouVersion.",
                    letterSpacing: 1,
                    height: 1.3,
                    color: AppColors.whiteColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Divider(
            height: 30,
            color: AppColors.yellowColor,
          )
        ],
      ),
    );
  }
}
