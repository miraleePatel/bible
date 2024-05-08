// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Screens/Dashboard/Bible/Comment/comment_screen.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/Utils/constants.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:bible_app/widgets/custom_button.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../Controller/notes_controller.dart';
import '../../../Controller/tts_player_controller.dart';
import '../../../Models/get_verse_model.dart';
import '../../../Routes/routes.dart';
import '../../../widgets/custom_dropdown_button.dart';
import '../../../widgets/custom_textformfeild.dart';

class BottomSheets {
  List iconsList = [
    Assets.iconCopyIcon,
    Assets.iconMenuShare,
    Assets.iconMenuHlighlight,
    Assets.iconMyNotes,
    Assets.iconMenuBookmark,
    Assets.iconMenuAudio,
    Assets.iconAlbum
  ];

  List colorsList = [
    Color(0xffFFBABA),
    Color(0xffFFE8BA),
    Color(0xffBBFFBA),
    Color(0xffBAE6FF),
    Color(0xffC4BAFF),
    Color(0xffFFBAF4),
    // Color(0xffBBB0DB),
    Color(0xffBAEE91),
    Color(0xffFF8AEC),
  ];
  NotesController notesController = Get.put(NotesController());
  final List<String> items = ["Public Note", "Private Note"];
  TTSPlayerController ttsPlayerController = Get.put(TTSPlayerController());

