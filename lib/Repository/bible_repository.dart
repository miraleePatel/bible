import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Api/url_constant.dart';
import 'package:bible_app/Models/bible_model.dart';

import '../Models/add_notes_model.dart';
import '../Models/get_bookmark_model.dart';
import '../Models/get_highlight_model.dart';
import '../Models/get_verse_model.dart';
import '../Models/serach_verse_model.dart';
import '../Models/success_model.dart';
import '../Models/verse_comment_model.dart';

class BibleRepository {
  final APIManager apiManager;

  BibleRepository(this.apiManager);


  /// get bibile all data
  Future<BibleModel> bibleAllDataApiCall({required String language,bool isLoaderShow = true}) async {
    var jsonData = await apiManager.getAPICall(
      // URLConstanst.GET_BIBLE,
        "${URLConstanst.GET_BIBLE}$language",isLoaderShow: isLoaderShow);

    var response = BibleModel.fromJson(jsonData);
    return response;
  }


  /// addhighlight
  Future<SuccessModel> addHighlightApiCall(Map<String, dynamic> params) async {
    // {{base_url}}/api/users/highlight
    var jsonData = await apiManager.postAPICall(
      URLConstanst.ADD_HIGHLIGHT,
      params,
    );
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }
  /// Edit highlight
  Future<SuccessModel> editHighlightApiCall(Map<String, dynamic> params) async {
    // {{base_url}}/api/users/highlight
    var jsonData = await apiManager.postAPICall(
      URLConstanst.EDIT_HIGHLIGHT,
      params,
    );
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }
  /// add bookmark
  Future<SuccessModel> addBookmarkApiCall({required String verseKey}) async {
    // {{base_url}}/api/users/bookmark/:verse_key
    var jsonData = await apiManager.getAPICall(URLConstanst.ADD_BOOKMARK + verseKey);
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

  /// get HighlightApiCall
  Future<GetHighlightModel> getHighlightApiCall({required String language,int? perPage = 10, int? page = 1}) async {
    //{{base_url}}/api/users/get-highlight/:language?perPage=10&page=1
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_HIGHLIGHT}$language?perPage=$perPage&page=$page");
    var response = GetHighlightModel.fromJson(jsonData);
    return response;
  }
  ///  getBookmarkApiCall
  Future<GetBookmarkModel> getBookmarkApiCall({required String language,int? perPage = 10, int? page = 1}) async {
    //{{base_url}}/api/users/get-bookmark/:language?perPage=10&page=1
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_BOOKMARK}$language?perPage=$perPage&page=$page");
    var response = GetBookmarkModel.fromJson(jsonData);
    return response;
  }

  /// remove bookmark
  Future<SuccessModel> removeBookmarkApiCall({required String verseKey}) async {
    // {{base_url}}/api/users/bookmark/:verse_key
    var jsonData = await apiManager.getAPICall(URLConstanst.REMOVE_BOOKMARK + verseKey);
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }
  /// remove  Highlight
  Future<SuccessModel> removeHighlightApiCall({required String verseKey}) async {
    // {{base_url}}/api/users/bookmark/:verse_key
    var jsonData = await apiManager.getAPICall(URLConstanst.REMOVE_Highlight + verseKey);
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

/*  /// get bibile all data
  Future<BibleModel> getBibleDataApiCall() async {
    var jsonData = await apiManager.getAPICall(
        // URLConstanst.GET_BIBLE,
        "${URLConstanst.FILTER_BIBLE}language=english");

    var response = BibleModel.fromJson(jsonData);
    return response;
  }*/


/*  /// get bible book type according book name
  Future<BibleModel> getBookTypeDataApiCall({required String language, required String testament}) async {
    var jsonData = await apiManager.getAPICall(
      "${URLConstanst.FILTER_BIBLE}language=$language&testament=$testament",
    );

    var response = BibleModel.fromJson(jsonData);
    return response;
  }*/

/*  /// filter bible data
  Future<GetVerseModel> filterBibleDataApiCall({required String url}) async {
    // http://10.0.0.72:6001/api/users/filter-bible?language=english&book_name=Genesis&chapter=2&verse=12
    var jsonData = await apiManager.getAPICall(
      URLConstanst.FILTER_BIBLE + url,
    );

    var response = GetVerseModel.fromJson(jsonData);
    return response;
  }*/

/*  /// search bible verse data
  Future<SearchVerseModel> searchApiCall(
      {required String language, required String searchText, int? perPage = 10, int? page = 1, required String book}) async {
    // http://10.0.0.72:6001/api/users/search-verse?language=english&search=god&perPage=10&page=1&book=GEN,EXO,MATs
    var jsonData = await apiManager.getAPICall(
      "${URLConstanst.SEARCH_VERSE}language=$language&search=$searchText&perPage=$perPage&page=$page&book=$book",
    );
    var response = SearchVerseModel.fromJson(jsonData);
    return response;
  }*/

  // /// add notes on verse & comment
  // Future<AddNoteModel> addNoteApiCall(Map<String, dynamic> params) async {
  //   var jsonData = await apiManager.postAPICall(
  //     URLConstanst.ADD_NOTE,
  //     params,
  //   );
  //   var response = AddNoteModel.fromJson(jsonData);
  //   return response;
  // }

/*  /// Get verse comment data

  Future<VerseCommentModel> verseCommnetApiCall(
      {required String key}) async {
    // {{base_url}}/api/users/get-note/:key
    var jsonData = await apiManager.getAPICall(
      "${URLConstanst.VERSE_COMMENT}$key",
    );
    var response = VerseCommentModel.fromJson(jsonData);
    return response;
  }*/
}
