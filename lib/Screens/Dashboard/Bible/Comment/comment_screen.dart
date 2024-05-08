// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:bible_app/Controller/tts_player_controller.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../Controller/bible_controller.dart';
import '../../../../Controller/notes_controller.dart';
import '../../../../Models/bible_model.dart';
import '../../../../Utils/string_constant.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dropdown_button.dart';
import '../../../../widgets/custom_textformfeild.dart';
import '../../Menu/Language/language_constant.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/myicon_icons.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/custom_widget.dart';
import '../bible_bottomSheet.dart';

BibleController bibleController = Get.find();
TTSPlayerController ttsPlayerController = Get.find();

class CommentScreen extends StatefulWidget {
  int? verseIndex;
  List<Comment>? commentData;
  List<VideoComment>? videoData;
  String? verseName;

  CommentScreen({super.key,
    this.verseIndex,
    this.commentData,
    this.verseName,
    this.videoData});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  var _youtubeController;
  String? videoId = "";
  bool isPlayReady = false;
  BibleController bibleController = Get.put(BibleController());
  NotesController notesController = Get.put(NotesController());

  @override
  void initState() {
    // TODO: implement initState

    callyoutubePlayer();
    super.initState();
  }

  callMethodOnInit() {
    // videoId = YoutubePlayer.convertUrlToId(
    //     'https://www.youtube.com/watch?v=MV7EV2yXeiw&ab_channel=SermonIndex.net');
    // log("video id ------- $videoId");
    // _youtubeController = YoutubePlayerController(
    //   initialVideoId: videoId!,
    //   flags: YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //   ),
    // )..addListener(listener);
  }

