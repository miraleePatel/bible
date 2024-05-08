import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Api/url_constant.dart';
import '../Models/add_note_comment_model.dart';
import '../Models/friend_request_model.dart';
import '../Models/get_all_user_model.dart';
import '../Models/get_note_comment_model.dart';
import '../Models/get_public_notes_model.dart';
import '../Models/success_model.dart';

class FriendRepository {
  final APIManager apiManager;
  // final DioAPIManager dioAPIManager;

  FriendRepository(this.apiManager);

  /// get all user api call
  Future<GetAllUserModel> getAllUserApiCall({int? perPage = 10, int? page = 1, String? search,bool isLoaderShow = true}) async {
    // {{base_url}}/api/users/get-all-user?perPage=10&page=1&search=
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_ALL_USER}perPage=$perPage&page=$page&search=$search",isLoaderShow:isLoaderShow );

    var response = GetAllUserModel.fromJson(jsonData);
    return response;
  }

  /// get all user api call
  Future<GetAllUserModel> getFacebookFriendApiCall({int? perPage = 10, int? page = 1, String? search,bool isLoaderShow = true}) async {
    // {{base_url}}/api/users/get-all-user?perPage=10&page=1&search=
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_FACEBOOK_FRIEND}perPage=$perPage&page=$page&search=$search",isLoaderShow:isLoaderShow );

    var response = GetAllUserModel.fromJson(jsonData);
    return response;
  }

  /// get friend list
  Future<GetAllUserModel> getFriendApiCall({int? perPage = 10, int? page = 1, String? search,bool isLoaderShow = true}) async {
    // {{base_url}}/api/users/get-friend?perPage=10&page=1&search
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_FRIEND}perPage=$perPage&page=$page&search=$search",isLoaderShow:isLoaderShow );

    var response = GetAllUserModel.fromJson(jsonData);
    return response;
  }

  ///send Request Api Call
  Future<SuccessModel> sendRequestApiCall(Map<String, dynamic> params) async {
    // {{base_url}}/api/users/send-request
    var jsonData = await apiManager.postAPICall(URLConstanst.SEND_REQUEST, params);

    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

  ///send Request Api Call
  Future<SuccessModel> cancelRequestApiCall(Map<String, dynamic> params) async {
    // {{base_url}}/api/users/cancel-request
    var jsonData = await apiManager.postAPICall(URLConstanst.CANCEL_REQUEST, params);

    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

  ///send Request Api Call
  Future<SuccessModel> removeFriendApiCall(Map<String, dynamic> params) async {
    // {{base_url}}/api/users/remove-friend
    var jsonData = await apiManager.postAPICall(URLConstanst.REMOVE_FRIEND, params);

    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

  /// get friend Request
  Future<FriendRequestModel> getFriendRequestApiCall() async {
    // {{base_url}}/api/users/get-request
    var jsonData = await apiManager.getAPICall(URLConstanst.GET_REQUEST);

    var response = FriendRequestModel.fromJson(jsonData);
    return response;
  }

  ///add friend Api Call
  Future<SuccessModel> addFriendApiCall(Map<String, dynamic> params) async {
    // {{base_url}}/api/users/add-friend
    var jsonData = await apiManager.postAPICall(URLConstanst.ADD_FRIEND, params);

    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

  /// Get Public Note
  Future<GetPublicNoteModel> getPublicNoteApiCall({
    int? perPage = 10,
    int? page = 1,
  }) async {
    // {{base_url}}/api/users/get-friend-notes?perPage=10&page=1
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_PUBLIC_NOTE}perPage=$perPage&page=$page");

    var response = GetPublicNoteModel.fromJson(jsonData);
    return response;
  }

  /// likeFrdNote
  Future<SuccessModel> likeFrdNoteApiCall({required String noteId}) async {
    // {{base_url}}/api/users/note-like/:note_id
    var jsonData = await apiManager.getAPICall("${URLConstanst.LIKE_FRIEND_NOTE}$noteId");
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

  /// AddNoteCommentModel
  Future<AddNoteCommentModel> addNotecommentApiCall(Map<String, dynamic> params) async {
    // {{base_url}}/api/users/add-comment
    var jsonData = await apiManager.postAPICall(URLConstanst.ADD_NOTE_COMMENT, params);

    var response = AddNoteCommentModel.fromJson(jsonData);
    return response;
  }

  /// Get Public Note
  Future<GetNoteCommentModel> getNoteCommentApiCall({
    int? perPage = 10,
    int? page = 1,
    required String noteId
  }) async {
    // {{base_url}}/api/users/get-comment/:id?perPage=10&page=1
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_NOTE_COMMENT}$noteId?perPage=$perPage&page=$page");

    var response = GetNoteCommentModel.fromJson(jsonData);
    return response;
  }

}
