import 'dart:developer';

import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Models/signUp_model.dart';
import 'package:bible_app/Models/success_model.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Repository/authentication_repository.dart';
import 'package:bible_app/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Api/response_api_manager.dart';
import '../Utils/string_constant.dart';

class AuthenticationController extends GetxController {
  AuthenticationRepository authenticationRepository = AuthenticationRepository(APIManager(), ResponsAPIManager());
  TextEditingController loginUserNameCon = TextEditingController();
  TextEditingController loginPasswordCon = TextEditingController();

  TextEditingController forgotpassController = TextEditingController();
  TextEditingController signUpUsernameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signUppassController = TextEditingController();
  TextEditingController signUpConfirmPassController = TextEditingController();
  RxString fcmToken = "".obs;
  Rx<LoginSuccessModel> signUpDetails = LoginSuccessModel().obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    getFcmToken();

    super.onInit();
  }


  clearRegisterData(){
    signUpUsernameController.clear();
    signupEmailController.clear();
    signUppassController.clear();
    signUpConfirmPassController.clear();
  }
  clearLoginData(){
    loginUserNameCon.clear();
    loginPasswordCon.clear();
  }
  // ************************  Get FCM token  *******************************
  getFcmToken() async {
    var getToken = await FirebaseMessaging.instance.getToken();
    fcmToken.value = getToken!;
    if (kDebugMode) {
      print("[FCM Token] =====> $fcmToken");
    }
  }

  // ************************  Get FCM token  *******************************
  forgotPasswordApi() async {
    SuccessModel res = await authenticationRepository.forgotPasswordApi(email: forgotpassController.text);

    if (res.status == 1) {
      successSnackBar(message: res.message);
      Get.offNamed(
        Routes.LOGIN_SCREEN,
      );
    } else {
      errorSnackBar(message: res.message);
    }
  }

  // ************************  User sign up  *******************************
  signUp(BuildContext context) async {
    signUpDetails.value = await authenticationRepository.signUpApiCall({
      "userName": signUpUsernameController.text,
      "email": signupEmailController.text,
      "password": signUpConfirmPassController.text,
      "fcmToken": fcmToken.value
    });
    if (signUpDetails.value.status == 1) {
      GetStorage().write(userData, signUpDetails.toJson());

      /// success message & navigation
      successSnackBar(message: signUpDetails.value.message);
      Get.offAllNamed(Routes.DASHBOARD_SCREEN);
    } else {
      errorSnackBar(message: signUpDetails.value.message);
    }
  }
  // ************************  User sign up  *******************************

  // ************************  User sign In  *******************************
  signIn(BuildContext context) async {
    signUpDetails.value =
        await authenticationRepository.signInApiCall({"email": loginUserNameCon.text, "password": loginPasswordCon.text, "fcmToken": fcmToken.value});
    if (signUpDetails.value.status == 1) {
      GetStorage().write(userData, signUpDetails.toJson());

      /// success message & navigation
      successSnackBar(message: signUpDetails.value.message);
      Get.offAllNamed(Routes.DASHBOARD_SCREEN);
    } else {
      errorSnackBar(message: signUpDetails.value.message);
    }
  }
  // ************************  Google Signup and Signin *******************************

  signUpWithGoogle() async {
    // Show progress loader
    showProgressIndicator();

    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      userCredential = await auth.signInWithCredential(googleAuthCredential);
      User? user = userCredential.user;

      if (user != null) {
        /// social Signup
        signUpDetails.value = await authenticationRepository.socialSignUpApiCall({
          "userName": user.displayName,
          "email": user.email,
          "password": "",
          "fcmToken": fcmToken.value,
          "social_media": "google",
          // "profile_image": user.photoURL
        });
        if (signUpDetails.value.status == 1) {
          GetStorage().write(userData, signUpDetails.toJson());

          /// success message & navigation
          successSnackBar(message: signUpDetails.value.message);
          Get.offAllNamed(Routes.LOCAL_ALERT_SCREEN);
          // Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        }
        if (signUpDetails.value.status == 0) {
          // socialSignInApiCall
          /// social Signin
          signUpDetails.value = await authenticationRepository.socialSignInApiCall({
            "userName": user.displayName,
            "email": user.email,
            "social_media": "google",
            "fcmToken": fcmToken.value,
            // "profile_image": user.photoURL
          });
          if (signUpDetails.value.status == 1) {
            GetStorage().write(userData, signUpDetails.toJson());

            /// success message & navigation
            successSnackBar(message: signUpDetails.value.message);
            Get.offAllNamed(Routes.LOCAL_ALERT_SCREEN);
            // Get.offAllNamed(Routes.DASHBOARD_SCREEN);

          }

          /// success message & navigation
        }
      }
    } catch (error) {
      print(error);
    } finally {
      // Hide progress loader
      dismissProgressIndicator();
    }
  }

  // ************************  User Logout  *******************************
  logout(BuildContext context) async {
    SuccessModel successLogout = await authenticationRepository.logoutApiCall();
    if (successLogout.status == 1) {
      await GetStorage().erase();
      // if (LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.socialMedia.toString() == 'google') {
      //   await GoogleSignIn().signOut();
      //   await GoogleSignIn().disconnect();
      //  }
      auth.signOut();
      successSnackBar(message: successLogout.message);
      Get.offAllNamed(Routes.LOGIN_SCREEN);
    } else {
      errorSnackBar(message: successLogout.message);
    }
  }
// ************************  User Logout  *******************************

  signInWithFacebook() async {
    try {
      final fb = FacebookLogin();
      // Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      User? user;
      if (res != null) {
        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken!.token);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

        user = userCredential.user!;
        log(userCredential.user.toString());

        /// social Signup
        signUpDetails.value = await authenticationRepository.socialSignUpApiCall({
          "userName": user.displayName,
          "email": user.email != null ? user.email : user.displayName,
          "password": "",
          "fcmToken": fcmToken.value,
          "social_media": "facebook",
          // "profile_image": user.photoURL
        });

        if (signUpDetails.value.status == 1) {
          GetStorage().write(userData, signUpDetails.toJson());

          /// success message & navigation
          successSnackBar(message: signUpDetails.value.message);
          Get.offAllNamed(Routes.DASHBOARD_SCREEN);
        }
        if (signUpDetails.value.status == 0) {
          // socialSignInApiCall
          // GetStorage().write(userData, signUpDetails.toJson());
          /// social Signin
          signUpDetails.value = await authenticationRepository.socialSignInApiCall({
            "userName": user.displayName,
            "email": user.email != null ? user.email : user.displayName,
            "social_media": "facebook",
            "fcmToken": fcmToken.value,
            // "profile_image": user.photoURL
          });
          if (signUpDetails.value.status == 1) {
            GetStorage().write(userData, signUpDetails.toJson());

            /// success message & navigation
            successSnackBar(message: signUpDetails.value.message);
            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
          }

          /// success message & navigation
        }
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        // fetch user email
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
      }
      return user;
    } catch (e) {
      return e.toString();
    }
  }
}
