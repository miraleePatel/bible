// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:developer';
import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Voice_Record/audio_record.dart';
import 'package:bible_app/Screens/Dashboard/Bible/bible_bottomSheet.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Controller/tts_player_controller.dart';
import '../../../Models/bible_model.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/myicon_icons.dart';
import '../../../generated/assets.dart';
import 'Comment/comment_screen.dart';
import 'Comment/show_all_notes.dart';
import 'upload_screen.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  BibleController bibleController = Get.put(BibleController());

  TTSPlayerController ttsPlayerController = Get.put(TTSPlayerController());
  var verseText =
      "1). Finally, God created humans in His own image, male and female, and blessed them. He commanded them to be fruitful, multiply, and have dominion over the earth and all living creatures.";
  final List<IconData> iconList = [
    Myicon.chat,
    Myicon.upload,
    Myicon.note
    // Myicon.bookmark,
    // Add more images if needed
  ];

  @override
  void initState() {
    super.initState();
    // bibleController.getAllBibleData();
    // ttsPlayerController.initializeTts();
    // callMethodOnInit();
    ttsPlayerController.tts.stop();
    ttsPlayerController.scrollController = ScrollController();

  }
  callMethodOnInit(){
  bibleController.oldTestamentList.isNotEmpty ? dismissProgressIndicator() :  showProgressIndicator();

}
  @override
  void dispose() {
    super.dispose();
    bibleController.fontSize.value = 9.sp;
    // ttsPlayerController.flutterTts!.stop();
    ttsPlayerController.tts.stop();
    ttsPlayerController.scrollController.dispose();
    bibleController.audioRecorder.dispose();
    bibleController.timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    bibleController.oldTestamentList.isNotEmpty ? dismissProgressIndicator() :  showProgressIndicator();
    return Column(
      children: [
        /// verse list
        Expanded(
          child: Obx(() {
            return bibleController.verseList.isNotEmpty ?
            showBibleData() :  defaultBibleData(context);
          }),
        ),

        SizedBox(
          height: 0.5.h,
        ),
        Obx(() => bibleController.isRecordVoice.value
            ? AudioRecordScreen(
                verseName: "Genesis 1:${1 + 1}",
                onStop: (path) {
                  if (kDebugMode) print('Recorded file path: $path');

                  bibleController.audioPath = path.obs;
                  // bibleController.showPlayer.value = true;
                  // bibleController.isRecordVoice.value = false;
                },
              )
            : Column(
              children: [

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bibleController.loadPreviousChapter();
                        },
                        child: Image.asset(
                          Assets.iconLeftPage,
                          scale: 7,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      InkWell(
                        onTap: () {

                          if(ttsPlayerController.isPlaying.value){
                            ttsPlayerController.stopSpeech();
                          }else{
                            bibleController.verseList.isNotEmpty ?
                            ttsPlayerController.startReading() : ttsPlayerController.startDefaultReading();
                          }
                       bibleController.itemIconListVisibility.value = true;
                       bibleController.selectIconIndex.value = -1;

                        },
                        child: Image.asset(
                          Assets.iconVolum,
                          scale: 8,
                        ),
                      ),
                      /*  CustomWidgets.customIcon(
                  icon: Myicon.volum,
                ), */
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                        onTap: () {

                          bibleController.isTestament.value != true ? bibleController.loadNextChapter(chapter:bibleController.oldTestamentList[bibleController.selectIndexBook.value].chapters) :
                              bibleController.loadNextChapter(chapter:bibleController
                                  .newTestamentList[
                              bibleController.selectIndexBook.value]
                                  .chapters );
                        },
                        child: Image.asset(
                          Assets.iconRightPage,
                          scale: 7,
                        ),
                      ),
                    ],
                  ),

                /// ads banner
                Container(
                  height: 8.h,
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

              ],
            )),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }

  ListView showBibleData() {
    return ListView.separated(
            itemCount:bibleController.chapterPagination[bibleController.bibleCurrentIndex.value].verse!.length,
            controller: ttsPlayerController.scrollController,
            itemBuilder: (context, verseIndex) {
              var data = bibleController.chapterPagination[bibleController.bibleCurrentIndex.value].verse![verseIndex];
          return Column(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        BottomSheets().textColorBottomSheet(context, verseIndex);
                      },
                      child: CustomWidgets.container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: AppColors.yellowColor,
                                // bibleController.selectColor[verseIndex],
                                child: CustomWidgets.text1(
                                  "${data.verseNo.toString()}) ${data.verseText.toString()}",
                                  fontSize: bibleController.fontSize.value,
                                  fontWeight: FontWeight.w600,
                                  // color: verseIndex == ttsPlayerController.highlightedIndex.value
                                  //     ? Colors.blue // Highlighted text color
                                  //     : Colors.black
                                  // backgroundColor: bibleController.verseList[verseIndex].selectColor,
                                  // color: dashboardController
                                  //     .selectColor[verseIndex]
                                ),
                              ),/*    Container(
                                color: AppColors.yellowColor,
                                // bibleController.selectColor[verseIndex],
                                child: CustomWidgets.text1(
                                  "${bibleController.verseList[verseIndex].verseNo.toString()}) ${bibleController.verseList[verseIndex].verseText.toString()}",
                                  fontSize: bibleController.fontSize.value,
                                  fontWeight: FontWeight.w600,
                                  // color: verseIndex == ttsPlayerController.highlightedIndex.value
                                  //     ? Colors.blue // Highlighted text color
                                  //     : Colors.black
                                  // backgroundColor: bibleController.verseList[verseIndex].selectColor,
                                  // color: dashboardController
                                  //     .selectColor[verseIndex]
                                ),
                              ),*/
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Obx(() => /* bibleController
                                        .itemIconListVisibility[verseIndex] */
                                      bibleController.itemIconListVisibility.value

                                          /// hide icon
                                          ? GestureDetector(
                                              onTap: () {
                                                bibleController.itemIconListVisibility.value = !bibleController.itemIconListVisibility.value;
                                                // bibleController
                                                //     .toggleItemIconListVisibility(
                                                //         verseIndex);
                                                bibleController.selectIconIndex.value = 0;
                                                // bibleController
                                                //     .toggleImageListVisibility();
                                                // bibleController
                                                //     .toggleImageListVisibility();
                                              },
                                              child: Image.asset(
                                                Assets.iconHideList,
                                                scale: 7,
                                              ))

                                          /// show icon list
                                          : Container(
                                              height: 40,
                                              decoration: BoxDecoration(color: AppColors.texfeildColor, borderRadius: BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: InkWell(
                                                        onTap: () {
                                                          bibleController.itemIconListVisibility.value =
                                                              !bibleController.itemIconListVisibility.value;
                                                          // bibleController
                                                          //     .toggleItemIconListVisibility(
                                                          //         verseIndex);
                                                          // bibleController
                                                          //     .toggleImageListVisibility();

                                                          bibleController.selectIconIndex.value = -1;
                                                        },
                                                        child: Icon(
                                                          Icons.arrow_forward_ios_rounded,
                                                          size: 20,
                                                          color: AppColors.blackColor,
                                                        )),
                                                  ),
                                                  Visibility(
                                                      visible: bibleController.isImageListVisible.value,
                                                      child: Container(
                                                        height: 27,
                                                        alignment: Alignment.center,
                                                        child: ListView.separated(
                                                          itemCount: iconList.length,
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemBuilder: (context, index) {
                                                            return Obx(() {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  bibleController.selectIconIndex.value = index;
                                                                  // selectedIconIndex
                                                                  //         .value =
                                                                  //     index;

                                                                  print("index --- ${index}");
                                                                },
                                                                child: Container(
                                                                  height: 26,
                                                                  width: 28,
                                                                  decoration: BoxDecoration(
                                                                      color: bibleController.selectIconIndex.value == index
                                                                          ? AppColors.bgColor
                                                                          : AppColors.texfeildColor,
                                                                      border: Border.all(
                                                                        color: AppColors.bgColor,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8)),
                                                                  child: Icon(
                                                                    iconList[index],
                                                                    color: bibleController.selectIconIndex.value == index
                                                                        ? AppColors.whiteColor
                                                                        : AppColors.bgColor,
                                                                    size: 13,
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          separatorBuilder: (context, index) {
                                                            return VerticalDivider(
                                                              color: AppColors.bgColor.withOpacity(0.5),
                                                              thickness: 1,
                                                              indent: 10,
                                                              endIndent: 10,
                                                            );
                                                          },
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 2.w,
                                                  )
                                                ],
                                              ),
                                            )),
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  Obx(() => Visibility(
                        visible: bibleController.isImageListVisible.value,
                        child: AnimatedCrossFade(
                          firstChild: SizedBox(),
                          secondChild: IconTapDataShow(
                            index: bibleController.selectIconIndex.value,
                            verseIndex: verseIndex,
                            verseName: data.verseKey.toString(),
                            commentData: data.comment,
                            videoData: data.videoComment,

                            // bibleController
                            //     .getSelectedIconIndex(verseIndex),
                          ),
                          crossFadeState: CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 300),
                        ),
                      )),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 1.h,
              );
            },
          );
  }

  StatelessWidget defaultBibleData(BuildContext context) {
    return bibleController.oldTestamentList.isNotEmpty ?
    ListView.separated(
        itemCount:bibleController.oldTestamentList[0].chapters![0].verse!.length,
        controller: ttsPlayerController.scrollController,
        itemBuilder: (context, index) {
          var deafultData = bibleController.oldTestamentList[0].chapters![0].verse![index];
        return Column(
          children: [
            Obx(
                  () => GestureDetector(
                onTap: () {
                  BottomSheets().textColorBottomSheet(context, index);
                },
                child: CustomWidgets.container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: AppColors.yellowColor,
                          // bibleController.selectColor[verseIndex],
                          child: CustomWidgets.text1(
                            "${deafultData.verseNo}) ${deafultData.verseText}",
                            fontSize: bibleController.fontSize.value,
                            fontWeight: FontWeight.w600,
                            // backgroundColor: bibleController.verseList[verseIndex].selectColor,
                            // color: dashboardController
                            //     .selectColor[verseIndex]
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() => /* bibleController
                                      .itemIconListVisibility[verseIndex] */
                            bibleController.itemIconListVisibility.value

                            /// hide icon
                                ? GestureDetector(
                                onTap: () {
                                  bibleController.itemIconListVisibility.value = !bibleController.itemIconListVisibility.value;
                                  // bibleController
                                  //     .toggleItemIconListVisibility(
                                  //         verseIndex);
                                  bibleController.selectIconIndex.value = 0;
                                  // bibleController
                                  //     .toggleImageListVisibility();
                                  // bibleController
                                  //     .toggleImageListVisibility();
                                },
                                child: Image.asset(
                                  Assets.iconHideList,
                                  scale: 7,
                                ))

                            /// show icon list
                                : Container(
                              height: 40,
                              decoration: BoxDecoration(color: AppColors.texfeildColor, borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: InkWell(
                                        onTap: () {
                                          bibleController.itemIconListVisibility.value =
                                          !bibleController.itemIconListVisibility.value;
                                          // bibleController
                                          //     .toggleItemIconListVisibility(
                                          //         verseIndex);
                                          // bibleController
                                          //     .toggleImageListVisibility();

                                          bibleController.selectIconIndex.value = -1;
                                        },
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                          color: AppColors.blackColor,
                                        )),
                                  ),
                                  Visibility(
                                      visible: bibleController.isImageListVisible.value,
                                      child: Container(
                                        height: 27,
                                        alignment: Alignment.center,
                                        child: ListView.separated(
                                          itemCount: iconList.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Obx(() {
                                              return GestureDetector(
                                                onTap: () {
                                                  bibleController.selectIconIndex.value = index;
                                                  // selectedIconIndex
                                                  //         .value =
                                                  //     index;
                                                  print("index --- ${index}");
                                                },
                                                child: Container(
                                                  height: 26,
                                                  width: 28,
                                                  decoration: BoxDecoration(
                                                      color: bibleController.selectIconIndex.value == index
                                                          ? AppColors.bgColor
                                                          : AppColors.texfeildColor,
                                                      border: Border.all(
                                                        color: AppColors.bgColor,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8)),
                                                  child: Icon(
                                                    iconList[index],
                                                    color: bibleController.selectIconIndex.value == index
                                                        ? AppColors.whiteColor
                                                        : AppColors.bgColor,
                                                    size: 13,
                                                  ),
                                                ),
                                              );
                                            });
                                          },
                                          separatorBuilder: (context, index) {
                                            return VerticalDivider(
                                              color: AppColors.bgColor.withOpacity(0.5),
                                              thickness: 1,
                                              indent: 10,
                                              endIndent: 10,
                                            );
                                          },
                                        ),
                                      )),
                                  SizedBox(
                                    width: 2.w,
                                  )
                                ],
                              ),
                            )),
                          ],
                        )
                      ],
                    )),
              ),
            ),
            Obx(() => Visibility(
              visible: bibleController.isImageListVisible.value,
              child: AnimatedCrossFade(
                firstChild: SizedBox(),
                secondChild: IconTapDataShow(
                  index: bibleController.selectIconIndex.value,
                  verseIndex: index,
                  verseName: deafultData.verseKey,
                  commentData: deafultData.comment,
                  videoData: deafultData.videoComment,
                  // bibleController
                  //     .getSelectedIconIndex(verseIndex),
                ),
                crossFadeState: CrossFadeState.showSecond,
                duration: Duration(milliseconds: 300),
              ),
            )),
          ],
        );
      },
        separatorBuilder: (context, index) {
      return SizedBox(
        height: 1.h,
      );
    },
    ) : Container();
  }
}

class IconTapDataShow extends StatefulWidget {
  int? index;
  int? verseIndex;
  String? verseName;
  List<Comment>? commentData;
  List<VideoComment>? videoData;
  IconTapDataShow({super.key, this.index, this.verseName, this.verseIndex,this.commentData,this.videoData});

  @override
  State<IconTapDataShow> createState() => _IconTapDataShowState();
}

class _IconTapDataShowState extends State<IconTapDataShow> {
  BibleController bibleController = Get.find();

  @override
  Widget build(BuildContext context) {
    switch (widget.index!) {
      case 0: // Comment Icon
        return CommentScreen(
          verseIndex: widget.verseIndex,
          commentData: widget.commentData,
          verseName: widget.verseName,
          videoData:widget.videoData,
        );
      case 1: // Upload Icon
        return UploadScreen(
          verseName: widget.verseName,
        );
      case 2: // Note Icon
        return ShowNoteScreen();
      // case 3: // Bookmark Icon
      //   return BookmarkScreen(); // Replace with your BookmarkScreen implementation
      default:
        return SizedBox();
    }
  }
}
