import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../../Controller/bible_controller.dart';
import '../../../../Controller/notes_controller.dart';
import '../../../../Models/bible_model.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dropdown_button.dart';
import '../../../../widgets/custom_textformfeild.dart';
import '../../Menu/Language/language_constant.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Widgets/custom_widget.dart';
import '../../../../generated/assets.dart';

class ShowAllComment extends StatefulWidget {
  const ShowAllComment({super.key});

  @override
  State<ShowAllComment> createState() => _ShowAllCommentState();
}

class _ShowAllCommentState extends State<ShowAllComment> {
  String title = Get.arguments[0];
  List<Comment> commentData = Get.arguments[1];
  BibleController bibleController = Get.put(BibleController());
  NotesController notesController = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(
          title: " ${title} ${LanguageConstant.comment.tr}"),
      body: ListView.builder(
        itemCount: commentData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: (){
                  createNoteBottomSheet(context,title: title,commentId:commentData[index].sId );
                },
                child: CustomWidgets.container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomWidgets.text1(
                          commentData[index].comment.toString(),
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          fontSize: 8.sp,
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                              commentData[index].comment.toString(),
                              subject: title,
                            );
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              Assets.iconShare,
                              scale: 2,
                            ),
                          ),
                        )
                      ],
                    )),
              ),

              /// LIST LENGHT - 1
              2 - 1 == index
                  ? SizedBox(
                height: 1.h,
              )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );

    /// Create note bottomsheet

  }
  createNoteBottomSheet(BuildContext context,
      {String? commentId, String? title}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          // height: 35.h,
          decoration: BoxDecoration(
              color: AppColors.aapbarColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13), topRight: Radius.circular(13))),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
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
                        title!,
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
                          items: bibleController.items, onChanged: (newValue) {
                          bibleController.selectNote.value = newValue!;
                        }, value: bibleController.selectNote.value,),
                      );
                    }),
                  ],
                ),
                Divider(
                  height: 5.h,
                  color: AppColors.yellowColor,
                ),

                CustomeNoteTextfeildWidget(
                  controller: notesController.onTapCommentNoteController,
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
                              noteText: notesController
                                  .onTapCommentNoteController.text,
                              private: bibleController.selectNote.value ==
                                  "Private Note" ? true : false,
                              commentId: commentId);
                          Get.back();
                        },
                        text: LanguageConstant.save.tr,
                        fontWeight: FontWeight.w500),
                    SizedBox(
                      width: 15,
                    ),
                    CustomSilverButton(
                      onTap: () {
                        notesController.onTapCommentNoteController.clear();
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
}