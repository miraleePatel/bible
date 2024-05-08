// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:bible_app/Controller/bible_controller.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Voice_Record/audio_player.dart';
import 'package:bible_app/Widgets/custom_widget.dart';
import 'package:bible_app/services/video_database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import 'package:sizer/sizer.dart';
import '../../../../Utils/app_colors.dart';

class AudioRecordScreen extends StatefulWidget {
  final void Function(String path) onStop;
  final String verseName;
  const AudioRecordScreen({super.key, required this.onStop, required this.verseName});

  @override
  State<AudioRecordScreen> createState() => _AudioRecordScreenState();
}

class _AudioRecordScreenState extends State<AudioRecordScreen> {
  final VideoDatabaseHelper dbHelper = VideoDatabaseHelper.instance;
  BibleController bibleController = Get.put(BibleController());
  StreamSubscription<RecordState>? recordSub;
  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }

  @override
  void initState() {
    bibleController.audioRecorder = AudioRecorder();

    recordSub = bibleController.audioRecorder.onStateChanged().listen((recordState) {
      _updateRecordState(recordState);
    });

    /* _amplitudeSub = bibleController.audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      setState(() => _amplitude = amp);
    }); */

    super.initState();
  }

  void _updateRecordState(RecordState recordState) {
    bibleController.recordState.value = recordState;

    switch (recordState) {
      case RecordState.pause:
        bibleController.timer?.cancel();
        break;
      case RecordState.record:
        bibleController.startTimer();
        break;
      case RecordState.stop:
        bibleController.timer?.cancel();
        bibleController.recordDuration.value = 0;
        break;
    }
  }

  void startTimer() {
    bibleController.timer?.cancel();

    bibleController.timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => bibleController.recordDuration.value++);
    });
  }

  @override
  void dispose() {
    log("dispose call");
    // bibleController.timer?.cancel();
    recordSub?.cancel();
    // bibleController.audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 12.h,
        decoration: BoxDecoration(
          color: AppColors.aapbarColor,
        ),
        child: Obx(
          () => bibleController.showPlayer.value
              ? AudioPlayer(
                  source: bibleController.audioPath.value,
                  onDelete: () {
                    bibleController.showPlayer.value = false;
                  },
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: AppColors.whiteColor.withOpacity(0.2),
                        child: InkWell(
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: (bibleController.recordState.value != RecordState.stop)
                                  ? Icon(Icons.stop, color: Colors.red, size: 30)
                                  : Icon(Icons.mic, color: AppColors.whiteColor, size: 30)),
                          onTap: () {
                            log("message--------------- ${bibleController.recordState.value}");
                            (bibleController.recordState.value != RecordState.stop) ? _stop() : _start();
                          },
                        ),
                      ),
                    ),
                    //  _buildRecordStopControl(context),
                    const SizedBox(width: 20),
                    ClipOval(
                      child: Material(
                        color: AppColors.whiteColor.withOpacity(0.2),
                        child: InkWell(
                          child: (bibleController.recordState.value == RecordState.stop)
                              ? SizedBox()
                              : SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: (bibleController.recordState.value == RecordState.record)
                                      ? Icon(Icons.pause, color: Colors.red, size: 30)
                                      : Icon(Icons.play_arrow, color: Colors.red, size: 30)),
                          onTap: () {
                            (bibleController.recordState.value == RecordState.pause) ? _resume() : _pause();
                          },
                        ),
                      ),
                    ),

                    // _buildPauseResumeControl(context),
                    const SizedBox(width: 20),

                    (bibleController.recordState.value != RecordState.stop)
                        ? Text(
                            '${_formatNumber(bibleController.recordDuration.value ~/ 60)} : ${_formatNumber(bibleController.recordDuration.value % 60)}',
                            style: const TextStyle(color: AppColors.whiteColor),
                          )
                        : CustomWidgets.text1("Waiting to record", color: AppColors.whiteColor, fontSize: 8.sp)
                  ],
                ),
        ));
  }

  Future<void> _pause() => bibleController.audioRecorder.pause();

  Future<void> _resume() => bibleController.audioRecorder.resume();

  Future<void> _start() async {
    try {
      if (await bibleController.audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.wav;

        // We don't do anything with this but printing
        final isSupported = await bibleController.audioRecorder.isEncoderSupported(
          encoder,
        );

        debugPrint('${encoder.name} supported: $isSupported');

        final devs = await bibleController.audioRecorder.listInputDevices();
        debugPrint(devs.toString());

        const config = RecordConfig(encoder: encoder, numChannels: 1);

        // Record to file
        String path;
        if (kIsWeb) {
          path = '';
        } else {
          final dir = await getApplicationDocumentsDirectory();
          path = p.join(
            dir.path,
            'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
          );
        }
        await bibleController.audioRecorder.start(config, path: path);

        bibleController.recordDuration.value = 0;

        bibleController.startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    final path = await bibleController.audioRecorder.stop();
    log("path ======== $path");

    if (path != null) {
      widget.onStop(path);
      await dbHelper
          .insertAudio(path, widget.verseName)
          .then((value) async => bibleController.savedAudios.value = await dbHelper.getAudiosWithVerseNames());
    }
  }

}
