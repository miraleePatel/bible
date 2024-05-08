// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Index/book_screen.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Index/chapter_screen.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'verse_screen.dart';

class VerseIndexScreen extends StatefulWidget {
  const VerseIndexScreen({super.key});

  @override
  State<VerseIndexScreen> createState() => _VerseIndexScreenState();
}

class _VerseIndexScreenState extends State<VerseIndexScreen>
    with SingleTickerProviderStateMixin {
  BibleController bibleController = Get.put(BibleController());
  String isAddNote = Get.arguments;

  @override
  void initState() {
    callMethodOnInit();
    super.initState();
    bibleController.tabIndexController = TabController(vsync: this, length: 3);
  }

  callMethodOnInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // bibleController.getBibleData(testament: "OT");
      // Add Your Code here.
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bibleController.selectIndexBook.value = 0;
    bibleController.selectIndexChapter.value = 0;
    bibleController.selectIndexVerse.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(title: "Index"),
      body: Column(
        children: [
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicatorPadding: EdgeInsets.only(right: 15, left: 15),
              controller: bibleController.tabIndexController,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.whiteColor.withOpacity(0.10),
                    AppColors.whiteColor.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border(
                  top: BorderSide(color: AppColors.whiteColor, width: 3.0),
                ),
              ),
              tabs: [
                Tab(
                  child: CustomWidgets.text1(LanguageConstant.books.tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 8.sp,
                      letterSpacing: 0.5,
                      color: AppColors.whiteColor),
                ),
                Tab(
                  child: CustomWidgets.text1(LanguageConstant.chapter.tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 8.sp,
                      letterSpacing: 0.5,
                      color: AppColors.whiteColor),
                ),
                Tab(
                  child: CustomWidgets.text1(LanguageConstant.verse.tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 8.sp,
                      letterSpacing: 0.5,
                      color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
          Expanded(child: Obx(() {
            return bibleController.oldTestamentList.isNotEmpty &&
                    bibleController.newTestamentList.isNotEmpty
                ? TabBarView(
                    controller: bibleController.tabIndexController,
                    children: [
                      // Tab 1 of book
                      BookScreen(),
                      // Tab 2 of Chapter
                      ChapterScreen(
                          chepters: bibleController.isTestament.value != true
                              ? bibleController
                                  .oldTestamentList[
                                      bibleController.selectIndexBook.value]
                                  .chapters
                              : bibleController
                                  .newTestamentList[
                                      bibleController.selectIndexBook.value]
                                  .chapters,
                          bookName: bibleController.isTestament.value != true
                              ? bibleController
                                  .oldTestamentList[
                                      bibleController.selectIndexBook.value]
                                  .name
                                  .toString()
                              : bibleController
                                  .newTestamentList[
                                      bibleController.selectIndexBook.value]
                                  .name
                                  .toString()),
                      VerseScreen(
                          verses: bibleController.isTestament.value != true
                              ? bibleController
                                  .oldTestamentList[
                                      bibleController.selectIndexBook.value]
                                  .chapters![
                                      bibleController.selectIndexChapter.value]
                                  .verse
                              : bibleController
                                  .newTestamentList[
                                      bibleController.selectIndexBook.value]
                                  .chapters![
                                      bibleController.selectIndexChapter.value]
                                  .verse,
                          bookName: bibleController.isTestament.value != true
                              ? bibleController.oldTestamentList[bibleController.selectIndexBook.value].name
                                  .toString()
                              : bibleController
                                  .newTestamentList[
                                      bibleController.selectIndexBook.value]
                                  .name
                                  .toString(),
                          chapter: bibleController.isTestament.value != true
                              ? int.parse(bibleController
                                  .oldTestamentList[bibleController.selectIndexBook.value]
                                  .chapters![bibleController.selectIndexChapter.value]
                                  .chapterNo
                                  .toString())
                              : int.parse(bibleController.newTestamentList[bibleController.selectIndexBook.value].chapters![bibleController.selectIndexChapter.value].chapterNo.toString()),
                          isAddNote: isAddNote)
                    ],
                  )
                : TabBarView(
                    controller: bibleController.tabIndexController,
                    children: [
                        Center(
                          child: CustomWidgets.text1("Not Found",
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              letterSpacing: 0.5,
                              color: AppColors.whiteColor),
                        ),
                        Center(
                          child: CustomWidgets.text1("Not Found",
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              letterSpacing: 0.5,
                              color: AppColors.whiteColor),
                        ),
                        Center(
                          child: CustomWidgets.text1("Not Found",
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              letterSpacing: 0.5,
                              color: AppColors.whiteColor),
                        ),
                      ]);
          }))
        ],
      ),
    );
  }
}
