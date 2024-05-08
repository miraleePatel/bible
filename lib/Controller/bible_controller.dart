import 'dart:async';
import 'dart:io';
import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Models/bible_model.dart';
import 'package:bible_app/Repository/bible_repository.dart';
import 'package:bible_app/services/audio_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../Models/get_bookmark_model.dart';
import '../Models/get_highlight_model.dart';
import '../Models/get_highlight_model.dart';
import '../Models/get_verse_model.dart';
import '../Models/serach_verse_model.dart';
import '../Models/success_model.dart';
import '../Models/verse_comment_model.dart';
import '../Routes/routes.dart';
import '../Utils/constants.dart';
import '../Utils/string_constant.dart';
import '../services/image_model.dart';
import '../services/video_model.dart';
import 'language_controller.dart';

class BibleController extends GetxController {

  BibleRepository bibleRepository = BibleRepository(APIManager());
  // RxInt selectIconIndex= (-1).obs;
  late TabController tabIndexController;

  RxInt selectIndexBook = (0).obs;
  RxInt selectIndexChapter = (0).obs;
  RxInt selectIndexVerse = (0).obs;
  RxInt selectIconIndex = (0).obs;

  RxBool isImageListVisible = true.obs;
  RxBool itemIconListVisibility = false.obs;

  TextEditingController commentNoteController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  RxString selectedComNote = "Private Note".obs;
  RxDouble fontSize = 9.0.sp.obs;
  RxInt selectIcon = 2.obs;
  RxList<Color> selectColor = <Color>[].obs;
  RxInt selectColorIndex = (-1).obs;
  RxInt selectVerse = 0.obs;
  RxString selectNote = "Private Note".obs;
  RxBool isShowResult = false.obs;
  RxBool isTestament = false.obs;
  RxInt isFilterBookType = (0).obs;
  RxInt isFilterBookOption = (-1).obs;
  var imageName = ''.obs;
  var imagePath = ''.obs;
  var videoPath = "".obs;
  Rx<Uint8List?> video = Uint8List(0).obs;
  RxList<VideoModel> savedVideos = <VideoModel>[].obs;
  RxList<ImageModel> savedImages = <ImageModel>[].obs;

  // record voice
  RxBool isRecordVoice = false.obs;
  Rx<RecordState> recordState = RecordState.stop.obs;
  AudioRecorder audioRecorder = AudioRecorder();
  RxInt recordDuration = 0.obs;
  Timer? timer;
  RxBool showPlayer = false.obs;
  RxString audioPath = "".obs;
  RxList<AudioModel> savedAudios = <AudioModel>[].obs;
  RxList imageList = [].obs;

  // RxList<OldTestament> searchBottomBookList = <OldTestament>[].obs;
  RxList<OldTestament> oldTestamentList = <OldTestament>[].obs;
  RxList<OldTestament> newTestamentList = <OldTestament>[].obs;
  RxList<OldTestament> allBibleList = <OldTestament>[].obs;
  RxList<Verse> filterList = <Verse>[].obs;
  RxList<Verse> verseList = <Verse>[].obs;

  Rx<Verse> singleVerseData = Verse().obs;
  Rx<Chapters> singleChaptersData = Chapters().obs;
  Rx<OldTestament> singleBibleData = OldTestament().obs;
  // RxList<SearchVerseData> searchDataList = <SearchVerseData>[].obs;
  var searchBook = "ALL".obs;
  var bibleearchString = ''.obs;
  int currentPage = 1;
  int batchSize = 10;
  RxList<HighlightData> highlightList = <HighlightData>[].obs;
  RxList<BookmarkData> bookmarkList = <BookmarkData>[].obs;
  int pageIndexHigh = 0;
  int pageIndexMark = 0;
  LanguageController languageController = Get.put(LanguageController());

