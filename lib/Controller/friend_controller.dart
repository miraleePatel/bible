import 'package:bible_app/Models/success_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Api/api_manager.dart';
import '../Models/add_note_comment_model.dart';
import '../Models/friend_request_model.dart';
import '../Models/get_all_user_model.dart';
import '../Models/get_note_comment_model.dart';
import '../Models/get_public_notes_model.dart';
import '../Repository/friend_repository.dart';
import '../Utils/constants.dart';

class FriendController extends GetxController {

  FriendRepository friendRepository = FriendRepository(APIManager());
  TextEditingController addFrdSearchController = TextEditingController();
  TextEditingController addFBFrdSearchController = TextEditingController();
  TextEditingController myFrdSearchController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  RxList<UserData> getUserList = <UserData>[].obs;
  RxList<UserData> getFBFriendList = <UserData>[].obs;
  RxList<UserData> getFriendList = <UserData>[].obs;
  RxList<RequestData> getRequestList = <RequestData>[].obs;
  RxList<PublicData> publicDataList = <PublicData>[].obs;
  RxList<GetCommentData> commentDataList = <GetCommentData>[].obs;
  int pageIndexUserData = 0;
  int pageIndexFbFrd = 0;
  int pageIndexFbData = 0;
  int pageIndexPublicData = 0;
  int pageIndexComment =0;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }



  getUserData({required String search, bool isLazyLoad = false,bool isLoaderShow = true}) async {
    if(isLazyLoad == true){
    pageIndexUserData = pageIndexUserData + 1;
    if (getUserList.isEmpty ||
        (getUserList.length >= 10 &&
            getUserList.length % 10 == 0 )) {
      GetAllUserModel getAllUserModel = await friendRepository
          .getAllUserApiCall(page: pageIndexUserData, search: search,isLoaderShow: isLoaderShow);
      if (getAllUserModel.status == 1) {
        getUserList.addAll(getAllUserModel.data!);
        print("lengh");
        print(getUserList.length);
      }
    }}else{
      getUserList.clear();
      GetAllUserModel getAllUserModel = await friendRepository
          .getAllUserApiCall(page: 1, search: search,isLoaderShow: isLoaderShow);
      if (getAllUserModel.status == 1) {
        getUserList.addAll(getAllUserModel.data!);
        print("lengh");
        print(getUserList.length);
      }
    }
  }

  getFBFriendData({required String search, bool isLazyLoad = false,bool isLoaderShow = true}) async {
    if(isLazyLoad == true){
    pageIndexFbFrd = pageIndexFbFrd + 1;
    if (getFBFriendList.isEmpty ||
        (getFBFriendList.length >= 10 &&
            getFBFriendList.length % 10 == 0 )) {
      GetAllUserModel getAllUserModel = await friendRepository
          .getFacebookFriendApiCall(page: pageIndexFbFrd, search: search,isLoaderShow: isLoaderShow);
      if (getAllUserModel.status == 1) {
        getFBFriendList.addAll(getAllUserModel.data!);
      }
    }}else{
      getFBFriendList.clear();
      GetAllUserModel getAllUserModel = await friendRepository
          .getFacebookFriendApiCall(page: 1, search: search,isLoaderShow: isLoaderShow);
      if (getAllUserModel.status == 1) {
        getFBFriendList.addAll(getAllUserModel.data!);
      }
    }
  }

  getFriendData({required String search,bool isLazyLoad = false,bool isLoaderShow = true}) async {
    if(isLazyLoad == true){
    pageIndexFbData = pageIndexFbData + 1;
    if (getFriendList.isEmpty ||
        (getFriendList.length >= 10 &&
            getFriendList.length % 10 == 0 )) {
      GetAllUserModel getAllUserModel = await friendRepository
          .getFriendApiCall(page: pageIndexFbData, search: search,isLoaderShow: isLoaderShow);
      if (getAllUserModel.status == 1) {
        getFriendList.addAll(getAllUserModel.data!);
      }
    }}else{
      getFriendList.clear();
      GetAllUserModel getAllUserModel = await friendRepository
          .getFriendApiCall(page: 1, search: search,isLoaderShow: isLoaderShow);
      if (getAllUserModel.status == 1) {
        getFriendList.addAll(getAllUserModel.data!);
      }
    }
  }

  /// sendRequest
  sendRequest({required String friendId}) async {
    SuccessModel successModel =
        await friendRepository.sendRequestApiCall({"friend_id": friendId});

    if (successModel.status == 1) {
      successSnackBar(message: successModel.message);
      getUserData( search: "");
    } else {
      errorSnackBar(message: successModel.message);
    }

  }

  /// cancelRequest
  cancelRequest({required String friendId}) async {
    SuccessModel successModel =
        await friendRepository.cancelRequestApiCall({"friend_id": friendId});
    if (successModel.status == 1) {
      successSnackBar(message: successModel.message);
    } else {
      errorSnackBar(message: successModel.message);
    }
    getUserData( search: "");
  }

  /// removeFriend
  removeFriend({required String friendId}) async {
    SuccessModel successModel =
        await friendRepository.removeFriendApiCall({"friend_id": friendId});
    if (successModel.status == 1) {
      successSnackBar(message: successModel.message);
    } else {
      errorSnackBar(message: successModel.message);
    }
    getFriendData( search: "");
  }

  /// get friend Reuest
  getFriendRequest() async {
    getRequestList.clear();
    FriendRequestModel friendRequestModel =
        await friendRepository.getFriendRequestApiCall();
    if (friendRequestModel.status == 1) {
      getRequestList.addAll(friendRequestModel.data!);
      // successSnackBar(message: friendRequestModel.message);
    }
  }

  ///  Add Friend
  addFriend({required String friendId}) async {
    SuccessModel successModel =
        await friendRepository.addFriendApiCall({"friend_id": friendId});
    if (successModel.status == 1) {
      successSnackBar(message: successModel.message);
    } else {
      errorSnackBar(message: successModel.message);
    }
    getFriendRequest();
  }

  /// Delete Request
  deleteRequest({required String friendId}) async {
    SuccessModel successModel =
        await friendRepository.cancelRequestApiCall({"friend_id": friendId});
    if (successModel.status == 1) {
      successSnackBar(message: successModel.message);
    } else {
      errorSnackBar(message: successModel.message);
    }
    getFriendRequest();
  }

  getPublicData({bool lazyLoad = false}) async {
    if (lazyLoad == true) {
    pageIndexPublicData = pageIndexPublicData + 1;
    if (publicDataList.isEmpty ||
        (publicDataList.length >= 10 &&
            publicDataList.length % 10 == 0 )) {
      GetPublicNoteModel getPublicNoteModel = await friendRepository
          .getPublicNoteApiCall(page: pageIndexPublicData);
      if (getPublicNoteModel.status == 1) {
        publicDataList.addAll(getPublicNoteModel.data!);

      }
    }}else {
      publicDataList.clear();

      GetPublicNoteModel getPublicNoteModel = await friendRepository
          .getPublicNoteApiCall(page: 1);
      if (getPublicNoteModel.status == 1) {
        publicDataList.addAll(getPublicNoteModel.data!);
             }
    }
  }


  /// likeFrdNote
  likeFrdNote({required String noteId,required int index}) async {
    SuccessModel successModel =
        await friendRepository.likeFrdNoteApiCall(noteId: noteId);
    if (successModel.status == 1) {
      successSnackBar(message: successModel.message);
      getPublicData();
         }else  if (successModel.status == 2) {
      getPublicData();
      successSnackBar(message: successModel.message);
    } else {
      errorSnackBar(message: successModel.message);
    }
  }

  /// getNoteCommentData
  getNoteCommentData({bool lazyLoad = false, required String noteId}) async {
    pageIndexComment = pageIndexComment + 1;
    if (commentDataList.isEmpty ||
        (commentDataList.length >= 10 &&
            commentDataList.length % 10 == 0)) {
      GetNoteCommentModel getNoteCommentModel = await friendRepository
          .getNoteCommentApiCall(page: pageIndexComment, noteId: noteId);
      if (getNoteCommentModel.status == 1) {
        commentDataList.addAll(getNoteCommentModel.data!.reversed);
      }
    }
  }


  /// likeFrdNote
  addComment({required String noteId}) async {
    AddNoteCommentModel addNoteCommentModel = await friendRepository.addNotecommentApiCall({"note_id" : noteId,
      "comment": commentController.text});
    if (addNoteCommentModel.status == 1) {
      successSnackBar(message: addNoteCommentModel.message);
      commentController.clear();
      commentDataList.clear();
      pageIndexComment = 0;
      getNoteCommentData(noteId: noteId);
    } else {
      errorSnackBar(message: addNoteCommentModel.message);
    }


  }

  String formatTimeDifference(String timestamp) {
    final currentTime = DateTime.now();
    final parsedTimestamp = DateTime.parse(timestamp);

    final difference = currentTime.difference(parsedTimestamp);

    if (difference.inMinutes < 1) {
      return 'just now';
    }else  if (difference.inSeconds < 60) {
      final seconds = difference.inSeconds;
      return '$seconds second${seconds > 1 ? 's' : ''} ago';
    }else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''}';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''}';
    } else {
      final days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''}';
    }
  }






}
