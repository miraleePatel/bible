// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/language_controller.dart';
import '../Language/language_constant.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Widgets/custom_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/custom_button.dart';

BibleController bibleController = Get.put(BibleController());
LanguageController languageController = Get.put(LanguageController());

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  BibleController bibleController1 = Get.put(BibleController());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    bibleController.searchController.clear();
     bibleController.filterList.clear();
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
            backgroundColor: AppColors.aapbarColor,
            elevation: 3,
            leadingWidth: 34,
            centerTitle: true,
            title: TextFormField(
              controller: bibleController.searchController,
              cursorColor: AppColors.aapbarColor,
              style: TextStyle(color: AppColors.whiteColor),
              onFieldSubmitted: (value){
                bibleController.filterBible(searchValue:   bibleController.searchBook.value);
                bibleController.filterBible();
              },
              onChanged: (value) {
                // bibleController.getSearchVerseData(
                //     book: bibleController.searchBook.value);
                // if (value.endsWith(' ')) {
                //   bibleController.searchController.text = value.trimRight();
                //   bibleController.searchController.selection =
                //       TextSelection.fromPosition(
                //     TextPosition(
                //         offset: bibleController.searchController.text.length),
                //   );
                // }
                 bibleController.bibleearchString.value =  value.toLowerCase();
                // bibleController.filterBible();
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: LanguageConstant.typeHere.tr,
                hintStyle: GoogleFonts.poppins(
                    color: AppColors.texfeildColor, fontSize: 10.sp),
                contentPadding: EdgeInsets.only(
                  top: 1.5.h,
                  left: 4.w,
                ),
                hintTextDirection: TextDirection.ltr,
                border: InputBorder.none,
                fillColor: AppColors.aapbarColor,
                filled: true,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: AppColors.whiteColor.withOpacity(0.4)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: AppColors.whiteColor.withOpacity(0.4)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: AppColors.whiteColor.withOpacity(0.4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: AppColors.whiteColor.withOpacity(0.4)),
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    searchFilterSheet(context);

                  },
                  child: Image.asset(
                    Assets.iconFilter,
                    width: 30,
                    scale: 8,
                  ),
                ),
              ),
            ],
          ),
          body: Obx(() {
            return bibleController.filterList.isNotEmpty
                ? LazyLoadScrollView(
                    onEndOfPage: () {
                      // bibleController.getSearchVerseData(
                      //     book: bibleController.searchBook.value);
                      bibleController.filterBible(searchValue:   bibleController.searchBook.value);
                    },
                    child: RefreshIndicator(
                      color: AppColors.aapbarColor,
                      onRefresh: () async {
                       await    bibleController.filterBible(searchValue:   bibleController.searchBook.value);
                      },
                      child: ListView.separated(
                        itemCount: bibleController.filterList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var searchData = bibleController.filterList[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: CustomWidgets.text1(
                                        "\"${searchData.verseText}\”",
                                        textAlign: TextAlign.justify,
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 9.5.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomWidgets.text1(
                                            "- ${searchData.verseKey.toString()} ",
                                            textAlign: TextAlign.left,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              /// LIST LENGHT - 1
                              bibleController.filterList.length - 1 == index
                                  ? SizedBox(
                                      height: 2.h,
                                    )
                                  : const SizedBox(),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: AppColors.yellowColor,
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: CustomWidgets.text1(
                      LanguageConstant.notFound.tr,
                      textAlign: TextAlign.justify,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                    ),
                  );
          })),
    );
  }
}

/// Top model seach filter sheet
searchFilterSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.aapbarColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (BuildContext bc) {
        return Builder(builder: (context) {
          return SizedBox(
              height: 45.h,
              child: Obx(() {
                return Column(
                  children: [
                    /// filter btn
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// filter OT/NT btn 1
                        GestureDetector(
                          onTap: () {
                            bibleController.isShowResult.value = false;
                            bibleController.isFilterBookOption.value = 0;
                          },
                          child: Container(
                            height: 5.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    bibleController.isShowResult.value == false
                                        ? AppColors.bgColor
                                        : AppColors.aapbarColor,
                                border: Border.all(
                                    color: AppColors.yellowColor
                                        .withOpacity(0.5))),
                            alignment: Alignment.center,
                            child: CustomWidgets.text1(
                              LanguageConstant.otnt.tr,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        /// filter all books btn 2
                        GestureDetector(
                          onTap: () async {
                            bibleController.isShowResult.value = true;
                            bibleController.isFilterBookOption.value = 0;
                            // bibleController.getSearchBookList(testament: "");
/*
                            if(languageController.selectedLang.value == "english")
                            {  await bibleController.getLocalBible(key: "englishBible");}
                            else{
                              await bibleController.getLocalBible(key: "frenchBible");}*/
                          },
                          child: Container(
                            height: 5.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    bibleController.isShowResult.value == true
                                        ? AppColors.bgColor
                                        : AppColors.aapbarColor,
                                border: Border.all(
                                    color: AppColors.yellowColor
                                        .withOpacity(0.5))),
                            alignment: Alignment.center,
                            child: CustomWidgets.text1(
                              LanguageConstant.allBooks.tr,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 3.h,
                    ),
                    bibleController.isShowResult.value == false
/// sub btn
                        /// filter OT/NT btn result
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    // color: Colors.blue,
                                    /// All
                                    child: ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      dense: true,
                                      onTap: () {
                                        bibleController.isFilterBookType.value =
                                            0;
                                        bibleController.searchBook.value = "ALL";
                                        bibleController.filterList.clear();
                                        bibleController.currentPage = 0;
                                      },
                                      title: CustomWidgets.text1(
                                          LanguageConstant.all.tr,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.whiteColor,
                                          height: 0.5),
                                      trailing: bibleController
                                                  .isFilterBookType.value ==
                                              0
                                          ? const Icon(
                                              Icons.done,
                                              color: AppColors.whiteColor,
                                            )
                                          : const Text(" "),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: AppColors.yellowColor,
                                  endIndent: 20,
                                  indent: 20,
                                ),

                                /// oldTestament
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ListTile(
                                    visualDensity: VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    onTap: () {
                                      bibleController.isFilterBookType.value =
                                          1;
                                      bibleController.searchBook.value = "OT";
                                      bibleController.filterList.clear();
                                      bibleController.currentPage = 0;
                                    },
                                    title: CustomWidgets.text1(
                                      LanguageConstant.oldTestament.tr,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.whiteColor,
                                    ),
                                    trailing: bibleController
                                                .isFilterBookType.value ==
                                            1
                                        ? const Icon(
                                            Icons.done,
                                            color: AppColors.whiteColor,
                                          )
                                        : const Text(" "),
                                  ),
                                ),
                                Divider(
                                  color: AppColors.yellowColor,
                                  endIndent: 20,
                                  indent: 20,
                                ),

                                /// newTestament
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ListTile(
                                    visualDensity: VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    dense: true,
                                    minVerticalPadding: 1,
                                    onTap: () {
                                      bibleController.isFilterBookType.value =
                                          2;
                                      bibleController.searchBook.value = "NT";
                                      bibleController.filterList.clear();
                                      bibleController.currentPage = 0;
                                    },
                                    title: CustomWidgets.text1(
                                        LanguageConstant.newTestament.tr,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.whiteColor,
                                        fontSize: 10.sp),
                                    trailing: bibleController
                                                .isFilterBookType.value ==
                                            2
                                        ? const Icon(
                                            Icons.done,
                                            color: AppColors.whiteColor,
                                          )
                                        : const Text(" "),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                          )

                        /// filter all book btn result
                        : Column(
                            children: [
                              Container(
                                height: 23.h,
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          mainAxisExtent: 40
                                          // Set 2 items per row
                                          ),
                                  itemCount:
                                      bibleController.allBibleList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Obx(() {
                                      return Container(
                                        width: 40.w,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: bibleController
                                                        .isFilterBookOption ==
                                                    index
                                                ? AppColors.bgColor
                                                : AppColors.aapbarColor,
                                            border: Border.all(
                                                color: AppColors.yellowColor
                                                    .withOpacity(0.5))),
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            bibleController.isFilterBookOption
                                                .value = index;

                                            bibleController.searchBook.value =  bibleController
                                                .allBibleList[index]
                                                .name.toString();
                                            bibleController.filterList.clear();
                                            bibleController.currentPage = 0;
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: CustomWidgets.text1(
                                                  bibleController
                                                      .allBibleList[index]
                                                      .name
                                                      .toString(),
                                                  color: AppColors.whiteColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              bibleController
                                                          .isFilterBookOption ==
                                                      index
                                                  ? CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor: AppColors
                                                          .texfeildColor,
                                                      child: Icon(
                                                        Icons.done,
                                                        color: AppColors
                                                            .blackColor,
                                                        size: 10,
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons.circle_outlined,
                                                      color: AppColors
                                                          .texfeildColor,
                                                    )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              )
                            ],
                          ),
                    Spacer(),
                    /*   SizedBox(
                      height: 1.h,
                    ), */

                    /// shoe result button
                    CustomSilverButton(
                      width: 38.w,
                      height: 5.h,
                      onTap: () {
                        if(bibleController.searchController.text.isNotEmpty) {
                          bibleController.filterBible(searchValue:   bibleController.searchBook.value);
                          Get.back(
                            closeOverlays: true,
                          );
                        }else{
                          informationSnackBar(icon:Icons.info_outline_rounded,title: "Search",message: "Search field cannot be empty.");
                        }
                        },
                      text: LanguageConstant.showResult.tr,
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                );
              }));
        });
      });
}