  final List<String> items = ["Public Note", "Private Note"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  /// Image Picker
  Future<File> openImagePicker(ImageSource sourceData) async {
    XFile? xFile = await ImagePicker().pickImage(
      source: sourceData,
    );
    return File(xFile!.path);
  }

  /// Video Picker
  Future<File> openVideoPicker(ImageSource sourceData) async {
    XFile? xFile = await ImagePicker().pickVideo(
      source: sourceData,
    );
    return File(xFile!.path);
  }

  Future<Uint8List> generateThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxWidth: 100, // Adjust thumbnail dimensions as needed
      quality: 50, // Adjust quality as needed
    );
    return thumbnail!;
  }

  void updateRecordState(RecordState recordState) {
    recordState = recordState;

    switch (recordState) {
      case RecordState.pause:
        timer?.cancel();
        break;
      case RecordState.record:
        startTimer();
        break;
      case RecordState.stop:
        timer?.cancel();
        recordDuration.value = 0;
        break;
    }
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      /*  setState(() => */ recordDuration.value++;
      //  );
    });
  }


  // **************** Get bible data *******************************
  Future<void> storeEngBible({bool isLoaderShow = true}) async {
    String key = 'englishBible';
    if (isInternetAvailable.value == true) {
      oldTestamentList.clear();
      newTestamentList.clear();
      try {
        BibleModel bibleModel = await bibleRepository.bibleAllDataApiCall(
            language: "english",isLoaderShow: isLoaderShow);

        Box box = await Hive.openBox(
            bibleDataBox); // Replace 'myBox' with your preferred box name.


        if (bibleModel != null && bibleModel.status == 1) {
          await box.put(key, bibleModel.data);
          oldTestamentList.addAll(bibleModel.data!.oldTestament!);
          newTestamentList.addAll(bibleModel.data!.newTestament!);
          singleBibleData.value = bibleModel.data!.oldTestament![0];
          singleChaptersData.value =
          bibleModel.data!.oldTestament![0].chapters![0];
          singleVerseData.value =
          bibleModel.data!.oldTestament![0].chapters![0].verse![0];
          allBibleList.value = List<OldTestament>.from(oldTestamentList);
          allBibleList.value.addAll(newTestamentList);
          print("✅ English Data has been put into Hive successfully");
          // Get.offAllNamed(Routes.DASHBOARD_SCREEN);
                }
      } catch (e) {
        print("❌ Error putting data into Hive: $e");

        dismissProgressIndicator();
      }
    }

  }

  Future<void> storeFrenchBible({bool isLoaderShow = true}) async {
    String key = 'frenchBible';
    if (isInternetAvailable.value == true) {
      oldTestamentList.clear();
      newTestamentList.clear();
      try {
        BibleModel bibleModel = await bibleRepository.bibleAllDataApiCall(
            language: "french",isLoaderShow: isLoaderShow);

        Box box = await Hive.openBox(
            bibleDataBox); // Replace 'myBox' with your preferred box name.


        if (bibleModel != null && bibleModel.status == 1) {
          await box.put(key, bibleModel.data);
          oldTestamentList.addAll(bibleModel.data!.oldTestament!);
          newTestamentList.addAll(bibleModel.data!.newTestament!);
          singleBibleData.value = bibleModel.data!.oldTestament![0];
          singleChaptersData.value =
          bibleModel.data!.oldTestament![0].chapters![0];
          singleVerseData.value =
          bibleModel.data!.oldTestament![0].chapters![0].verse![0];
          allBibleList.value = List<OldTestament>.from(oldTestamentList);
          allBibleList.value.addAll(newTestamentList);
          print("✅ French Data has been put into Hive successfully");
          Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        }
      } catch (e) {
        print("❌ Error putting data into Hive: $e");

        dismissProgressIndicator();
      }
    }
  }

  Future<void> getLocalBible({required String key}) async {
    if (isInternetAvailable.value != true){
      oldTestamentList.clear();
      newTestamentList.clear();
      try {
        Box box = await Hive.openBox(
            bibleDataBox); // Replace 'myBox' with your preferred box name

        if (box.containsKey(key)) {
          BibleData? bibleModel = await box.get(key);

          if (bibleModel != null) {
            oldTestamentList.addAll(bibleModel.oldTestament!);
            newTestamentList.addAll(bibleModel.newTestament!);
            singleBibleData.value = bibleModel.oldTestament![0];
            singleChaptersData.value = bibleModel.oldTestament![0].chapters![0];
            singleVerseData.value =
            bibleModel.oldTestament![0].chapters![0].verse![0];
            allBibleList.value =
            List<OldTestament>.from(bibleModel.oldTestament!);
            allBibleList.value.addAll(bibleModel.newTestament!);
            print("✅ Data retrieved from Hive successfully");
            print(
                "Old Testament List Length After.......: ${oldTestamentList.length}");
            print(
                "Old Testament List Length After........: ${newTestamentList.length}");
          } else {
            print("❌ Data retrieved from Hive is null");
          }
        } else {
          print("❌ Data with key '$key' not found in Hive");
        }
      } catch (e) {
        print("❌ Error getting data from Hive: $e");
        // Handle errors here
      }
    }else{
      getAllBibleData();
    }
  }

  /// get bible All data & bible data store in hive
  getAllBibleData() async {
    oldTestamentList.clear();
    newTestamentList.clear();

    BibleModel bibleModel = await bibleRepository.bibleAllDataApiCall(
        language: languageController.selectedLang.value);
    // Replace 'myBox' with your preferred box name.

    if (bibleModel != null && bibleModel.status == 1) {

      oldTestamentList.addAll(bibleModel.data!.oldTestament!);
      newTestamentList.addAll(bibleModel.data!.newTestament!);
      singleBibleData.value = bibleModel.data!.oldTestament![0];
      singleChaptersData.value =
      bibleModel.data!.oldTestament![0].chapters![0];
      singleVerseData.value =
      bibleModel.data!.oldTestament![0].chapters![0].verse![0];
      allBibleList.value = List<OldTestament>.from(oldTestamentList);
      allBibleList.value.addAll(newTestamentList);

    }



  }


 /* /// get bible All data & bible data store in hive
  Future<void> getAllBibleData() async {
    String key = 'bibleData';

    print(oldTestamentList.length);
    if (isInternetAvailable.value == true) {
      // oldTestamentList.clear();
      // newTestamentList.clear();
      try {
        BibleModel bibleModel = await bibleRepository.bibleAllDataApiCall(
            language: languageController.selectedLang.value);
        Box box = await Hive.openBox(
            'bibleDataBox'); // Replace 'myBox' with your preferred box name.
        final key = 'bibleData';

        if (bibleModel != null && bibleModel.status == 1) {
          await box.put(key, bibleModel.data);
          oldTestamentList.addAll(bibleModel.data!.oldTestament!);
          newTestamentList.addAll(bibleModel.data!.newTestament!);
          singleBibleData.value = bibleModel.data!.oldTestament![0];
          singleChaptersData.value =
          bibleModel.data!.oldTestament![0].chapters![0];
          singleVerseData.value =
          bibleModel.data!.oldTestament![0].chapters![0].verse![0];
          allBibleList.value = List<OldTestament>.from(oldTestamentList);
          allBibleList.value.addAll(newTestamentList);
          print("✅ Data has been put into Hive successfully");
        }
      } catch (e) {
        print("❌ Error putting data into Hive: $e");

        dismissProgressIndicator();
      }
    } else {
      oldTestamentList.clear();
      newTestamentList.clear();
      try {
        Box box = await Hive.openBox(
            'bibleDataBox'); // Replace 'myBox' with your preferred box name

        if (box.containsKey(key)) {
          BibleData? bibleModel = await box.get(key);

          if (bibleModel != null) {
            oldTestamentList.addAll(bibleModel.oldTestament!);
            newTestamentList.addAll(bibleModel.newTestament!);
            singleBibleData.value = bibleModel.oldTestament![0];
            singleChaptersData.value = bibleModel.oldTestament![0].chapters![0];
            singleVerseData.value =
            bibleModel.oldTestament![0].chapters![0].verse![0];
            allBibleList.value =
            List<OldTestament>.from(bibleModel.oldTestament!);
            allBibleList.value.addAll(bibleModel.newTestament!);
            print("✅ Data retrieved from Hive successfully");
            print(
                "Old Testament List Length After.......: ${oldTestamentList.length}");
            print(
                "Old Testament List Length After........: ${newTestamentList.length}");
          } else {
            print("❌ Data retrieved from Hive is null");
          }
        } else {
          print("❌ Data with key '$key' not found in Hive");
        }
      } catch (e) {
        print("❌ Error getting data from Hive: $e");
        // Handle errors here
      }
    }
  }

  */

  RxInt bibleCurrentIndex = 0.obs;
  RxList<Chapters> chapterPagination = <Chapters>[].obs;
  void loadNextChapter({ List<Chapters>? chapter}) {
    if (bibleCurrentIndex< chapter!.length - 1) {
      bibleCurrentIndex++;
    }
  }

  void loadPreviousChapter() {
    if (bibleCurrentIndex > 0) {

        bibleCurrentIndex--;

    }
  }



  filterBible({String? searchValue}) {
    print("searchValue........${searchValue}");
    // filterList.clear();
    List<Verse> temp = [];
    temp.clear();
    for (var element in allBibleList) {
      /// filter book type according
      if (element.testament == searchValue) {
        for (var testament in element.chapters!) {
          temp.addAll(testament.verse!);
        }
        /// filter all data
      } else if (searchValue == "ALL") {
        for (var testament in element.chapters!) {
          temp.addAll(testament.verse!);
        }
        /// filter book name according
      } else if (element.name == searchValue) {
        for (var testament in element.chapters!) {
          temp.addAll(testament.verse!);
        }
      }
    }

    showProgressIndicator();
    Future.delayed(Duration(seconds: 2), () {
      int startIndex = currentPage * batchSize;
      filterList.addAll(temp
          .where((element) =>
      (element.verseText!.toLowerCase().contains(bibleearchString)))
          .toList()
          .skip(startIndex)
          .take(batchSize)
          .toList());

      // Increment the current page
      currentPage++;
      print("currentPage ${currentPage}");
      print("list length ${filterList.length}");

      dismissProgressIndicator();
    });
  }

  addHighlight(
      { required String verseKey,
        required String color,
      }) async {
    SuccessModel successModel = await bibleRepository.addHighlightApiCall({"verse_key":verseKey,
      "color": color});

    if (successModel.status == 1) {
      /// success message & navigation
      successSnackBar(message: successModel.message);
       }
    else if(successModel.status == 2){
      editHighlight(verseKey:verseKey ,color:color );
     }

    else {
      errorSnackBar(message: successModel.message);
    }
  }

  editHighlight(
      { required String verseKey,
        required String color,
      }) async {
    SuccessModel successModel = await bibleRepository.editHighlightApiCall({"verse_key":verseKey,
      "color": color});

    if (successModel.status == 1) {
      /// success message & navigation
      successSnackBar(message: successModel.message);

    } else {
      errorSnackBar(message: successModel.message);
    }
  }

  addBookmark(
      { required String verseKey,

      }) async {
    SuccessModel successModel = await bibleRepository.addBookmarkApiCall(verseKey: verseKey);

    if (successModel.status == 1) {
      /// success message & navigation
      successSnackBar(message: successModel.message);

    } else {
      errorSnackBar(message: successModel.message);
    }
  }


  /// getHighlight
  getHighlight() async {
    pageIndexHigh = pageIndexHigh + 1;
    if (highlightList.isEmpty ||
        (highlightList.length >= 10 && highlightList.length % 10 == 0 )) {
      GetHighlightModel getHighlightModel =
      await bibleRepository.getHighlightApiCall(language:
      languageController.selectedLang.value,page:pageIndexHigh  );
      if (getHighlightModel.status == 1) {
        highlightList.addAll(getHighlightModel.data!);
      }
      return true;
    }
  }
  /// get user all Notes
  getBookmark() async {
    pageIndexMark = pageIndexMark + 1;
    if (bookmarkList.isEmpty ||
        (bookmarkList.length >= 10 && bookmarkList.length % 10 == 0 )) {
      GetBookmarkModel getBookmarkModel =
      await bibleRepository.getBookmarkApiCall(language:
      languageController.selectedLang.value,page:pageIndexMark  );
      if (getBookmarkModel.status == 1) {
        bookmarkList.addAll(getBookmarkModel.data!);
      }
    }
  }

 removeBookmark(
      { required String verseKey,

      }) async {
    SuccessModel successModel = await bibleRepository.removeBookmarkApiCall(verseKey: verseKey);

    if (successModel.status == 1) {
      /// success message & navigation
      successSnackBar(message: successModel.message);
      getBookmark();
    } else {
      errorSnackBar(message: successModel.message);
    }
  }
  removeHighlight(
      { required String verseKey,

      }) async {
    SuccessModel successModel = await bibleRepository.removeHighlightApiCall(verseKey: verseKey);

    if (successModel.status == 1) {
      /// success message & navigation
      successSnackBar(message: successModel.message);
      getHighlight();
    } else {
      errorSnackBar(message: successModel.message);
    }
  }

