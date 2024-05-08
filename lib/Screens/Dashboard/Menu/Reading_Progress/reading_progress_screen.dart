// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../widgets/custom_button.dart';

class ReadingProgressScreen extends StatefulWidget {
  const ReadingProgressScreen({super.key});

  @override
  State<ReadingProgressScreen> createState() => _ReadingProgressScreenState();
}

class _ReadingProgressScreenState extends State<ReadingProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(title: LanguageConstant.readingProgress.tr, isAction: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.more_vert_rounded,
                color: AppColors.whiteColor,
                size: 25,
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: AppColors.aapbarColor,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.yellowColor.withOpacity(0.50),
                      AppColors.yellowColor.withOpacity(0.1),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: 129,
                  width: 129,
                  decoration: BoxDecoration(
                    color: AppColors.aapbarColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: CustomWidgets.text1("0%",
                      fontSize: 18.sp, color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomWidgets.text1("0/1189 Read chapters",
                fontSize: 9.sp, color: AppColors.whiteColor),
            SizedBox(
              height: 1.h,
            ),
            Center(
              child: CustomLinearButton(
                width: 48.w,
                height: 4.h,
                color: AppColors.aapbarColor,
                text: LanguageConstant.readingCertificate.tr.toUpperCase(),
                fontSize: 8.sp,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                       color: index == 0
                            ? AppColors.aapbarColor
                            : Colors.transparent,
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: AppColors.yellowColor, width: 0.3))),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomWidgets.text1("Old Testament",
                              color: AppColors.whiteColor, fontSize: 8.5.sp),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomWidgets.text1("0%",
                                  color: AppColors.whiteColor,
                                  fontSize: 7.sp,
                                  height: 0.0),
                              CustomWidgets.text1("0/929",
                                  color: AppColors.whiteColor,
                                  fontSize: 7.sp,
                                  height: 0.0),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