  callyoutubePlayer() {
    if (widget.videoData != null && widget.videoData!.isNotEmpty) {
      for (var comment in widget.videoData!) {
        String? videoLink = comment.videoLink;
        if (videoLink != null) {
          videoId = YoutubePlayer.convertUrlToId(videoLink);
          log("video id ------- $videoId");
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId!,
            flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          )
            ..addListener(listener);
        }
      }
    }
  }

  void listener() {
    if (isPlayReady && mounted && !_youtubeController.value.isFullScreen) {
      setState(() {
        // _playerState = _controller.value.playerState;
        // _videoMetaData = _controller.metadata;
      });
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // _youtubeController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),

        /// comment list
        widget.commentData!.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: CustomWidgets.linearBorderContainer(
              child: ListView.separated(
                itemCount: widget.commentData!.length > 3
                    ? 3
                    : widget.commentData!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // BottomSheets().createNoteBottomSheet(context,
                            //     verseIndex: widget.verseIndex);
                            createNoteBottomSheet(context,
                              commentId: widget.commentData![index].sId
                                  .toString(), title: widget.verseName,);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 10,
                            ),
                            child: Container(
                              child: CustomWidgets.text1(
                                  widget.commentData![index].comment
                                      .toString(),
                                  fontSize: bibleController.fontSize.value,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 3,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Share.share(
                                widget.commentData![index].comment
                                    .toString(),
                                subject: widget.verseName,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  Assets.iconShare,
                                  scale: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.8.h,
                        ),
                        widget.commentData!.length - 1 == index || index == 2
                            ? GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SHOW_ALL_COMMENT,
                                arguments: [
                                  widget.verseName,
                                  widget.commentData!
                                ]);
                          },
                          child: Container(
                            height: 3.5.h,
                            width: 100.w,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: AppColors.texfeildColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6))),
                            alignment: Alignment.center,
                            child: CustomWidgets.text1(
                              LanguageConstant.showAll.tr,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    );
                  });
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1.h,
                    color: AppColors.whiteColor,
                  );
                },
              )),
        )
            : Container(),
        SizedBox(
          height: 0.5.h,
        ),

        /// Youtube Video
        Obx(() =>
        isInternetAvailable.value == true ? widget.videoData != null &&
            widget.videoData!.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen.
              /*  SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]); */
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
            },
            onEnterFullScreen: () {
              // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              //     overlays: []);
            },
            player: YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              aspectRatio: 16 / 9,
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: AppColors.whiteColor,
                handleColor: AppColors.whiteColor,
              ),
              /*   bottomActions: [
                const SizedBox(width: 14.0),
                CurrentPosition(),
                const SizedBox(width: 8.0),
                Expanded(child: ProgressBar()),
                RemainingDuration(),
                const PlaybackSpeedButton(),
              ],*/
              topActions: [
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _youtubeController.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
              onReady: () {
                isPlayReady = true;
              },
            ),
            builder: (BuildContext context, Widget) {
              return Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.white,
                      handleColor: Colors.white,
                    ),
                    topActions: [
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          _youtubeController.metadata.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                    onReady: () {
                      setState(() {
                        isPlayReady = true;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        )
            : Container() : Container(),),


        SizedBox(
          height: 1.h,
        ),

        /// Show notes
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CustomWidgets.linearBorderContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.texfeildColor,
                                shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Image.asset(
                              Assets.iconPerson,
                              scale: 9,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets.text1("Alex",
                                    letterSpacing: 0.5,
                                    // fontSize:bibleController.fontSize.value == 9.0 ? 13 : bibleController.fontSize.value,
                                    fontSize: 13,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w700),
                                CustomWidgets.text1(
                                  "\"For God so loved the world, that he "
                                      "gave his only Son,that whoever believes in him shoul\”",
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                  height: 1.3,
                                  // fontSize:bibleController.fontSize.value,
                                  fontSize: 8.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            Assets.iconShare,
                            scale: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 1.h,
              );
            },
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),

        /// ads banner
        Container(
          height: 7.h,
          margin: EdgeInsets.only(top: 5, left: 20, right: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.aapbarColor,
              borderRadius: BorderRadius.circular(10)),
          child: CustomWidgets.text1(
            "Ads banner",
            fontSize: 8.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        /*  /// add notes on comment

        CustomWidgets.container(
            color: AppColors.texfeildColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      CustomWidgets.customIcon(
                        icon: Myicon.note,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      CustomWidgets.text1(LanguageConstant.note.tr,
                          fontWeight: FontWeight.w600, fontSize: 9.sp),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// drop button
                          ///
                          Obx(() => Align(
                                alignment: Alignment.center,
                                child: Container(
                                    width: 30.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.aapbarColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        style: TextStyle(
                                            color: AppColors.whiteColor),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.aapbarColor),
                                          offset: const Offset(0, -5),
                                          width: 30.w,
                                        ),

                                        iconStyleData: const IconStyleData(
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                            ),
                                          ),
                                          iconSize: 20,
                                          iconEnabledColor:
                                              AppColors.whiteColor,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7.0),
                                          customHeights:
                                              _getCustomItemsHeights(),
                                        ),
                                        // style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppColors.blackColor, fontSize: 13.sp),
                                        value: bibleController
                                            .selectedComNote.value,
                                        items: _addDividersAfterItems(items),

                                        onChanged: (newValue) {
                                          bibleController.selectedComNote
                                              .value = newValue!;
                                        },
                                      ),
                                    )),
                              )),

                          SizedBox(
                            width: 2.w,
                          ),

                          /// save btn
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              // width: 23.w,
                              height: 4.h,
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.aapbarColor,
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              child: CustomWidgets.text1(
                                LanguageConstant.save.tr,
                                color: AppColors.whiteColor,
                                fontSize: 7.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.whiteColor,
                  thickness: 0.5,
                ),

                /// comment notes textfeild
                TextFormField(
                  controller: bibleController.commentNoteController,
                  cursorColor: AppColors.aapbarColor,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: LanguageConstant.whatWould.tr,
                    hintStyle: GoogleFonts.poppins(
                        color: AppColors.blackColor, fontSize: 10.sp),
                    contentPadding:
                        EdgeInsets.only(top: 1.h, left: 4.w, right: 3.w),
                    hintTextDirection: TextDirection.ltr,
                    border: InputBorder.none,
                    fillColor: AppColors.texfeildColor,
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
              ],
            )),*/
      ],
    );
  }


  /// Create note bottomsheet
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
