import 'dart:io';
import 'dart:typed_data';
import 'package:bible_app/Controller/dashboard_controller.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_appbar.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../Controller/bible_controller.dart';
import '../../../../generated/assets.dart';
import '../../../../services/video_database_helper.dart';

class MyVideoScreen extends StatefulWidget {
  const MyVideoScreen({super.key});

  @override
  State<MyVideoScreen> createState() => _MyVideoScreenState();
}

class _MyVideoScreenState extends State<MyVideoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardController dashboardController = Get.put(DashboardController());
  BibleController bibleController = Get.put(BibleController());
  final VideoDatabaseHelper dbHelper = VideoDatabaseHelper.instance;

  bool showAll = false;

  @override
  void initState() {
    super.initState();
    _fetchSavedVideos();
  }

  Future<void> _fetchSavedVideos() async {
    bibleController.savedVideos.value = await dbHelper.getVideosWithVerseNamesAndThumbnails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      key: _scaffoldKey,
      appBar: CustomAppbar.appbar(
        scaffoldKey: _scaffoldKey,
        title: LanguageConstant.myVideo.tr,
        centerTitle: true,
        isBackIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          return bibleController.savedVideos.isNotEmpty
              ? GridView.builder(
                  itemCount: bibleController.savedVideos.length,
                  gridDelegate:
                      SliverGridDelegateWithMaxCrossAxisExtent(mainAxisSpacing: 5, crossAxisSpacing: 8, maxCrossAxisExtent: 120, mainAxisExtent: 140
                          // crossAxisCount: 3,
                          ),
                  itemBuilder: (context, index) {
                    return FutureBuilder<Uint8List>(
                        future: bibleController.generateThumbnail(bibleController.savedVideos.value[index].path),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CupertinoActivityIndicator(
                              color: AppColors.yellowColor,
                              radius: 10,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error loading thumbnail');
                          } else if (!snapshot.hasData) {
                            return SizedBox(); // Placeholder, or handle differently
                          } else {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.PLAY_VIDEO_SCREEN, arguments: [bibleController.savedVideos[index].path, bibleController.savedVideos.value[index].verseName]);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: AppColors.aapbarColor,
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(image: MemoryImage(snapshot.data!), fit: BoxFit.cover)),
                                      ),
                                      Image.asset(
                                        Assets.iconPlayVideo,
                                        scale: 11,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.DASHBOARD_SCREEN, arguments: 1.obs);
                                  },
                                  child: CustomWidgets.text1(bibleController.savedVideos.value[index].verseName,
                                      fontSize: 8.sp, color: AppColors.whiteColor, overflow: TextOverflow.ellipsis, maxLine: 1),
                                )
                              ],
                            );
                          }
                        });
                  },
                )
              : Center(
                  child: CustomWidgets.text1("No Video Found", fontWeight: FontWeight.w600, fontSize: 10.sp, color: AppColors.whiteColor),
                );
        }),
      ),
    );
  }
}
