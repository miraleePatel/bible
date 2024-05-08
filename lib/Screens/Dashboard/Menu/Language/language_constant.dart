import 'package:flutter/material.dart';

const selectedLanuage = 'selected_language';

class LanguageConstant {
  // list of locales for user appereance
  static const locales = [
    {'langName': 'English', 'langText': 'English', 'locale': Locale('en', 'US'),},
    {'langName': 'French', 'langText': 'française', 'locale': Locale('fr', 'FR'),},
  
  ];

  // string that changes on language toggle

  static const String login = 'Login';
  static const String email = 'Email Address';
  static const String password = 'Password';
  static const String dob = 'Date of birth';
  static const String address = 'Address';
  static const String confirmPassWordHint = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password';
  static const String register = 'Register';
  static const String dontHave = "Don't have an account?";
  static const String signUp = "Sign Up";
  static const String userName = "Username";
  static const String createAccount = "Create account";
  static const String alreadyHave = "Already have an account?";
  static const String reqEmail = "Please enter email address";
  static const String validEmail = "Please enter valid email";
  static const String validPass = "Please enter password";
  static const String confirmPass = "Confirm password must be same as password";
  static const String validUsername = "Please enter username";
  static const String backSignIn = "Back to Sign in";
  static const String send = "Send";
  static const String welcome = "Welcome";
  static const String home = "Home";
  static const String bible = "Bible";
  static const String myHighlight = "My Highlights";
  static const String myBookmarks = "My Bookmarks";
  static const String myNotes = "My Notes";
  static const String myVideo = "My Videos";
  static const String myPhoto = "My Photos";
  static const String myFriend = "My Friends";
  static const String myAudio = "My Audio";
  static const String setting = "Setting";
  static const String verseOfDay = "Verse of the Day";
  static const String aboutUs = "About Us";
  static const String topic = "Topic";
  static const String language = "Language";
  static const String version = "Version";
  static const String removeAds = "Remove Ads";
  static const String share = "Share";
  static const String uploadImage = "Upload Image";
  static const String shareApp = "Share App";
  static const String highlights = "Highlights";
  static const String verseDay = "Verse of the Day";
  static const String showAll = "Show All";
  static const String bookmark = "Bookmarks";
  static const String notes = "Notes";
  static const String myVoice = "My voice";
  static const String publish = "Publish";
  static const String edit = "Edit";
  static const String addVerse = "Add Verse";
  static const String whatWould = "What would you like to say?";
  static const String topicalBible = "Topical Bible Verses";
  static const String account = "Account";
  static const String editProfile = "Edit Profile";
  static const String notificationSetting = "Notification setting";
  static const String general = "General";
  static const String dynamicFeature = "Dynamic feature";
  static const String downloadImage = "Download Image";
  static const String autoDetect = "Auto Detect";
  static const String lowLight = "Low Light";
  static const String off = "Off";
  static const String bibleReading = "Bible Reading";
  static const String font = "Font";
  static const String showFootnotes = "Show Footnotes";
  static const String whenAvailable = "When Available";
  static const String redLetters = "Red Letters";
  static const String showVersePicker = "Show Verse Picker";
  static const String audioTrackingBar = "Show Audio Tracking Bar";
  static const String clearSearch = "Clear Search History";
  static const String manageFont = "Manage Offline Fonts";
  static const String manageVersion = "Manage Offline Versions";
  static const String plans = "Plans";
  static const String completeDialogue = "Day Complete Dialogue";
  static const String more = "More";
  static const String clearLocalCache = "Clear Local Cache";
  static const String extraLogging = "Extra Logging";
  static const String captureVideo = "Capture Video";
  static const String capturePhoto = "Capture Photo";
  static const String recordVoice = "Record Voice";
  static const String play = "PLAY";
  static const String pause = "Pause";
  static const String save = "Save";
  static const String set = "Set";
  static const String books = "Books";
  static const String chapter = "Chapter";
  static const String verse = "Verse";
  static const String volume = "Volume";
  static const String pitch = "Pitch";
  static const String speech = "Speech";
  static const String verseOnly = "Verses Only";
  static const String verseCmt = "Verses + Comment";
  static const String close = "Close";
  static const String image = "Image";
  static const String giveTitle = "Give a title...... ";
  static const String delete = "Delete";
  static const String friends = "Friends";
  static const String addFriends = "Add Friends";
  static const String verseImageCreated = "Verse image created ...";
  static const String comment = "Comment";
  static const String commentType = "Type your comments here...";
  static const String seeWhich =
      "See which of your contacts \nare on the bible app!";
  static const String connectContect = "Connect Contacts";
  static const String inviteFriends = "Invite friends";
  static const String search = "Search...";
  static const String searchMenu = "Search";
  static const String addFaceFriend = "Add facebook Friends";
  static const String editUserName = "User name";
  static const String mobileNo = "Mobile Number";
  static const String editDob = "Date of Birth";
  static const String location = "Location";
  static const String editEmail = "Email";
  static const String saveProfile = "Save Profile";
  static const String notification = "Notification";
  static const String turnOn =
      "Turn on if you want to get notification on your home screen!";
  static const String system = "System";
  static const String on = "On";
  static const String all = "All";
  static const String oldTestament = "Old Testament";
  static const String newTestament = "New Testament";
  static const String showResult = "Show Result";
  static const String readingProgress = "Reading Progress";
  static const String readingCertificate = "reading certificate";
  static const String exploreYourSpiritual = "Explore Your Spiritual Journey!";
  static const String verseHightLights = "Verse Highlights & Bookmarks!";
  static const String myFriendTitle = "My Friend";
  static const String note = "Note";
  static const String google = "Google";
  static const String startYourSpiritual = "Start Your Spiritual Quest with the Bible!";
  static const String welcomeToBible = "Welcome to Bible. Start discovering and applying god’s word to your daily life.";
  static const String safeguardYourNotes = "Safeguard Your Notes & Highlights";
  static const String signUpForAFree = "Sign up for a free account to back up your notes, highlights, and purchases. You can then sync them across your devices and the web!";
  static const String signIn = "Sign In";
  static const String typeHere = "Type here...";
  static const String otnt = "OT/NT";
  static const String allBooks = "All Books";
  static const String inviteFriendsTo = "Invite Friends to join you on YouVersion";
  static const String editImage = "Edit Image";
  static const String arrange = "Arrange";
  static const String requested = "Requested";
  static const String sendRequest  = "Send Request";
  static const String notFound  ="Not Found!";
  static const String friendRequest  = "Friend Request";
  static const String accept  = "Accept";
  static const String removeFriend  = "Remove Friend";


}
