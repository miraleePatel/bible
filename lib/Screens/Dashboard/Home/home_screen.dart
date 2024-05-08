// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:bible_app/Controller/dashboard_controller.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../Controller/bible_controller.dart';
import '../../../Controller/notes_controller.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/myicon_icons.dart';
import '../../../Utils/static_list.dart';
import '../../../services/video_database_helper.dart';
import '../Bible/Comment/comment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  late YoutubePlayerController _youtubeController;
  String? videoId = "";
  bool isPlayReady = false;
  NotesController notesController = Get.put(NotesController());
  BibleController bibleController = Get.put(BibleController());

  final VideoDatabaseHelper dbHelper = VideoDatabaseHelper.instance;

  @override
  void initState() {
    // TODO: implement initState
    _fetchSavedVideos();
    videoId = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=MV7EV2yXeiw&ab_channel=SermonIndex.net');
    log("video id ------- $videoId");
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )
      ..addListener(listener);
    // callMethodOnInit();
    super.initState();
  }

  void listener() {
    if (isPlayReady && mounted && !_youtubeController.value.isFullScreen) {

    }
  }

  Future<void> _fetchSavedVideos() async {
    bibleController.savedVideos.value =
    await dbHelper.getVideosWithVerseNamesAndThumbnails();
    bibleController.savedAudios.value =
    await dbHelper.getAudiosWithVerseNames();
    bibleController.savedImages.value = await dbHelper.getImageWithVerseNames();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.

    _youtubeController.pause();

    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _youtubeController.pause();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomWidgets.container(
              padding: const EdgeInsets.only(
                  top: 20, right: 10, left: 10,bottom: 20),
              child: CustomWidgets.text1(
                  "WELCOME to the transformative and sacred realm of the Holy Bible app, where you embark on a divine journey of enlightenment through the timeless wisdom of scripture!",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  fontSize: 8.5.sp)),

          /// verse of day
          CustomWidgets.container(
              ontap: () {
                // dashboardController.selectedIndex.value = 1;
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.iconVerofdaybox,
                          scale: 6,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomWidgets.text1(LanguageConstant.verseDay.tr,
                            fontWeight: FontWeight.w600, fontSize: 9.sp),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.VERSE_DAY_SCREEN);
                          },
                          child: CustomWidgets.text1(
                            LanguageConstant.showAll.tr,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.whiteColor,
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
                    child: CustomWidgets.text1(
                      "\"But those who hope in the Lord will renew their strength."
                          " They will soar on wings like eagles. they will run and not grow weary, they will walk and not be faint.\"",
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w600,
                      fontSize: 8.sp,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
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
                        // _youtubeController.toggleFullScreenMode();
                        /* SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]); */
                      },
                      player: YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                        aspectRatio: 16 / 9,
                        progressIndicatorColor: Colors.amber,
                        progressColors: ProgressBarColors(
                          playedColor: AppColors.yellowColor,
                          handleColor: AppColors.yellowColor,
                        ),
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
                      builder: (BuildContext, Widget) {
                        return Container(
                          // width: MediaQuery.of(context).size.width, // You can adjust this width as needed
                          // height: MediaQuery.of(context).size.width * (9 / 16),
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
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomWidgets.text1(
                            "- Isaiah 40:31",
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w600,
                            fontSize: 7.5.sp,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                              "\"But those who hope in the Lord will renew their strength."
                                  " They will soar on wings like eagles. they will run and not grow weary, they will walk and not be faint.\"",
                              subject: "Verse of the day",
                            );
                          },
                          child: Image.asset(
                            Assets.iconShare,
                            scale: 2,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SHARE_IMAGE_SCREEN,arguments: ["But those who hope in the Lord will renew their strength."
                                " They will soar on wings like eagles. they will run and not grow weary, they will walk and not be faint." ,"Isaiah 40:31" ]);
                          },
                          child: Image.asset(
                            Assets.iconImageShare,
                            scale: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),

          /// highlights
          Obx(() =>  bibleController.highlightList.isNotEmpty
              ? CustomWidgets.container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.iconHighlights,
                          scale: 6,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomWidgets.text1(LanguageConstant.highlights.tr,
                            fontWeight: FontWeight.w600, fontSize: 9.sp),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.HIGHLIGHT_SCREEN);
                          },
                          child: CustomWidgets.text1(
                            LanguageConstant.showAll.tr,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.whiteColor,
                    thickness: 0.5,
                  ),
                  ListView.separated(
                    itemCount: bibleController.highlightList.length > 2
                        ? 2
                        : bibleController.highlightList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var highlightData = bibleController
                          .highlightList[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, top: 5),
                        child: GestureDetector(
                          onTap: () {
                            dashboardController.selectedIndex.value = 1;
                          },
                          child: Column(
                            children: [
                              CustomWidgets.text1(
                                  "\"${highlightData.verse!.verseText}\"",
                                  textAlign: TextAlign.justify,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8.sp,
                                  backgroundColor:hexToColor(highlightData.color.toString())
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomWidgets.text1(
                                        "- ${highlightData.verse!.verseKey}",
                                        textAlign: TextAlign.left,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 7.5.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(
                                          "\"${highlightData.verse!
                                              .verseText}\"",
                                          subject: "Highlights",
                                        );
                                      },
                                      child: Image.asset(
                                        Assets.iconShare,
                                        scale: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.SHARE_IMAGE_SCREEN,
                                            arguments: [
                                              highlightData.verse!.verseText,
                                              highlightData.verse!.key
                                            ]);
                                      },
                                      child: Image.asset(
                                        Assets.iconImageShare,
                                        scale: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.whiteColor,
                        thickness: 0.5,
                      );
                    },
                  )

                ],
              ))
              : Container(),),


          /// Bookmark
       Obx(() =>  bibleController.bookmarkList.isNotEmpty
           ? CustomWidgets.container(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 5),
                 child: Padding(
                   padding: const EdgeInsets.only(
                       top: 10, right: 10, left: 10),
                   child: Row(
                     children: [
                       CustomWidgets.customIcon(
                         icon: Myicon.bookmark,
                       ),
                       SizedBox(
                         width: 2.w,
                       ),
                       CustomWidgets.text1(LanguageConstant.bookmark.tr,
                           fontWeight: FontWeight.w600, fontSize: 9.sp),
                       Spacer(),
                       InkWell(
                         onTap: () {
                           Get.toNamed(Routes.BOOKMARK_SCREEN);
                         },
                         child: CustomWidgets.text1(
                           LanguageConstant.showAll.tr,
                           fontSize: 7.sp,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               Divider(
                 color: AppColors.whiteColor,
                 thickness: 0.5,
               ),
               ListView.separated(
                 itemCount: bibleController.bookmarkList.length > 2
                     ? 2
                     : bibleController.bookmarkList.length,
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) {
                   var bookmarkData = bibleController.bookmarkList[index];
                   return Padding(
                     padding: const EdgeInsets.only(
                         right: 10, left: 10, top: 5),
                     child: GestureDetector(
                       onTap: () {
                         dashboardController.selectedIndex.value = 1;
                       },
                       child: Column(
                         children: [
                           Align(
                             alignment: Alignment.centerLeft,
                             child: CustomWidgets.text1(
                               bookmarkData.verseKey.toString(),
                               textAlign: TextAlign.left,
                               fontWeight: FontWeight.w700,
                               fontSize: 9.sp,
                             ),
                           ),
                           SizedBox(
                             height: 0.5.h,
                           ),
                           CustomWidgets.text1(
                             "\"${bookmarkData.verseText}\"",
                             textAlign: TextAlign.justify,
                             fontWeight: FontWeight.w600,
                             fontSize: 8.sp,
                           ),
                           SizedBox(
                             height: 0.5.h,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 5),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 GestureDetector(
                                   onTap: () {
                                     Share.share(
                                       "\"${bookmarkData.verseText}\"",
                                       subject: "Bookmark",
                                     );
                                   },
                                   child: Image.asset(
                                     Assets.iconShare,
                                     scale: 2,
                                   ),
                                 ),
                                 SizedBox(
                                   width: 5,
                                 ),
                                 GestureDetector(
                                   onTap: () {
                                     Get.toNamed(Routes.SHARE_IMAGE_SCREEN,
                                         arguments: [
                                           bookmarkData.verseText,
                                           bookmarkData.verseKey
                                         ]);
                                   },
                                   child: Image.asset(
                                     Assets.iconImageShare,
                                     scale: 6,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                 },
                 separatorBuilder: (context, index) {
                   return Divider(
                     color: AppColors.whiteColor,
                     thickness: 0.5,
                   );
                 },
               )

             ],
           ))
           : Container(), ),


          /// notes


    Obx(() =>    notesController.getAllNoteList.isNotEmpty
              ? CustomWidgets.container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        CustomWidgets.customIcon(
                          icon: Myicon.note,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomWidgets.text1(LanguageConstant.notes.tr,
                            fontWeight: FontWeight.w600, fontSize: 9.sp),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.NOTES_SCREEN);
                          },
                          child: CustomWidgets.text1(
                            LanguageConstant.showAll.tr,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.whiteColor,
                    thickness: 0.5,
                  ),
                 ListView.separated(
                      itemCount: notesController.getAllNoteList.length > 2
                          ? 2
                          : notesController.getAllNoteList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var noteData = notesController.getAllNoteList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, top: 5),
                          child: GestureDetector(
                            onTap: () {
                              dashboardController.selectedIndex.value = 1;
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets.text1(
                                  "\"${noteData.note.toString()}\"",
                                  textAlign: TextAlign.justify,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8.sp,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Align(
                                      //   alignment: Alignment.centerRight,
                                      //   child: CustomWidgets.text1(
                                      //     "- ${noteData.verseDetail!.bookName} ${noteData.verseDetail!.chapter} : ${noteData.verseDetail!.verse}",
                                      //     textAlign: TextAlign.left,
                                      //     fontWeight: FontWeight.w600,
                                      //     fontSize: 7.5.sp,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Share.share(
                                            noteData.note.toString(),
                                            subject: "Note",
                                          );
                                        },
                                        child: Image.asset(
                                          Assets.iconShare,
                                          scale: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.SHARE_IMAGE_SCREEN,
                                              arguments: [
                                                noteData.note,
                                                noteData.verseKey
                                              ]);
                                        },
                                        child: Image.asset(
                                          Assets.iconImageShare,
                                          scale: 6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 3.h,
                          color: AppColors.whiteColor,
                          thickness: 0.5,
                        );
                      },
                    )

                ],
              ))
              : Container(),),

          /// my video
          bibleController.savedVideos.isNotEmpty
              ?
          CustomWidgets.container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.iconVideo,
                          scale: 6,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomWidgets.text1(LanguageConstant.myVideo.tr,
                            fontWeight: FontWeight.w600, fontSize: 9.sp),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.MY_VIDEO_SCREEN);
                          },
                          child: CustomWidgets.text1(
                            LanguageConstant.showAll.tr,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.whiteColor,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Container(
                    height: 8.h,
                    width: 120.w,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10),
                    child: Obx(() {
                      /*  List<VideoModel> displayedVideos =
                          bibleController.savedVideos.sublist(
                              0,
                              bibleController.savedVideos.length > 4
                                  ? 4
                                  : bibleController.savedVideos.length); */
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        // physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        reverse: false,
                        itemCount: bibleController.savedVideos.length > 5
                            ? 5
                            : bibleController.savedVideos.length,
                        // displayedVideos.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<Uint8List>(
                              future: bibleController.generateThumbnail(
                                  bibleController.savedVideos[index].path),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: CupertinoActivityIndicator(
                                      color: AppColors.whiteColor,
                                      radius: 10,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error loading thumbnail');
                                } else if (!snapshot.hasData) {
                                  return SizedBox(); // Placeholder, or handle differently
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(Routes.PLAY_VIDEO_SCREEN);
                                      Get.toNamed(Routes.PLAY_VIDEO_SCREEN,
                                          arguments: [
                                            bibleController.savedVideos[index]
                                                .path,
                                            "CaptureVideo"
                                          ]);
                                    },
                                    child: CustomWidgets.squreContainer(
                                      // height: 10.h,
                                      //   width: 15.w,
                                        image: MemoryImage(snapshot.data!),
                                        boxFit: BoxFit.fill,
                                        child: BlurryContainer(
                                            blur: 1,
                                            elevation: 1,
                                            color: AppColors.bgColor
                                                .withOpacity(.07),
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            // height: 10.h,
                                            // width: 15.w,
                                            child: Image.asset(
                                              Assets.iconMenuVideo,
                                              scale: 2,
                                            ))),
                                  );
                                }
                              });
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 3.w,
                          );
                        },
                      )
                      ;
                    }),
                  ),

                ],
              )) : Container(),

          /// my photos
          bibleController.savedImages.isNotEmpty ?
          CustomWidgets.container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.iconPhoto,
                          scale: 6,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomWidgets.text1(LanguageConstant.myPhoto.tr,
                            fontWeight: FontWeight.w600, fontSize: 9.sp),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.MY_PHOTOS_SCREEN);
                          },
                          child: CustomWidgets.text1(
                            LanguageConstant.showAll.tr,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.whiteColor,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Container(
                    height: 8.h,
                    width: 120.w,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10),
                    child: Obx(() {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: bibleController.savedImages.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.toNamed(Routes.PLAY_VIDEO_SCREEN);
                            },
                            child: CustomWidgets.squreContainer(
                              // height: 10.h,
                              //   width: 15.w,
                                image: AssetImage(Assets.iconFrame),
                                child: CustomWidgets.squreContainer(height: 7.h,
                                    width: 14.w,
                                    image: FileImage(
                                      File(bibleController.savedImages[index].path),
                                    ),
                                    boxFit: BoxFit.cover)),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 2.5.w,
                          );
                        },
                      );
                    }),
                  ),
                ],
              )) : Container(),

          /// my voice
          bibleController.savedAudios.isNotEmpty ?
          CustomWidgets.container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.iconVoice,
                          scale: 6,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CustomWidgets.text1(LanguageConstant.myVoice.tr,
                            fontWeight: FontWeight.w600, fontSize: 9.sp),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.MY_AUDIO_SCREEN);
                          },
                          child: CustomWidgets.text1(
                            LanguageConstant.showAll.tr,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.whiteColor,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, right: 10, left: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            5,
                                (index) =>
                                Container(
                                  height: 7.h,
                                  width: 14.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.bgColor,
                                      // image: DecorationImage(image: AssetImage(image), scale: size, fit: boxFit),
                                      borderRadius: BorderRadius.circular(10)),
                                ))),
                  ),
                ],
              )) : Container(),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }
}
