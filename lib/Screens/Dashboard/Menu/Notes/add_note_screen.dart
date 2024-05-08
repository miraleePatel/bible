// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Controller/notes_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:bible_app/Models/bible_model.dart';
import '../../../../Models/get_user_all_notes_model.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/string_constant.dart';
import '../../Bible/Comment/comment_screen.dart';
import '../Language/language_constant.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_widget.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  NotesController notesController = Get.put(NotesController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Verse? verseData = Get.arguments[0];
  bool? isEdit = Get.arguments[1];
  UserNotesData? userNotesData = Get.arguments[2];

  final List<String> items = ["Public Note", "Private Note"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDefaultEditData();
  }

  getDefaultEditData() {
    if (isEdit == true) {
      notesController.noteDescController.text = userNotesData!.note.toString();
      notesController.selectedNOte.value =
          userNotesData!.private == true ? "Private Note" : "Public Note";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    notesController.noteDescController.clear();
    super.dispose();
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Center(
                child: CustomWidgets.text1(item,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    fontSize: 10.sp)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppbar.appbar(
          scaffoldKey: _scaffoldKey,
          isBackIcon: true,
          title: LanguageConstant.notes.tr,
          actions: [
            GestureDetector(
              onTap: () {
                if (notesController.noteDescController.text.isNotEmpty) {
                  /// check if add note or edit note
                  if (isEdit != true) {
                    /// add note api call
                    if (verseData != null) {
                      notesController.addNote(
                          bookId: bibleController.singleBibleData.value.bookId
                              .toString(),
                          chapter: bibleController
                              .singleChaptersData.value.chapterNo
                              .toString(),
                          verse: verseData!.verseNo!,
                          bookName: bibleController.singleBibleData.value.name
                              .toString(),
                          noteText: notesController.noteDescController.text,
                          private: notesController.selectedNOte.value ==
                                  "Private Note"
                              ? true
                              : false);
                      Get.back(closeOverlays: true, result: true);
                    } else {
                      informationSnackBar(
                          icon: Icons.info_outline_rounded,
                          title: "Verse",
                          message: "Please add verse");
                    }
                  } else {
                    /// edit note api call
                    notesController.editNote(
                        noteId: userNotesData!.sId.toString(),
                        noteText: notesController.noteDescController.text,
                        private:
                            notesController.selectedNOte.value == "Private Note"
                                ? true
                                : false);
                  }
                } else {
                  informationSnackBar(
                      icon: Icons.info_outline_rounded,
                      title: "Note",
                      message: "Note cannot be empty.");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  right: 15,
                  bottom: 12,
                ),
                child: Container(
                  width: 18.w,
                  decoration: BoxDecoration(
                      color: AppColors.texfeildColor,
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: CustomWidgets.text1(
                    isEdit != true
                        ? LanguageConstant.publish.tr
                        : LanguageConstant.edit.tr,
                    color: AppColors.blackColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ]),
      body: Obx(() {
        return isInternetAvailable.value == true
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Obx(() => Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 43.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: AppColors.texfeildColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.texfeildColor),
                                    offset: const Offset(0, -5),
                                  ),

                                  iconStyleData: const IconStyleData(
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 30,
                                      ),
                                    ),
                                    iconSize: 22,
                                    iconEnabledColor: AppColors.blackColor,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0),
                                    customHeights: _getCustomItemsHeights(),
                                  ),
                                  // style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppColors.blackColor, fontSize: 13.sp),
                                  value: notesController.selectedNOte.value,
                                  items: _addDividersAfterItems(items),

                                  onChanged: (newValue) {
                                    notesController.selectedNOte.value =
                                        newValue!;
                                  },
                                ),
                              )),
                        )),
                    CustomWidgets.container(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Get.offNamed(Routes.VERSE_INDEX_SCREEN,
                                arguments: "note");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                Assets.iconAdd,
                                scale: 7,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              verseData != null
                                  ? Expanded(
                                      child: Column(
                                        children: [
                                          CustomWidgets.text1(
                                              verseData!.verseText.toString(),
                                              color: AppColors.blackColor,
                                              maxLine: 6,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              bibleController.singleVerseData.value.verseKey != null ?
                                              CustomWidgets.text1(
                                                  "- ${ bibleController.singleVerseData.value.verseKey} ",
                                                  color: AppColors.blackColor,
                                                  maxLine: 6,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500) :    CustomWidgets.text1(
                                                  "",
                                                  color: AppColors.blackColor,
                                                  maxLine: 6,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  : CustomWidgets.text1(
                                      LanguageConstant.addVerse.tr,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w500)
                            ],
                          ),
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 15),
                      child: TextFormField(
                        controller: notesController.noteDescController,
                        cursorColor: AppColors.aapbarColor,
                        keyboardType: TextInputType.text,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: LanguageConstant.whatWould.tr,
                          hintStyle: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 12.sp,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: 2.h,
                            left: 4.w,
                          ),
                          border: InputBorder.none,
                          fillColor: AppColors.yellowColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Image.asset(
                Assets.imagesNoIntenet,
                fit: BoxFit.cover,
              );
      }),
    );
  }
}
