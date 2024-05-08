// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Models/bible_model.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChapterScreen extends StatefulWidget {
 final List<Chapters>? chepters;
 final String bookName;
  const ChapterScreen({super.key, required this.chepters, required this.bookName});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  BibleController bibleController = Get.put(BibleController());

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bibleController.selectIndexChapter.value = 0;
    bibleController.chapterPagination.addAll(widget.chepters as Iterable<Chapters>);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.text1(widget.bookName,
              color: AppColors.whiteColor,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              fontSize: 15),
          SizedBox(
            height: 1.5.h,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: widget.chepters!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Obx(() => InkWell(
                      onTap: () {
                        bibleController.selectIndexChapter.value = index;
                         bibleController.tabIndexController.index = 2;
                         bibleController.singleChaptersData.value = widget.chepters![index];

                      },
                      child: Container(
                        height: 4.h,
                        width: 9.w,
                        decoration: BoxDecoration(
                            color: bibleController.selectIndexChapter.value == index
                                ? AppColors.aapbarColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    /* bibleController.selectChapter.value == index
                                        ? AppColors.whiteColor
                                        : */ AppColors.yellowColor)),
                        alignment: Alignment.center,
                        child: CustomWidgets.text1(widget.chepters![index].chapterNo.toString(),
                            color: AppColors.whiteColor,
                            textAlign: TextAlign.center,
                            fontSize: 14),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
