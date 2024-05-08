import 'dart:convert';
import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Models/error_model.dart';
import 'package:bible_app/Models/signUp_model.dart';
import 'package:bible_app/Utils/constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart' as d;
import 'package:get_storage/get_storage.dart';
import '../Utils/string_constant.dart';
import 'api_exception.dart';

var imageUploadUrl;

class DioAPIManager {
  Future<dynamic> dioPostAPICall(String url, Map<String, dynamic> param) async {
    var responseJson;

    try {
      showProgressIndicator();
      var data = d.FormData.fromMap(param);
      var headers = {
        'content-Type': 'application/json',
        "Authorization": "Bearer ${LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!}"
      };

      d.Dio dio = d.Dio();

      d.Response response = await dio.post(
        APIManager.baseUrl + url,
        data: data,
        options: d.Options(headers: headers),
      );
      print("response$response");

      responseJson = _response(response);
    } on SocketException {
      // Get.showSnackbar(CustomWidgets().errorSnackBar(title: 'Error!', message: 'No internet connection'));
      // throw FetchDataException('No internet connection');
    } on TimeoutException catch (_) {
      throw FetchDataException('Server Error');
    } on d.DioError catch (e) {
      print("dio error :::::: $e");
      // Get.showSnackbar(CustomWidgets().errorSnackBar(title: 'Error!', message: 'No internet connection'));
      // throw FetchDataException('No internet connection');
    } finally {
      /// Hide progress loader
      EasyLoading.dismiss();
    }
    return responseJson;
  }

  Future<dynamic> dioPatchAPICall(
      String url, dynamic sendData) async {
    var responseJson;

    try {
      showProgressIndicator();

      // var data = d.FormData.fromMap(param);
      var headers = {
        "contentType": 'multipart/form-data',
        "Authorization": "Bearer ${LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!}"
      };

      d.Dio dio = d.Dio();
      print(url);
      print(sendData);
      // print(param);
      print(headers);

      d.Response response = await dio.patch(
        url,
        data: sendData,
        options: d.Options(headers: headers),
      );
      print(response);
      responseJson = _response(response);
    } on SocketException {
      // Get.showSnackbar(CustomWidgets().errorSnackBar(title: 'Error!', message: 'No internet connection'));
      // throw FetchDataException('No internet connection');
    } on TimeoutException catch (_) {
      throw FetchDataException('Server Error');
    } on d.DioError catch (e) {
      print(e.response);
      // Get.showSnackbar(CustomWidgets().errorSnackBar(title: 'Error!', message: 'No internet connection'));
      // throw FetchDataException('No internet connection');
    } finally {
      /// Hide progress loader
      EasyLoading.dismiss();
    }
    return responseJson;
  }

  /// Check response status and handle exception
  static _response(d.Response response) {
    // print(response.data);
    switch (response.statusCode) {
    /// Successfully get api response
      case 200:
        if (response.data['status'] == 0) {
          throw BadRequestException(ErrorModel.fromJson(response.data).message);
        } else {
          var responseJson = response.data;
          return responseJson;
        }

    /// Successfully get api response
      case 201:
        if (response.data['status'] == 0) {
          throw BadRequestException(ErrorModel.fromJson(response.data).message);
        } else {
          var responseJson = response.data;
          return responseJson;
        }

    /// Bad request need to check url
      case 400:
        throw BadRequestException(
            ErrorModel.fromJson(json.decode(response.data.toString())).message);

    /// Bad request need to check url
      case 401:
        throw BadRequestException(
            ErrorModel.fromJson(json.decode(response.data.toString())).message);

    /// Authorisation token invalid
      case 403:
        throw UnauthorisedException(
            ErrorModel.fromJson(json.decode(response.data.toString())).message);

    /// Authorisation token invalid
      case 417:
        throw UnauthorisedException(
            ErrorModel.fromJson(json.decode(response.data.toString())).message);

    /// Error occured while Communication with Server
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

// /// Check response status and handle exception
// static _response(d.Response response) {
//   print("${response.statusCode}");
//   print(response.data);
//   switch (response.statusCode) {
//
//     /// Successfully get api response
//     case 200:
//       if (ErrorModel.fromJson(json.decode(response.data)).message != 'OK') {
//         errorSnackBar(
//           message: ErrorModel.fromJson(json.decode(response.data)).message,
//         );
//         throw BadRequestException(ErrorModel.fromJson(
//           json.decode(
//             response.data.toString(),
//           ),
//         ).message);
//       } else {
//         var responseJson = json.decode(
//           response.data.toString(),
//         );
//         return responseJson;
//       }
//
//     /// Bad request need to check url
//     case 400:
//       throw BadRequestException(ErrorModel.fromJson(
//         json.decode(
//           response.data.toString(),
//         ),
//       ).message);
//
//     /// Authorisation token invalid
//     case 403:
//       throw UnauthorisedException(ErrorModel.fromJson(
//         json.decode(
//           response.data.toString(),
//         ),
//       ).message);
//
//     /// Error occured while Communication with Server
//     case 500:
//       throw UnauthorisedException(ErrorModel.fromJson(
//         json.decode(
//           response.data.toString(),
//         ),
//       ).message);
//
//     default:
//       throw FetchDataException(
//           'An error occurred occured while Communication with Server with StatusCode: ${response.statusCode}');
//   }
// }
}
