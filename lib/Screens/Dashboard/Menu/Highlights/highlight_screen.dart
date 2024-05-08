import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/bible_controller.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/string_constant.dart';
import '../../../../generated/assets.dart';

class HighlightScreen extends StatefulWidget {
  const HighlightScreen({super.key});

  @override
  State<HighlightScreen> createState() => _HighlightScreenState();
}

class _HighlightScreenState extends State<HighlightScreen> {
  BibleController bibleController = Get.put(BibleController());

  @override
  void initState() {
    // TODO: implement initState

    // bibleController.getHighlight();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bibleController.pageIndexHigh = 1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(title: LanguageConstant.highlights.tr),
      body: Obx(() {
        return  isInternetAvailable.value == true ?
        bibleController.highlightList.isNotEmpty ?
        LazyLoadScrollView(
          onEndOfPage: () {
            bibleController.getHighlight();
          },
          child: ListView.builder(
          itemCount: bibleController.highlightList.length,
          itemBuilder: (context, index) {
            var highlightData = bibleController.highlightList[index];
            return Column(
              children: [
                Container(
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        // SlidableAction(
                        //   flex: 1,
                        //   onPressed: (context) {},
                        //   borderRadius: BorderRadius.circular(10),
                        //   backgroundColor: AppColors.yellowColor,
                        //   foregroundColor: AppColors.blackColor,
                        //   icon: Icons.delete_outline_rounded,
                        //   label: 'Delete',
                        // ),
                        GestureDetector(
                          onTap: () {
                            bibleController.removeHighlight(verseKey:  highlightData.sId.toString());
                          },
                          child: Container(
                            // height: 13.h,
                            // width: 35.w,
                            padding: EdgeInsets.only(right: 45, left: 45),
                            margin: EdgeInsets.only(right: 20, top: 12),
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 7.sp,
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
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  Assets.iconHighlights,
                                  scale: 7,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      CustomWidgets.text1(highlightData.verse!.verseKey.toString(),
                                          letterSpacing: 0.5,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      CustomWidgets.text1(
                                        "\"${highlightData.verse!.verseText}\”",
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,
                                        maxLine: 3,
                                        overflow: TextOverflow.ellipsis,
                                        height: 1.3,
                                        fontSize: 7.sp,
                                      ),
                                      /*  SizedBox(
                                      height: 1.h,
                                    ), */
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor:hexToColor(highlightData.color!)
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                Assets.iconShare,
                                scale: 2,
                              ),
                            )
                          ],
                        )),
                  ),
                ),

                /// LIST LENGHT - 1
                bibleController.highlightList.length - 1 == index
                    ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomWidgets.text1(
                    "Swipe to delete your highlight!",
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
        ) : Center(
          child: CustomWidgets.text1(
            "Not Found",
            textAlign: TextAlign.center,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
            height: 1.3,
            fontSize: 10.sp,
          ),
        ) :  Image.asset(Assets.imagesNoIntenet,fit: BoxFit.cover,);
      }),
    );
  }
}
