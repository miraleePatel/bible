// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:bible_app/Api/api_manager.dart';

/// URL
///
class URLConstanst {
  // static String OTPSENDWITHREGISTER = APIManager.baseUrl + "api/users/send-otp-mail";
  static String SIGNUP = APIManager.baseUrl + "api/users/register";
  static String SIGNIN = APIManager.baseUrl + "api/users//log-in";
  static String socialSIGNIN = APIManager.baseUrl + "api/users/social-log-in";
  static String FORGOTPASSWORD = APIManager.baseUrl + "api/users/send-mail";
  static String LOGOUT = APIManager.baseUrl + "api/users/log-out";
  static String EDIT_PROFILE = APIManager.baseUrl + "api/users/edit-user-detail";
  static String GET_BIBLE = APIManager.baseUrl + "api/users/get-bible/";
  static String FILTER_BIBLE = APIManager.baseUrl + "api/users/filter-bible?";
  static String SEARCH_VERSE = APIManager.baseUrl + "api/users/search-verse?";
  static String ADD_NOTE = APIManager.baseUrl + "api/users/add-note";
  static String GET_USER_ALL_NOTE = APIManager.baseUrl + "api/users/get-user-all-note?";
  static String DELETE_NOTE = APIManager.baseUrl + "api/users/delete-note/";
  static String EDIT_NOTE = APIManager.baseUrl + "api/users/edit-note/";
  static String GET_ALL_USER = APIManager.baseUrl + "api/users/get-all-user?";
  static String GET_FACEBOOK_FRIEND = APIManager.baseUrl + "api/users/get-facebook-friend?";
  static String GET_FRIEND = APIManager.baseUrl + "api/users/get-friend?";
  static String GET_PUBLIC_NOTE = APIManager.baseUrl + "api/users/get-friend-notes?";
  static String GET_REQUEST = APIManager.baseUrl + "api/users/get-request";
  static String SEND_REQUEST = APIManager.baseUrl + "api/users/send-request";
  static String CANCEL_REQUEST = APIManager.baseUrl + "api/users/cancel-request";
  static String REMOVE_FRIEND = APIManager.baseUrl + "api/users/remove-friend";
  static String ADD_FRIEND = APIManager.baseUrl + "api/users/add-friend";
  static String LIKE_FRIEND_NOTE = APIManager.baseUrl + "api/users/note-like/";
  static String VERSE_COMMENT = APIManager.baseUrl + "api/users/get-note/";
  static String ADD_NOTE_COMMENT = APIManager.baseUrl + "api/users/add-comment";
  static String GET_NOTE_COMMENT = APIManager.baseUrl + "api/users/get-comment/";
  static String ADD_HIGHLIGHT = APIManager.baseUrl + "api/users/highlight";
  static String EDIT_HIGHLIGHT = APIManager.baseUrl + "api/users/edit-highlight";
  static String GET_HIGHLIGHT = APIManager.baseUrl + "api/users/get-highlight/";
  static String ADD_BOOKMARK = APIManager.baseUrl + "api/users/bookmark/";
  static String GET_BOOKMARK = APIManager.baseUrl + "api/users/get-bookmark/";
  static String REMOVE_BOOKMARK = APIManager.baseUrl + "api/users/remove-bookmark/";
  static String REMOVE_Highlight = APIManager.baseUrl + "api/users/remove-highlight/";
}
