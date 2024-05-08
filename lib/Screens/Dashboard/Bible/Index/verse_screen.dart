import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Models/bible_model.dart';
import 'package:bible_app/Models/get_verse_model.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/dashboard_controller.dart';

class VerseScreen extends StatefulWidget {
  final List<Verse>? verses;
  final String bookName;
  final int chapter;
  final String isAddNote;
  const VerseScreen({super.key, required this.verses,required this.bookName,required this.chapter,required this.isAddNote});

  @override
  State<VerseScreen> createState() => _VerseScreenState();
}

class _VerseScreenState extends State<VerseScreen> {
  BibleController bibleController = Get.put(BibleController());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.text1(
              widget.verses![bibleController.selectIndexVerse.value].verseKey
                  .toString(),
              color: AppColors.whiteColor,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              fontSize: 15),
          SizedBox(
            height: 1.5.h,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: widget.verses!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Obx(() => InkWell(
                      onTap: () {
                        bibleController.selectIndexVerse.value = index;
                        if(widget.isAddNote == "note"){
                          /// argument ..... verseData, isEdit, UserNotesData(get a default edit note data)
                          Get.offAndToNamed(Routes.ADD_NOTE_SCREEN,arguments: [widget.verses![bibleController.selectIndexVerse.value], false, null ]);
                        }else if(widget.isAddNote == "bible"){
                        Get.back(result: "test");}
                        else{
                          Get.offAndToNamed(Routes.DASHBOARD_SCREEN);
                        }
                        bibleController.verseList.value =  widget.verses!;
                        bibleController.singleVerseData.value = widget.verses![index];
                      },
                      child: Container(
                        height: 4.h,
                        width: 9.w,
                        decoration: BoxDecoration(
                            color:
                                bibleController.selectIndexVerse.value == index
                                    ? AppColors.aapbarColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    /*  bibleController.selectVerse.value == index
                                        ? AppColors.whiteColor
                                        : */
                                    AppColors.yellowColor)),
                        alignment: Alignment.center,
                        child: CustomWidgets.text1(
                            widget.verses![index].verseNo.toString(),
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
