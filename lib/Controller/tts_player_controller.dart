import 'dart:developer';

import 'package:bible_app/Screens/Dashboard/Menu/Search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:text_to_speech/text_to_speech.dart';

import '../Models/bible_model.dart';
import '../Screens/Dashboard/Menu/Language/language_constant.dart';
import 'bible_controller.dart';

class TTSPlayerController extends GetxController {
   ScrollController scrollController = ScrollController();
  final TextToSpeech tts = TextToSpeech();
  RxDouble volume = 1.0.obs;
  RxDouble rate = 1.0.obs;
  RxDouble pitch = 1.0.obs;

  RxInt highlightedIndex = 0.obs;
  bool get supportPause => defaultTargetPlatform != TargetPlatform.android;

  bool get supportResume => defaultTargetPlatform != TargetPlatform.android;
  // List<String> sentences = [];
  int currentSentenceIndex = 0;
  BibleController bibleController = Get.put(BibleController());
  RxBool isPlaying = false.obs;
  RxBool isShowScrollIndi = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initializeTTS(); // Set your desired language code here
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tts.pause();
    tts.stop();
    scrollController.dispose();
  }

  void _initializeTTS() async {

    bool isEmpty = GetStorage().read(selectedLanuage) != null;
    String lang;
    if (isEmpty == true) {
      String lang =  GetStorage().read(selectedLanuage);
      if(lang == null){
        final Locale? defaultSystemLocale = Get.deviceLocale;
        lang = defaultSystemLocale as String;
      }
      await tts.setLanguage(lang);
    }


    await tts.setPitch(1.0);
    // await tts.setSpeechRate(1.0);
    await tts.setVolume(1.0);
  }

  Future<void> _speakSentence(String sentence) async {
    await tts.speak(sentence);
  }

  Future<void> stopSpeech() async {
    await tts.stop();
  }

  Future<void> startReading() async {
    isPlaying.value = true;
    for (int i = 0; i < bibleController.verseList.length; i++) {
      if (!isPlaying.value) break; // Stop reading if the user pauses
      // Highlight the current sentence
      highlightedIndex.value = i;
      await tts.setRate(rate.value);
      await tts.setPitch(pitch.value);
      await tts.setVolume(volume.value);

      // Delay before starting the next sentence
      if (i < bibleController.verseList.length - 1) {
        await _speakSentence(bibleController.verseList[i].verseText.toString());
        await scrollToNextSentence(bibleController.verseList[i].verseText.toString());
      }
      // await Future.delayed(Duration(milliseconds: 10));
    }
    isPlaying.value = false;
  }

  Future<void> startDefaultReading() async {
    isPlaying.value = true;
    for (int i = 0; i <bibleController.oldTestamentList[0].chapters![0].verse!.length ; i++) {
      if (!isPlaying.value) break; // Stop reading if the user pauses
      // Highlight the current sentence
      highlightedIndex.value = i;
      await tts.setRate(rate.value);
      await tts.setPitch(pitch.value);
      await tts.setVolume(volume.value);

      // Delay before starting the next sentence
      if (i < bibleController.oldTestamentList[0].chapters![0].verse!.length - 1) {
        await _speakSentence(bibleController.oldTestamentList[0].chapters![0].verse![i].verseText.toString());
        await scrollToNextSentence(bibleController.oldTestamentList[0].chapters![0].verse![i].verseText.toString());
      }
      // await Future.delayed(Duration(milliseconds: 10));
    }
    isPlaying.value = false;
  }

  Future<void> scrollToNextSentence(String sentence) async {
    final sentenceWords = sentence.split(' ');
    final speakingDuration = Duration(seconds: (sentenceWords.length / 2).toInt());
    // final speakingDuration = Duration(seconds: 10);
    await Future.delayed(speakingDuration);

    // Scroll to the next sentence
    if (highlightedIndex < bibleController.verseList.length - 1) {
      highlightedIndex++;
      final double scrollOffset = (highlightedIndex * 150.0) - 40.0;
      await scrollController.animateTo(
        scrollOffset, // Adjust the item height accordingly
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Future<void> speakWithHighlight() async {
  //   for (int i = 0; i < bibleController.verseList.length; i++) {
  //     final sentence = bibleController.verseList[i].verseText.toString();
  //
  //
  //       highlightedIndex.value = i;
  //
  //
  //     await tts.setRate(rate);
  //     await tts.setPitch(pitch);
  //     await tts.setVolume(volume);
  //     await tts.speak(sentence);
  //
  //     // Calculate the approximate time needed for the sentence to be spoken
  //     final sentenceWords = sentence.split(' ');
  //     final speakingDuration = Duration(seconds: sentenceWords.length ~/ 2);
  //
  //     // Delay the next sentence by the speaking duration
  //     // await Future.delayed(speakingDuration);
  //     if (i < bibleController.verseList.length - 1) {
  //       await Future.delayed(speakingDuration);
  //       _scrollToNextSentence();
  //     }
  //     // Scroll to the next sentence
  //
  //   }
  // }
  //
  // void _scrollToNextSentence() {
  //   final double lineHeight = 30.0; // Adjust based on your text size
  //   final double scrollToY = currentSentenceIndex * lineHeight;
  //   scrollController.animateTo(
  //     scrollController.position.extentAfter,
  //     duration: Duration(milliseconds: 600),
  //     curve: Curves.easeInOut,
  //   );
  //
  //   currentSentenceIndex++;
  // }
}
