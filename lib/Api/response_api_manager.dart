// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bible_app/Models/error_model.dart';
import 'package:bible_app/Models/signUp_model.dart';
import 'package:bible_app/Utils/string_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Utils/constants.dart';
import 'api_exception.dart';

/// [ApiManager] containes the Post and get method of http with response and error handling
///
class ResponsAPIManager {
  ///  Base Url
  static String baseUrl = 'http://10.0.0.72:6001/'; // local

  /// Used to call post API method, pass the url and param for api call
  ///
  /// `APIManager().postAPICall("https://.....",{});`
  ///
  Future<dynamic> postAPICall(String url, Map param) async {
    /// print in debug mode
    if (kDebugMode) {
      print("Calling API: $url");
      print("Calling parameters: $param");
    }

    var responseJson;
    try {
      /// Show progress loader
      showProgressIndicator();

      /// Set header for send request
      var headers = GetStorage().read(userData) == null
          ? {
        "Content-Type": "application/json",
      }
          : {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!
      };

      /// call post api for given url and parameters
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(param))
          .timeout(
        const Duration(seconds: 15),
      )
          .onError(
            (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );

      /// print response body of api
      if (kDebugMode) {
        // ignore: prefer_interpolation_to_compose_strings
        print("\n\n\n----------------------------------------------------------------------------------- \n POST METHOD RESPONSE --> " +
            response.body +
            '\n-----------------------------------------------------------------------------------\n\n\n');
      }

      /// Check api response and handle exception
      responseJson = _response(response);
    } on SocketException {
      /// Show error message on SocketException
      errorSnackBar(message: 'No Internet Connection');

      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      /// Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      /// dismiss progress loader
      dismissProgressIndicator();
    }
    return responseJson;
  }