  /// Font bottomsheet
  fontBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 16.h,
          decoration: BoxDecoration(
              color: AppColors.aapbarColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      CustomWidgets.text1("A-", color: AppColors.whiteColor, fontSize: 15.sp),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 1,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                        ),
                        child: Container(
                          width: 70.w,
                          child: Slider(
                              max: 20.sp,
                              min: 8.0.sp,
                              activeColor: AppColors.whiteColor,
                              inactiveColor: AppColors.whiteColor.withOpacity(0.5),
                              thumbColor: AppColors.whiteColor,
                              value: bibleController.fontSize.value,
                              onChanged: (value) {
                                bibleController.fontSize.value = value;
                              }),
                        ),
                      ),
                      CustomWidgets.text1("A+", color: AppColors.whiteColor, fontSize: 15.sp),
                    ],
                  )),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 6.h,
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(color: AppColors.texfeildColor, borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: CustomWidgets.text1(
                    LanguageConstant.set.tr,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        );
      },
    );
  }

  /// Text color chnage bottomsheet
  textColorBottomSheet(BuildContext context, int verseIndex) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 15.h,
          decoration: BoxDecoration(
              color: AppColors.aapbarColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Obx(() {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          iconsList.length,
                          (index) => InkWell(
                              onTap: () {
                                bibleController.selectIcon.value = index;
                              },
                              child: CustomLinearButton(
                                height: 5.h,
                                width: 10.w,
                                color: (bibleController.selectIcon.value == index) ? AppColors.texfeildColor : AppColors.bgColor,
                                gradient: LinearGradient(colors: [
                                  AppColors.whiteColor,
                                  AppColors.whiteColor.withOpacity(0.1),
                                ]),
                                onTap: () {
                                  bibleController.selectIcon.value = index;

                                  verseFunctionality(index, context, verseIndex: verseIndex);
                                },
                                child: Center(
                                  child: Image.asset(
                                    iconsList[index],
                                    color: (bibleController.selectIcon.value == index) ? AppColors.blackColor : AppColors.whiteColor,
                                    height: 3.h,
                                  ),
                                ),
                              )))),
                  SizedBox(
                    height: 10,
                  ),
                  bibleController.selectIcon.value == 2
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    bibleController.selectColorIndex.value = -1;
                                    // bibleController.verseList[verseIndex]
                                    //     .selectColor = AppColors.yellowColor;
                                    // bibleController.verseData[verseIndex].selectColor =
                                    //     AppColors.yellowColor;
                                    String colorHex = colorToHex( AppColors.yellowColor);
                                    bibleController.addHighlight(
                                        verseKey: bibleController.verseList.isNotEmpty
                                            ? bibleController.verseList[verseIndex!].verseKey.toString()
                                            : bibleController.oldTestamentList.isNotEmpty
                                                ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseKey.toString()
                                                : "",
                                        color:colorHex);
                                  },
                                  child: Container(
                                      height: 5.h,
                                      width: 9.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.bgColor,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.whiteColor,
                                      )),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      colorsList.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: () {
                                            bibleController.selectColorIndex.value = index;
                                            // bibleController
                                            //         .verseList[verseIndex]
                                            //         .selectColor =
                                            //     colorsList[index];
                                                  String colorHex = colorToHex(colorsList[index]);
                                            bibleController.addHighlight(
                                                verseKey: bibleController.verseList.isNotEmpty
                                                    ? bibleController.verseList[verseIndex!].verseKey.toString()
                                                    : bibleController.oldTestamentList.isNotEmpty
                                                        ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseKey.toString()
                                                        : "",
                                                color: colorHex);
                                          },
                                          child: Container(
                                            height: 5.h,
                                            width: 9.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorsList[index],
                                            ),
                                            child: (bibleController.selectColorIndex.value == index)
                                                ? Icon(
                                                    Icons.check,
                                                    color: AppColors.bgColor,
                                                  )
                                                : Container(),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            );
                          }),
                        )
                      : Container(),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  /// Icon ontap functionality
  verseFunctionality(int selectedIndex, BuildContext context, {int? verseIndex}) {
    print("INDEX------->" + selectedIndex.toString());

    switch (selectedIndex) {
      case 0:
        return FlutterClipboard.copy(
          bibleController.verseList.isNotEmpty
              ? bibleController.verseList[verseIndex!].verseText.toString()
              : bibleController.oldTestamentList.isNotEmpty
                  ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseText.toString()
                  : "",
        ).then((value) {
          informationSnackBar(message: "Text copied");
        });
      case 1:
        return Share.share(
          bibleController.verseList.isNotEmpty
              ? bibleController.verseList[verseIndex!].verseText.toString()
              : bibleController.oldTestamentList.isNotEmpty
                  ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseText.toString()
                  : "",
          subject: "Bible",
        );
      case 2:
        return Container();
      case 3:
        return createNoteBottomSheet(context, verseIndex: verseIndex);
      case 4:
        return bibleController.addBookmark(verseKey:  bibleController.verseList.isNotEmpty
            ? bibleController.verseList[verseIndex!].verseKey.toString()
            : bibleController.oldTestamentList.isNotEmpty
            ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseKey.toString()
            : "");
      case 5:
        return Container();
      case 6:
        return Get.toNamed(Routes.SHARE_IMAGE_SCREEN,arguments: [bibleController.verseList.isNotEmpty
            ? bibleController.verseList[verseIndex!].verseText.toString()
            : bibleController.oldTestamentList.isNotEmpty
            ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseText.toString()
            : "",
    bibleController.verseList.isNotEmpty
    ? bibleController.verseList[verseIndex!].verseKey.toString()
        : bibleController.oldTestamentList.isNotEmpty
    ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseKey.toString()
        : ""]);
    }
  }

  /// Show volume pop up
  showDialogVolume(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.aapbarColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(top: 0, bottom: 0),
          content: Container(
            height: 350,
            width: 100.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.iconLeftPage,
                      scale: 7,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Image.asset(
                      Assets.iconVolum,
                      scale: 8,
                    ),
                    /*  CustomWidgets.customIcon(
                      height: 4.5.h,
                      width: 4.5.h,
                      icon: Myicon.volum,
                    ), */
                    SizedBox(
                      width: 3.w,
                    ),
                    Image.asset(
                      Assets.iconRightPage,
                      scale: 7,
                    ),
                  ],
                ),
                Divider(
                  height: 4.h,
                  color: AppColors.yellowColor,
                ),

                /// Slider section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomWidgets.text1(LanguageConstant.volume.tr, color: AppColors.whiteColor),
                        SizedBox(
                          height: 1.h,
                        ),
                        CustomWidgets.text1(LanguageConstant.pitch.tr, color: AppColors.whiteColor),
                        SizedBox(
                          height: 1.h,
                        ),
                        CustomWidgets.text1(LanguageConstant.speech.tr, color: AppColors.whiteColor),
                      ],
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /// volume slider
                            ///
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 1,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
                              ),
                              child: Slider(
                                  max: 1.0,
                                  min: 0.0,
                                  value:ttsPlayerController.volume.value,
                                  activeColor: AppColors.whiteColor,
                                  inactiveColor: AppColors.whiteColor.withOpacity(0.5),
                                  thumbColor: AppColors.whiteColor,
                                  onChanged: (val) {
                                    ttsPlayerController.volume.value = val;
                                  }),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),

                            /// pitch slider
                            ///
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 1,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
                              ),
                              child: Slider(
                                  max: 2.0,
                                  min: 0.0,
                                  value: ttsPlayerController.pitch.value,
                                  activeColor: AppColors.whiteColor,
                                  inactiveColor: AppColors.whiteColor.withOpacity(0.5),
                                  thumbColor: AppColors.whiteColor,
                                  onChanged: (val) {
                                    ttsPlayerController.pitch.value = val;
                                  }),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),

                            /// Speech slider
                            ///
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 1,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
                              ),
                              child: Slider(
                                  max: 1.0,
                                  min: 0.0,
                                  value:  ttsPlayerController.rate.value,
                                  activeColor: AppColors.whiteColor,
                                  inactiveColor: AppColors.whiteColor.withOpacity(0.5),
                                  thumbColor: AppColors.whiteColor,
                                  onChanged: (val) {
                                    ttsPlayerController.rate.value = val;
                                  }),
                            ),
                          ],
                        ))
                  ],
                ),
                Divider(
                  height: 4.h,
                  color: AppColors.yellowColor,
                ),
                Obx(() => Row(
                      children: [
                        SizedBox(
                          width: 2.h,
                        ),
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: AppColors.whiteColor,
                          ),
                          child: Radio(
                            visualDensity: VisualDensity(vertical: -4.0),
                            value: 0,
                            groupValue: bibleController.selectVerse.value,
                            activeColor: AppColors.whiteColor,
                            focusColor: AppColors.whiteColor,
                            onChanged: (value) {
                              bibleController.selectVerse.value = value!;
                            },
                          ),
                        ),
                        CustomWidgets.text1(LanguageConstant.verseOnly.tr, color: AppColors.whiteColor, fontSize: 12),
                      ],
                    )),
                Obx(() => Row(
                      children: [
                        SizedBox(
                          width: 2.h,
                        ),
                        Theme(
                          data: ThemeData(unselectedWidgetColor: AppColors.whiteColor),
                          child: Radio(
                            value: 1,
                            groupValue: bibleController.selectVerse.value,
                            visualDensity: VisualDensity(vertical: -3.0),
                            activeColor: AppColors.whiteColor,
                            focusColor: AppColors.whiteColor,
                            onChanged: (value) {
                              bibleController.selectVerse.value = value!;
                            },
                          ),
                        ),
                        CustomWidgets.text1(LanguageConstant.verseCmt.tr, color: AppColors.whiteColor, fontSize: 12),
                      ],
                    )),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSilverButton(
                      onTap: () {
                        Get.back();
                      },
                      text: LanguageConstant.close.tr,
                    ),
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        );
      },
    );
  }

  /// Create note bottomsheet
  createNoteBottomSheet(BuildContext context, {int? verseIndex}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          // height: 35.h,
          decoration: BoxDecoration(
              color: AppColors.aapbarColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13))),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomWidgets.text1(
                        // "${bibleController.verseList[verseIndex!].verseKey}",
                        bibleController.verseList.isNotEmpty
                            ? bibleController.verseList[verseIndex!].verseKey.toString()
                            : bibleController.oldTestamentList.isNotEmpty
                                ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseKey.toString()
                                : "",
                        color: AppColors.whiteColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold),
                    Obx(() {
                      return Container(
                        width: 35.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.texfeildColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: CustomDropDownButton(
                          items: bibleController.items,
                          onChanged: (newValue) {
                            bibleController.selectNote.value = newValue!;
                          },
                          value: bibleController.selectNote.value,
                        ),
                      );
                    }),
                  ],
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.yellowColor,
                ),
                CustomeNoteTextfeildWidget(
                  controller: notesController.onTapNotesController,
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.yellowColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSilverButton(
                        onTap: () {
                          notesController.addNote(
                              bookId: bibleController.singleBibleData.value.bookId.toString(),
                              chapter: bibleController.singleChaptersData.value.chapterNo.toString(),
                              verse: bibleController.verseList.isNotEmpty != null
                                  ? bibleController.verseList[verseIndex!].verseNo.toString()
                                  : bibleController.oldTestamentList.isNotEmpty
                                      ? bibleController.oldTestamentList[0].chapters![0].verse![verseIndex!].verseNo.toString()
                                      : "",
                              bookName: bibleController.singleBibleData.value.name.toString(),
                              noteText: notesController.onTapNotesController.text,
                              private: bibleController.selectNote.value == "Private Note" ? true : false);
                          Get.back();
                        },
                        text: LanguageConstant.save.tr,
                        fontWeight: FontWeight.w500),
                    SizedBox(
                      width: 15,
                    ),
                    CustomSilverButton(
                      onTap: () {
                        notesController.onTapNotesController.clear();
                        Get.back();
                      },
                      text: LanguageConstant.delete.tr,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Center(child: CustomWidgets.text1(item, fontWeight: FontWeight.w500, color: AppColors.blackColor, fontSize: 10.sp)),
          ),
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                endIndent: 5,
                color: AppColors.blackColor,
                thickness: 1,
                indent: 5,
              ),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }

      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }
}
