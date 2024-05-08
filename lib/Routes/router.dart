// ignore_for_file: constant_identifier_Names, prefer_const_constructors

import 'package:bible_app/Screens/Authentication/forgotpassword_screen.dart';
import 'package:bible_app/Screens/Authentication/local_alert_screen.dart';
import 'package:bible_app/Screens/Authentication/login_screen.dart';
import 'package:bible_app/Screens/Authentication/signup_screen.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Comment/show_all_comment.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Comment/show_all_notes.dart';
import 'package:bible_app/Screens/Dashboard/Bible/play_video_screen.dart';
import 'package:bible_app/Screens/Dashboard/Bible/Index/verse_index_screen.dart';
import 'package:bible_app/Screens/Dashboard/Friends/add_facebook_friend_screen.dart';
import 'package:bible_app/Screens/Dashboard/Friends/friend_request_screen.dart';
import 'package:bible_app/Screens/Dashboard/Friends/note_comment_screen.dart';
import 'package:bible_app/Screens/Dashboard/Setting/edit_profile_screen.dart';
import 'package:bible_app/Screens/Dashboard/Setting/notification_screen.dart';
import 'package:bible_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import '../Screens/Dashboard/Bible/ShareImage/share_image_screen.dart';
import '../Screens/Dashboard/Menu/Search/search_screen.dart';
import '../Screens/Dashboard/Friends/add_friends_screen.dart';
import '../Screens/Dashboard/Friends/my_friends_screen.dart';
import '../Screens/Dashboard/Menu/Bookmarks/boomark_screen.dart';
import '../Screens/Dashboard/Menu/Highlights/highlight_screen.dart';
import '../Screens/Dashboard/Menu/Language/language_screen.dart';
import '../Screens/Dashboard/Menu/MyAudio/my_audio_screen.dart';
import '../Screens/Dashboard/Menu/MyPhotos/my_photos_screen.dart';
import '../Screens/Dashboard/Menu/MyVideos/my_video_screen.dart';
import '../Screens/Dashboard/Menu/Notes/add_note_screen.dart';
import '../Screens/Dashboard/Menu/Notes/note_list_screen.dart';
import '../Screens/Dashboard/Menu/Reading_Progress/reading_progress_screen.dart';
import '../Screens/Dashboard/Setting/setting_screen.dart';
import '../Screens/Dashboard/Menu/Topic/topic_detail_screen.dart';
import '../Screens/Dashboard/Menu/Topic/topic_screen.dart';
import '../Screens/Dashboard/Menu/Verse_Day/verse_day_screen.dart';
import '../Screens/Dashboard/Setting/theme_screen.dart';
import '../Screens/Onboarding/onboading_screen.dart';
import '../Screens/Onboarding/splash_screen.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL_ROUTE = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.ONBOADING_SCREEN,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.SIGNUP_SCREEN,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: Routes.FORGOTPASSWORD_SCREEN,
      page: () => const ForgotPasswordScreen(),
    ), GetPage(
      name: Routes.LOCAL_ALERT_SCREEN,
      page: () => const LocalAlertScreen(),
    ),
    GetPage(
      name: Routes.DASHBOARD_SCREEN,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: Routes.NOTES_SCREEN,
      page: () => const NoteListScreen(),
    ),
    GetPage(
      name: Routes.ADD_NOTE_SCREEN,
      page: () => const AddNotesScreen(),
    ),
    GetPage(
      name: Routes.HIGHLIGHT_SCREEN,
      page: () => const HighlightScreen(),
    ),
    GetPage(
      name: Routes.BOOKMARK_SCREEN,
      page: () => const BookmarkScreen(),
    ),
    GetPage(
      name: Routes.VERSE_DAY_SCREEN,
      page: () => const VerseDayScreen(),
    ),
    GetPage(
      name: Routes.LANGUAGE_SCREEN,
      page: () => const LanguageScreen(),
    ),
    GetPage(
      name: Routes.TOPIC_SCREEN,
      page: () => const TopicScreen(),
    ),
    GetPage(
      name: Routes.TOPIC_DETAIL_SCREEN,
      page: () => const TopicDetailScreen(),
    ),
    GetPage(
      name: Routes.MY_PHOTOS_SCREEN,
      page: () => const MyPhotosScreen(),
    ),
    GetPage(
      name: Routes.MY_VIDEO_SCREEN,
      page: () => const MyVideoScreen(),
    ),
    GetPage(
      name: Routes.MY_AUDIO_SCREEN,
      page: () => const MyAudioScreen(),
    ),
    GetPage(
      name: Routes.SETTING_SCREEN,
      page: () => const SettingScreen(),
    ),
    GetPage(
      name: Routes.PLAY_VIDEO_SCREEN,
      page: () => const PlayVideoScreen(),
    ),
    GetPage(
      name: Routes.VERSE_INDEX_SCREEN,
      page: () =>  VerseIndexScreen(),
    ),
    GetPage(
      name: Routes.SHARE_IMAGE_SCREEN,
      page: () => ShareImageScreen(),
    ),
    GetPage(
      name: Routes.NOTE_COMMENT_SCREEN,
      page: () => NoteCommentScreen(),
    ),
    GetPage(
      name: Routes.ADD_FRIENDS_SCREEN,
      page: () => AddFriendsScreen(),
    ),
    GetPage(
      name: Routes.MY_FRIENDS_SCREEN,
      page: () => MyFriendsScreen(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE_SCREEN,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: Routes.NOTIFICATION_SCREEN,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: Routes.THEME_SCREEN,
      page: () => ThemeScreen(),
    ),
    GetPage(
      name: Routes.SEARCH_SCREEN,
      page: () => SearchScreen(),
    ),
    GetPage(
      name: Routes.READING_PROGRESS_SCREEN,
      page: () => ReadingProgressScreen(),
    ),
    GetPage(
      name: Routes.SHOW_ALL_COMMENT,
      page: () => ShowAllComment(),
    ),
    GetPage(
      name: Routes.FRIEND_REQUEST_SCREEN,
      page: () => FriendRequestScreen(),
    ), GetPage(
      name: Routes.ADD_FACEBOOK_FRIEND_SCREEN,
      page: () => AddFacebookFriendsScreen(),
    ),
   /*  GetPage(
      name: Routes.SHOW_ALL_NOTES,
      page: () => ShowAllNotes(),
    ), */
  ];
}