  /// Used to call get API method, pass the url for api call
  ///
  /// `APIManager().getAPICall("https://.....");`
  Future<dynamic> getAPICall(String url, {bool isLoaderShow = true}) async {
    /// print in debug mode
    if (kDebugMode) {
      print("Calling API: $url");
    }

    var responseJson;
    try {
      /// Show progress loader
      ///
      if (isLoaderShow) {
        showProgressIndicator();
      }

      /// Set header for send request
      var headers = GetStorage().read(userData) == null
          ? {
        "Content-Type": "application/json",
      }
          : {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!
      };

      /// call post api for given url and parameters
      final response = await http
          .get(
        Uri.parse(url),
        headers: headers,
      )
          .timeout(
        const Duration(seconds: 15),
      )
          .onError(
            (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );

      /// print response body of api
      if (kDebugMode) {
        // ignore: prefer_interpolation_to_compose_strings
        print("\n-----------------------------------------------------------------------------------\n");
        print(response.request);
        log("GET METHOD RESPONSE --> " +
            response.body +
            "\n-----------------------------------------------------------------------------------\n\n\n");
      }

      /// Check api response and handle exception
      responseJson = _response(response);
    } on SocketException {
      /// Show error message on SocketException
      Get.showSnackbar(errorSnackBar(message: 'No Internet Connection'));
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      /// Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      /// Hide progress loader
      if (isLoaderShow) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  /// Used to call post API method, pass the url and param for api call
  ///
  /// `APIManager().postAPICall("https://.....",{});`
  Future<dynamic> patchAPICall(String url , Map param) async {
    /// print in debug mode
    if (kDebugMode) {
      print("Calling API: $url");
      // print("Calling parameters: $param");
    }

    var responseJson;
    try {
      /// Show progress loader
      showProgressIndicator();

      /// Set header for send request
      var headers = GetStorage().read(userData) == null
          ? {
        "Content-Type": "application/json",
      }
          : {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!
      };

      /// call post api for given url and parameters
      final response = await http
          .patch(
        Uri.parse(url),
        headers: headers,
        body: json.encode(param),
      )
          .timeout(
        const Duration(seconds: 15),
      )
          .onError(
            (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );

      /// print response body of api
      if (kDebugMode) {
        // ignore: prefer_interpolation_to_compose_strings
        print(".\n\n\n----------------------------------------------------------------------------------- \n PUT METHOD RESPONSE " +
            response.body +
            '\n-----------------------------------------------------------------------------------\n\n\n.');
      }

      /// Check api response and handle exception
      responseJson = _response(response);
    } on SocketException {
      /// Show error message on TimeoutException

      errorSnackBar(message: 'No Internet Connection');
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      /// Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      /// Hide progress loader
      dismissProgressIndicator();
    }
    return responseJson;
  }

  /// Used to call post API method, pass the url and param for api call
  ///
  /// `APIManager().postAPICall("https://.....",{});`
  Future<dynamic> putAPICall1(String url, Map param) async {
    /// print in debug mode
    if (kDebugMode) {
      print("Calling API: $url");
      print("Calling parameters: $param");
    }

    var responseJson;
    try {
      /// Show progress loader
      showProgressIndicator();

      /// Set header for send request
      var headers = GetStorage().read(userData) == null
          ? {
        "Content-Type": "application/json",
      }
          : {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!
      };

      /// call post api for given url and parameters
      final response = await http
          .put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(param),
      )
          .timeout(
        const Duration(seconds: 15),
      )
          .onError(
            (error, stackTrace) {
          errorSnackBar(message: 'Server Down, Please try after some time!');
          throw FetchDataException('No Internet Connection');
        },
      );

      /// print response body of api
      if (kDebugMode) {
        // ignore: prefer_interpolation_to_compose_strings
        print(".\n\n\n----------------------------------------------------------------------------------- \n PUT METHOD RESPONSE " +
            response.body +
            '\n-----------------------------------------------------------------------------------\n\n\n.');
      }

      /// Check api response and handle exception
      responseJson = _response(response);
    } on SocketException {
      /// Show error message on TimeoutException

      errorSnackBar(message: 'No Internet Connection');
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      /// Throw error message on TimeoutException
      throw FetchDataException('Server Error');
    } finally {
      /// Hide progress loader
      dismissProgressIndicator();
    }
    return responseJson;
  }

  /// Used to call delete API method, pass the url and param for api call
  ///
  /// `APIManager().deleteAPICall("https://.....",{});`
  Future<dynamic> deleteAPICall(String url /*, Map param*/) async {
    if (kDebugMode) {
      print("Calling API: $url");
    }
    // print("Calling parameters: $param");

    var responseJson;
    try {
      /// Show progress loader
      showProgressIndicator();

      /// Set header for send request
      var headers = GetStorage().read(userData) == null
          ? {
        "Content-Type": "application/json",
      }
          : {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + LoginSuccessModel.fromJson(GetStorage().read(userData)).data!.token!
      };

      /// call post api for given url and parameters
      final response = await http
          .delete(
        Uri.parse(url),
        headers: headers,
        // body: json.encode(param)
      )
          .timeout(const Duration(seconds: 15));
      // .onError((error, stackTrace) =>
      //     throw FetchDataException('Something went wrong!'));

      /// Check api response and handle exception
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    } on TimeoutException catch (_) {
      throw FetchDataException('Server Error');
    } finally {
      /// Hide progress loader
      dismissProgressIndicator();
    }
    return responseJson;
  }

  /// Check response status and handle exception
  dynamic _response(http.Response response) async {
    switch (response.statusCode) {

    /// Successfully get api response
      case 200:
                 var responseJson = json.decode(
            response.body.toString(),
          );
          return responseJson;


    /// Bad request need to check url
      case 400:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw BadRequestException(ErrorModel.fromJson(
          json.decode(
            response.body.toString(),
          ),
        ).message);

    // /// if token expire
    // case 401:
    //   LoginResponseModel loginResponseModel= LoginResponseModel.fromJson(GetStorage().read(userData));
    //   var jsonData=await postAPICall(
    //     '${baseUrl}account/session/extend',
    //     {
    //       "refreshToken": loginResponseModel.data!.refreshToken
    //     },
    //   );
    //
    //   RefreshTokenModel refreshTokenModel = RefreshTokenModel.fromJson(jsonData);
    //   return refreshTokenModel;

    /// Authorisation token invalid
      case 403:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw UnauthorisedException(ErrorModel.fromJson(
          json.decode(
            response.body.toString(),
          ),
        ).message);

    /// Error occured while Communication with Server
      case 500:
      default:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw FetchDataException(
          'An error occurred occured while Communication with Server with StatusCode: ${response.statusCode}',
        );
    }
  }
}
