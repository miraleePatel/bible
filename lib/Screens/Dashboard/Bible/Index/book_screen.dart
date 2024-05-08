// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Models/bible_model.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Index/chapter_screen.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Menu/Language/language_constant.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  BibleController bibleController = Get.put(BibleController());

  @override
  void initState() {
    // TODO: implement initState
    // bibleController.getAllBibleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      bottomNavigationBar: Container(
        height: 10.h,
        color: AppColors.aapbarColor,
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  bibleController.isTestament.value = false;
                  // bibleController.getBibleData(testament: "OT");
                },
                child: Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bibleController.isTestament.value == false
                          ? AppColors.bgColor
                          : AppColors.aapbarColor,
                      border: Border.all(
                          color: AppColors.yellowColor.withOpacity(0.5))),
                  alignment: Alignment.center,
                  child:
                  CustomWidgets.text1(LanguageConstant.oldTestament.tr,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 9.sp),
                ),
              ),
              GestureDetector(
                onTap: () {
                  bibleController.isTestament.value = true;
                  // bibleController.getBibleData(testament: "NT");
                },
                child: Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bibleController.isTestament.value == true
                          ? AppColors.bgColor
                          : AppColors.aapbarColor,
                      border: Border.all(
                          color: AppColors.yellowColor.withOpacity(0.5))),
                  alignment: Alignment.center,
                  child:
                  CustomWidgets.text1(LanguageConstant.newTestament.tr,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 9.sp),
                ),
              ),
            ],
          );
        }),
      ),
      body: Obx(() {
        return bibleController.oldTestamentList.isNotEmpty && bibleController.newTestamentList.isNotEmpty ?
        ListView.builder(
          itemCount:  bibleController.isTestament.value != true ? bibleController.oldTestamentList.length: bibleController.newTestamentList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            OldTestament bibleData =  bibleController.isTestament.value != true ? bibleController.oldTestamentList[index]:
            bibleController.newTestamentList[index];
            return Container(
              decoration: BoxDecoration(
                  color: bibleController.selectIndexBook.value == index
                      ? AppColors.aapbarColor
                      : Colors.transparent,
                  border: /* bibleController.selectBook.value == index
                        ? Border(
                            top: BorderSide(
                              color: AppColors.whiteColor,
                            ),
                            bottom: BorderSide(
                              color: AppColors.whiteColor,
                            ))
                        : */
                  Border(
                      bottom: BorderSide(
                        width: 0.7,
                        color: AppColors.yellowColor,
                      ))),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 5.w, right: 12, top: 12, bottom: 12),
                child: InkWell(
                  onTap: () {
                    bibleController.selectIndexBook.value = index;
                    bibleController.tabIndexController.index = 1;
                    bibleController.selectIndexChapter.value = 0;
                    bibleController.selectIndexVerse.value = 0;
                    bibleController.singleBibleData.value = bibleData;
                  },
                  child: CustomWidgets.text1(
                      bibleData.name.toString(),
                      color: AppColors.whiteColor),
                ),
              ),
            );
          },
        ) : Center(
          child:  CustomWidgets.text1("Not Found",
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 9.sp),
        );
      }),
    );
  }
}