/*
  /// get bible & bible book name
  getBibleData({required String testament}) async {
    bibleDataList.clear();
    final biblebook = await bibleRepository.getBookTypeDataApiCall(language: languageController.selectedLang.value, testament: testament);
    if (biblebook.status == 1) {
      bibleDataList.addAll(biblebook.data!);
    }
  }*/

/*  /// search screen bottom data
  getSearchBookList({required String testament}) async {
    searchBottomBookList.clear();
    searchBook.value = "";
    final biblebook = await bibleRepository.getBookTypeDataApiCall(
        language: languageController.selectedLang.value, testament: testament);
    if (biblebook.status == 1) {
      searchBottomBookList.addAll(biblebook.data!.oldTestament!);
      for (var element in searchBottomBookList) {
        searchBook.value +=
            "${element.bookId},"; // Concatenate the names with a comma
      }
      if (searchBook.isNotEmpty) {
        searchBook.value = searchBook.substring(0, searchBook.value.length - 1);
      }
      print(searchBook);
    }
    // Initialize data as an empty string
  }*/

/*  /// search screen get verse data
  getSearchVerseData({required String book}) async {
    // searchDataList.clear();

    pageIndex = pageIndex + 1;
    if (searchDataList.isEmpty ||
        (searchDataList.length >= 10 && searchDataList.length % 10 == 0)) {
      SearchVerseModel searchVerseModel = await bibleRepository.searchApiCall(
          language: languageController.selectedLang.value,
          searchText: searchController.text,
          book: book,
          page: pageIndex);
      if (searchVerseModel.status == 1) {
        searchDataList.addAll(searchVerseModel.data!.data!);
      }
    }
  }*/
/*
  /// get bible & bible book name
  getVerseCommentData({required String key}) async {
    verseCommentList.clear();
    verseVideoList.clear();
    VerseCommentModel verseCommentModel =
        await bibleRepository.verseCommnetApiCall(key: key);
    if (verseCommentModel.status == 1) {
      verseCommentList.addAll(verseCommentModel.data!.comment!);
      verseVideoList.addAll(verseCommentModel.data!.video!);
    }
  }*/


}
