// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Menu/Language/language_constant.dart';
import '../../../Utils/app_colors.dart';
import '../../../widgets/custom_widget.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen({super.key});

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late YoutubePlayerController _controller;
  late VideoPlayerController videoPlayerController;
  String? videoId = "";
  bool isPlayReady = false;

  var videoUrl = Get.arguments[0];
  var verseKey = Get.arguments[1];

  void listener() {
    if (isPlayReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        // _playerState = _controller.value.playerState;
        // _videoMetaData = _controller.metadata;
      });
    }
  }

  /*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //  videoId = ModalRoute.of(context)!.settings.arguments as String;
    videoId = YoutubePlayer.convertUrlToId(
        ModalRoute.of(context)!.settings.arguments as String);
    log("video id ------- $videoId");
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(listener);
  } */

  @override
  void initState() {
    super.initState();


      videoPlayerController = VideoPlayerController.file(File(videoUrl))
        ..initialize().then((_) {
          videoPlayerController.play();
          setState(() {});
        });

  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.

      videoPlayerController.dispose();

    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

      videoPlayerController.dispose();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return  videoPlayerController.value.isInitialized
            ? Scaffold(
                backgroundColor: AppColors.bgColor,
                appBar: CustomWidgets.appBar(title: verseKey),
                body: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 80.h,
                    child: GestureDetector(
                      onTap: () {
                        if (videoPlayerController.value.isPlaying) {
                          print("puase");
                          videoPlayerController.pause();
                        } else {
                          print("play");
                          videoPlayerController.play();
                        }
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio: videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(videoPlayerController),
                              ),
                            ),
                            videoPlayerController.value.isPlaying
                                ? Container()
                                : Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                    color: AppColors.whiteColor,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: CupertinoActivityIndicator(),
              );

  }
}
