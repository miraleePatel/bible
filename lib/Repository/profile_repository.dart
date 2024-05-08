import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Api/dio_api_manager.dart';
import 'package:bible_app/Api/url_constant.dart';
import 'package:bible_app/Models/signUp_model.dart';

class ProfileRepository {
  final APIManager apiManager;
  final DioAPIManager dioAPIManager;

  ProfileRepository(this.apiManager, this.dioAPIManager);
  Future<LoginSuccessModel> editProfileApiCall(
      {dynamic sendData}) async {
    var jsonData =
    await dioAPIManager.dioPatchAPICall(URLConstanst.EDIT_PROFILE, sendData);

    var response = LoginSuccessModel.fromJson(jsonData);
    return response;
  }
}
