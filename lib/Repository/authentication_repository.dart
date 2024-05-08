import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Api/url_constant.dart';
import 'package:bible_app/Models/signUp_model.dart';
import 'package:bible_app/Models/success_model.dart';

import '../Api/response_api_manager.dart';

class AuthenticationRepository {
  final APIManager apiManager;
  final ResponsAPIManager responsAPIManager;

  AuthenticationRepository(this.apiManager, this.responsAPIManager);

  // *********************** Post Sign Up API call **************************
  ///
  Future<LoginSuccessModel> signUpApiCall(Map<String, dynamic> params) async {
    var jsonData = await apiManager.postAPICall(
      URLConstanst.SIGNUP,
      params,
    );

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }
  // *********************** Post Sign Up API call **************************

  // *********************** Post Sign In API call **************************
  ///
  Future<LoginSuccessModel> signInApiCall(Map<String, dynamic> params) async {
    var jsonData = await apiManager.postAPICall(
      URLConstanst.SIGNIN,
      params,
    );

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

  // *********************** Post social Sign Up API call **************************
  Future<LoginSuccessModel> socialSignUpApiCall(Map<String, dynamic> params) async {
    var jsonData = await responsAPIManager.postAPICall(
      URLConstanst.SIGNUP,
      params,
    );

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

  // *********************** Post social Sign In API call **************************
  Future<LoginSuccessModel> socialSignInApiCall(Map<String, dynamic> params) async {
    var jsonData = await apiManager.postAPICall(
      URLConstanst.socialSIGNIN,
      params,
    );

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }

  // *********************** Get Logout API call **************************
  ///
  Future<SuccessModel> logoutApiCall() async {
    var jsonData = await apiManager.getAPICall(
      URLConstanst.LOGOUT,
    );

    var response = SuccessModel.fromJson(jsonData);
    return response;
  }
// *********************** forgotPassword API call **************************

  Future<SuccessModel> forgotPasswordApi({required String email}) async {
    var jsonData = await apiManager.getAPICall("${URLConstanst.FORGOTPASSWORD}/$email");

    var response = SuccessModel.fromJson(jsonData);
    return response;
  }
}
