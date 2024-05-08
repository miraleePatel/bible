import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/bible_controller.dart';
import '../../../../Utils/string_constant.dart';
import '../Language/language_constant.dart';
import '../../../../../widgets/custom_widget.dart';
import '../../../../Utils/myicon_icons.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  BibleController bibleController = Get.put(BibleController());

  @override
  void initState() {
    // TODO: implement initState
    // bibleController.getBookmark();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bibleController.pageIndexMark = 1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(title: LanguageConstant.bookmark.tr),

     body: Obx(() {
        return isInternetAvailable.value == true ?
        LazyLoadScrollView(
          onEndOfPage: () {
            bibleController.getBookmark();
          },
            child: ListView.builder(
            itemCount: bibleController.bookmarkList.length,
            itemBuilder: (context, index) {
              var bookmarkData = bibleController.bookmarkList[index];
              return Column(
                children: [
                  Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        /*   Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 10),
                          child: SlidableAction(
                            flex: 1,
                            onPressed: (context) {},
                            borderRadius: BorderRadius.circular(10),
                            backgroundColor: AppColors.yellowColor,
                            foregroundColor: AppColors.blackColor,
                            icon: Icons.delete_outline_rounded,
                            label: 'Delete',
                          ),
                        ),
                      ),*/
                        GestureDetector(
                          onTap: () {
                            bibleController.removeBookmark(verseKey: bookmarkData.sId.toString());
                          },
                          child: Container(
                            // height: 13.h,
                            // width: 35.w,
                            margin: EdgeInsets.only(right: 20, top: 12),
                            padding: EdgeInsets.only(right: 45, left: 45),
                            decoration: BoxDecoration(
                                color: AppColors.yellowColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.iconDelete,
                                  scale: 7,
                                ),
                                CustomWidgets.text1(
                                  "Delete",
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w600, fontSize: 7.sp,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    key: Key('item ${index}'),
                    child: CustomWidgets.container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomWidgets.customIcon(icon: Myicon.bookmark,),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomWidgets.text1(bookmarkData.verseKey.toString(),
                                      letterSpacing: 0.5,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                  CustomWidgets.text1(
                                    "\"${
                                        bookmarkData.verseText
                                    }\”",
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3,
                                    fontSize: 7.sp,
                                  ),

                                  SizedBox(
                                    height: 1.h,
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),

                          ],
                        )),
                  ),

                  /// LIST LENGHT - 1
                  bibleController.bookmarkList.length -
                      1 ==
                      index
                      ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomWidgets.text1(
                      "Swipe to delete your Bookmark!",
                      textAlign: TextAlign.center,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      fontSize: 7.sp,
                    ),
                  )
                      : const SizedBox(),
                ],
              );
            },
        ),
          )  :  Image.asset(Assets.imagesNoIntenet,fit: BoxFit.cover,);
      }),
    );
  }
}
