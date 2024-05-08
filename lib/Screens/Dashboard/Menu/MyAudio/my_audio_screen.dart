// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/widgets/custom_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../Routes/routes.dart';
import '../../../../Widgets/custom_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../services/video_database_helper.dart';
import '../../Bible/Voice_Record/audio_record.dart';

class MyAudioScreen extends StatefulWidget {
  const MyAudioScreen({super.key});

  @override
  State<MyAudioScreen> createState() => _MyAudioScreenState();
}

class _MyAudioScreenState extends State<MyAudioScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BibleController bibleController = Get.put(BibleController());
  final VideoDatabaseHelper dbHelper = VideoDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchSavedVideos();
  }

  Future<void> _fetchSavedVideos() async {
    bibleController.savedAudios.value = await dbHelper.getAudiosWithVerseNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        key: _scaffoldKey,
        appBar: CustomAppbar.appbar(
          scaffoldKey: _scaffoldKey,
          title: LanguageConstant.myAudio.tr,
          centerTitle: true,
          isBackIcon: true,
        ),
        body: Obx(
          () => bibleController.savedAudios.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.builder(
                    itemCount: bibleController.savedAudios.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 5, crossAxisSpacing: 8, maxCrossAxisExtent: 120, mainAxisExtent: 140),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              bibleController.showPlayer.value = true;
                              bibleController.isRecordVoice.value = true;
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.aapbarColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Image.asset(
                                  Assets.iconAudioIcon,
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
                            child:CustomWidgets.text1(bibleController.savedAudios[index].verseName,
                                fontSize: 8.sp, color: AppColors.whiteColor, overflow: TextOverflow.ellipsis, maxLine: 1),
                          )
                        ],
                      );
                    },
                  ),
                )
              : Center(
                  child: CustomWidgets.text1("No Audio Found", fontWeight: FontWeight.w600, fontSize: 9.sp, color: AppColors.whiteColor),
                ),
        ),
        bottomNavigationBar: Obx(
          () => bibleController.isRecordVoice.value == true
              ? AudioRecordScreen(
                  verseName: "Genesis 1:${1 + 1}",
                  onStop: (path) {
                    if (kDebugMode) print('Recorded file path: $path');

                    bibleController.audioPath = path.obs;
                    // bibleController.showPlayer.value = true;
                  },
                )
              : SizedBox(),
        ));
  }
}
