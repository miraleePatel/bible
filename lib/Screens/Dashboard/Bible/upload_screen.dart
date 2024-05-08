// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:bible_app/services/audio_model.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../Controller/bible_controller.dart';
import '../../../Routes/routes.dart';
import '../../../services/video_database_helper.dart';
import '../Menu/Language/language_constant.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/permission_service.dart';
import '../../../generated/assets.dart';
import '../../../widgets/custom_widget.dart';

class UploadScreen extends StatefulWidget {
  String? verseName;

  UploadScreen({super.key, this.verseName});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final VideoDatabaseHelper dbHelper = VideoDatabaseHelper.instance;
  BibleController bibleController = Get.put(BibleController());
  StreamSubscription<RecordState>? recordSub;
  StreamSubscription<Amplitude>? amplitudeSub;
  Amplitude? amplitude;
  @override
  void initState() {
    super.initState();
    _fetchSavedVideos();
  }

  Future<void> _fetchSavedVideos() async {
    bibleController.savedVideos.value = await dbHelper.getVideosWithVerseNamesAndThumbnails();
    bibleController.savedAudios.value = await dbHelper.getAudiosWithVerseNames();
    bibleController.savedImages.value = await dbHelper.getImageWithVerseNames();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // bibleController.audioRecorder.dispose();
    // bibleController.timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// capture video
        CustomWidgets.container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Row(
                children: [
                  Image.asset(
                    Assets.iconVideo,
                    scale: 6,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  CustomWidgets.text1(LanguageConstant.captureVideo.tr, fontWeight: FontWeight.w600, fontSize: 9.sp),
                  Spacer(),
                  GestureDetector(
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
              color: AppColors.blackColor.withOpacity(0.4),
              thickness: 0.5,
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 8.h,
              // width: 120.w,
              padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
              child: Row(
                children: [
                  /// add video

                  GestureDetector(
                    onTap: () async {
                      Platform.isIOS
                          ? await bibleController.openVideoPicker(ImageSource.camera).then((value) async {
                              if (value.path.isNotEmpty || value.path != "") {
                                bibleController.videoPath.value = value.path;
                                bibleController.video.value = await VideoThumbnail.thumbnailData(
                                  video: bibleController.videoPath.value,
                                  imageFormat: ImageFormat.JPEG,
                                  quality: 100,
                                );
                                await dbHelper
                                    .insertVideo(value.path, widget.verseName!)
                                    .then((value) async => bibleController.savedVideos.value = await dbHelper.getVideosWithVerseNamesAndThumbnails());

                                // bibleController.imageName.value =
                                //     value.path.split("/").last;
                                // bibleController.imagePath.value = value.path;
                              }
                              print("Image path :::: ${bibleController.videoPath.value}");
                            })
                          : await PermissionHandlerPermissionService.handleCameraPermission(context).then((bool cameraPermission) async {
                              if (cameraPermission == true) {
                                await bibleController.openVideoPicker(ImageSource.camera).then((value) async {
                                  if (value.path.isNotEmpty || value.path != "") {
                                    bibleController.videoPath.value = value.path;
                                    bibleController.video.value = await VideoThumbnail.thumbnailData(
                                      video: bibleController.videoPath.value,
                                      imageFormat: ImageFormat.JPEG,
                                      quality: 100,
                                    );

                                    await dbHelper.insertVideo(value.path, widget.verseName!).then(
                                        (value) async => bibleController.savedVideos.value = await dbHelper.getVideosWithVerseNamesAndThumbnails());

                                    // bibleController.imageName.value =
                                    //     value.path.split("/").last;
                                    // bibleController.imagePath.value = value.path;
                                  }
                                  print("Image path :::: ${bibleController.videoPath.value}");
                                });
                              }
                            });
                    },
                    child: Container(
                      height: 14.h,
                      width: 14.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.texfeildColor),
                      child: Icon(
                        Icons.add,
                        color: AppColors.blackColor,
                        size: 40,
                      ),
                    ),
                  ),




                  /// video list
                  Expanded(
                    child: Obx(() {
                      /*  List<VideoModel> displayedVideos =
                          bibleController.savedVideos.sublist(
                              0,
                              bibleController.savedVideos.length > 4
                                  ? 4
                                  : bibleController.savedVideos.length); */
                      return bibleController.savedVideos.isNotEmpty
                          ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              reverse: false,
                              itemCount: bibleController.savedVideos.length > 4 ? 4 : bibleController.savedVideos.length,
                              // displayedVideos.length,
                              itemBuilder: (context, index) {
                              return FutureBuilder<Uint8List>(
                                    future: bibleController.savedVideos[index].verseName == widget.verseName ? bibleController.generateThumbnail(bibleController.savedVideos[index].path) : null,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                                arguments: [bibleController.savedVideos[index].path, bibleController.savedVideos[index].verseName]);
                                          },
                                          child: CustomWidgets.squreContainer(
                                              // height: 10.h,
                                              //   width: 15.w,
                                              height: 6.h,
                                              width: 14.w,
                                              image: MemoryImage(snapshot.data!),
                                              boxFit: BoxFit.fill,
                                              child: BlurryContainer(
                                                  blur: 1,
                                                  elevation: 1,
                                                  color: AppColors.bgColor.withOpacity(.07),
                                                  borderRadius: BorderRadius.circular(10),
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
                                  width: 2.w,
                                );
                              },
                            )
                          : Center(
                              child: CustomWidgets.text1("No Video Found", fontWeight: FontWeight.w600, fontSize: 9.sp),
                            );
                    }),
                  ),
                ],
              ),
            ),
          ],
        )),

        ///
        /// capture photos
        CustomWidgets.container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Row(
                children: [
                  Image.asset(
                    Assets.iconPhoto,
                    scale: 6,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  CustomWidgets.text1(LanguageConstant.capturePhoto.tr, fontWeight: FontWeight.w600, fontSize: 9.sp),
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
              color: AppColors.blackColor.withOpacity(0.4),
              thickness: 0.5,
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 8.h,
              // width: 100.w,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  /// add image
                  GestureDetector(
                    onTap: () async {
                      Platform.isIOS
                          ? await bibleController.openImagePicker(ImageSource.camera).then((value) async {
                              if (value.path.isNotEmpty || value.path != "") {
                                bibleController.imageName.value = value.path.split("/").last;
                                bibleController.imagePath.value = value.path;

                                await dbHelper
                                    .insertImage(value.path, widget.verseName!)
                                    .then((value) async => bibleController.savedImages.value = await dbHelper.getImageWithVerseNames());

                              }
                              print("Image Name :::: ${bibleController.imageName}");
                              print("Image Path :::: ${bibleController.imagePath}");
                            })
                          : await PermissionHandlerPermissionService.handleCameraPermission(context).then((bool cameraPermission) async {
                              if (cameraPermission == true) {
                                await bibleController.openImagePicker(ImageSource.camera).then((value) async {
                                  if (value.path.isNotEmpty || value.path != "") {
                                    bibleController.imageName.value = value.path.split("/").last;
                                    bibleController.imagePath.value = value.path;
                                    bibleController.imageList.add(value.path);
                                    await dbHelper
                                        .insertImage(value.path, widget.verseName!)
                                        .then((value) async => bibleController.savedImages.value = await dbHelper.getImageWithVerseNames());

                                  }
                                  print("Image Name :::: ${bibleController.imageName}");
                                  print("Image Path :::: ${bibleController.imagePath}");
                                });
                              }
                            });
                    },
                    child: Container(
                      height: 14.h,
                      width: 14.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.texfeildColor),
                      child: Icon(
                        Icons.add,
                        color: AppColors.blackColor,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),

                  /// image list
                  Expanded(
                    child: Obx(() => bibleController.savedImages.isNotEmpty
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: bibleController.savedImages.length > 4 ? 4 :bibleController.savedImages.length,
                            itemBuilder: (context, index) {
                              return bibleController.savedImages[index].verseName == widget.verseName ?
                              CustomWidgets.squreContainer(
                                  height: 6.h,
                                  width: 14.w,
                                  image: FileImage(
                                    File(bibleController.savedImages[index].path),
                                  ),
                                  boxFit: BoxFit.cover) : Container();
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 2.w,
                              );
                            },
                          )
                        : Center(
                            child: CustomWidgets.text1("No Photo Found", fontWeight: FontWeight.w600, fontSize: 9.sp),
                          )),
                  ),
                ],
              ),
            )
          ],
        )),

        /// capture voice
        CustomWidgets.container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Row(
                children: [
                  Image.asset(
                    Assets.iconVoice,
                    scale: 6,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  CustomWidgets.text1(LanguageConstant.recordVoice.tr, fontWeight: FontWeight.w600, fontSize: 9.sp),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await PermissionHandlerPermissionService.handleMicrophonePermission(context).then((bool microphonePermission) async {
                        if (microphonePermission == true) {
                          Get.toNamed(Routes.MY_AUDIO_SCREEN);
                        }
                      });
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
              color: AppColors.blackColor.withOpacity(0.4),
              thickness: 0.5,
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 8.h,
              width: 120.w,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  /// add voice
                  GestureDetector(
                    onTap: () {
                      bibleController.isRecordVoice.value = !bibleController.isRecordVoice.value;
                      // BottomSheets().voiceRecordingBottomSheet(context);
                      /*  Navigator.push(
                                                   context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) => RecordVoiceScreen())); */
                    },
                    child: Container(
                      height: 14.h,
                      width: 14.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.texfeildColor),
                      child: Icon(
                        Icons.add,
                        color: AppColors.blackColor,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),

                  /// voice list
                  Expanded(
                    child: Obx(() =>
                        /*   RxList<AudioModel> audioList = bibleController.savedAudios
                          .sublist(
                              0,
                              bibleController.savedAudios.length > 4
                                  ? 4
                                  : bibleController.savedAudios.length)
                          .obs; */
                        bibleController.savedAudios.isNotEmpty
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: bibleController.savedAudios.length > 4 ? 4 : bibleController.savedAudios.length,
                                // audioList.length,
                                itemBuilder: (context, index) {
                                  return bibleController.savedAudios[index].verseName ==  widget.verseName ?
                                  GestureDetector(
                                    onTap: () {
                                      bibleController.showPlayer.value = true;
                                      bibleController.isRecordVoice.value = true;
                                    },
                                    child: Container(
                                        height: 6.h,
                                        width: 14.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.bgColor,
                                            // image: DecorationImage(image: AssetImage(image), scale: size, fit: boxFit),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Image.asset(
                                          Assets.iconAudioIcon,
                                          scale: 15,
                                        )),
                                  ): Container();
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 2.w,
                                  );
                                },
                              )
                            : Center(
                                child: CustomWidgets.text1("No Audio Found", fontWeight: FontWeight.w600, fontSize: 9.sp),
                              )),
                  ),
                ],
              ),
            )
          ],
        )),
      ],
    );
  }
}
