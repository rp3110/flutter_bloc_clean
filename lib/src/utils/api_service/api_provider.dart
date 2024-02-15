import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../app_validation_message.dart';
//libraries you want to make available automatically when using your package

import 'dart:async';

import '../common_function.dart';
import '../global_variables.dart';
import '../navigator_key.dart';
import 'api_manager_constant.dart';
import 'api_manager_utils.dart';

class APIManager {
  /// /*For preparing Response For Success and Failure type
  ///  with binding statusCode, statusMessage, response in Map*/
  /// static const String statusCode = "StatusCode";
  /// static const String statusMessage = "StatusMessage";
  /// static const String response = "Response";

  static const String message = "Message";
  static const String statusCode = "StatusCode";
  static const String data = "Result";

  /// Dio object initialisation as global use
  var dio = Dio();

  /// APIManager create singleton pattern and initialise an instance
  static final APIManager _singleton = APIManager._internal();

  static APIManager get instance => _singleton;

  factory APIManager() {
    /// APIManager Initiated
    return _singleton;
  }

  APIManager._internal() {
    /// APIManager._internal build logic
    dioInitialSetup();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  void dioInitialSetup() {
    /// Each Dio instance has a interceptor by which you can
    /// intercept requests or responses before they are
    /// Print request [Options]
    /// Print request header [Options.headers]
    /// Print request data [Options.data]
    /// Print [Response.data]
    /// Print [Response.headers]
    /// Print error message
    /// Log size per print
    ///
    /// While you don't required commit these lines of code
    ///

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      //false Because while multipart form data It's to lengthy
      //But you can set as per your convenience
      responseHeader: true,
      responseBody: true,
      error: true,
      //logSize: 2048
    ));

    /// [receiveTimeout] you can set for sending data.
    /// [connectTimeout] you can set for receiving data.
    ///
    /// dio.options.receiveTimeout = 5000; //5 sec
    /// dio.options.connectTimeout = 5000; // 5 sec
  }

  /// VConnect:: Header Object for [application/json]
  Map<String, dynamic> headerJSON(bool isAuthRequired, {isMultipartFormData = false}) {
    var headers = <String, String>{};
    if (isMultipartFormData == true) {
      headers["Accept"] = "*/*";
      headers["Content-Type"] = "multipart/form-data";
    } else {
      headers["Accept"] = APIManagerConstants.contentTypeJSON;
      headers["Content-Type"] = APIManagerConstants.contentTypeJSON;
    }
    if (isAuthRequired) {
      if (GlobalVariable.userDetail.token != null) {
        if (GlobalVariable.userDetail.token!.token != null) {
          headers["Authorization"] = "Bearer ${GlobalVariable.userDetail.token!.token!}";
        }
      }
    }
    return headers;
  }

  /// POST Request
  Future<dynamic> postRequest(
      {required String requestURL,
      Map<String, dynamic>? queryParameters,
      dynamic requestData,
      bool isAuthRequired = false,
      isMultipartFormData = false}) async {
    dynamic parsed;
    if (await APIManagerUtils.checkConnection()) {
      await dio
          .post(requestURL,
              queryParameters: queryParameters,
              data: requestData,
              options: Options(
                  headers: headerJSON(isAuthRequired,
                      isMultipartFormData: isMultipartFormData)))
          .then((response) {
        parsed = _handleResponse(response);
      }).catchError((error) {
        parsed = _handleError(NavigatorKey.navigatorKey.currentContext!, error);
      });
    } else {
      //parsed = _handleError(context, DioError(type: DioErrorType.DEFAULT, requestOptions: null));
      if (CommonFunction.isDialogShowing == false &&
          NavigatorKey.navigatorKey.currentContext!.mounted) {
        CommonFunction.showAlert(NavigatorKey.navigatorKey.currentContext!, appName,
            APIManagerConstants.networkError);
      }
      parsed = null;
    }
    return parsed;
  }

  /// POST Request ForBytesResponse
  Future<dynamic> postRequestForBytesResponse(
      {required String requestURL,
      Map<String, dynamic>? queryParameters,
      required Map requestData,
      required bool isAuthRequired}) async {
    dynamic parsed;
    if (await APIManagerUtils.checkConnection()) {
      await dio
          .post(requestURL,
              queryParameters: queryParameters,
              data: requestData,
              options: Options(
                  headers: headerJSON(isAuthRequired), responseType: ResponseType.bytes))
          .then((response) {
        parsed = _handleResponse(response);
      }).catchError((error) {
        parsed = _handleError(NavigatorKey.navigatorKey.currentContext!, error);
      });
    } else {
      parsed = null;
    }
    return parsed;
  }

  /// PUT Request
  Future<dynamic> putRequest(
      {required String requestURL,
      Map<String, dynamic>? queryParameters,
      dynamic requestData,
      bool isAuthRequired = false}) async {
    dynamic parsed;
    if (await APIManagerUtils.checkConnection()) {
      await dio
          .put(requestURL,
              queryParameters: queryParameters,
              data: requestData,
              options: Options(headers: headerJSON(isAuthRequired)))
          .then((response) {
        parsed = _handleResponse(response);
      }).catchError((error) {
        parsed = _handleError(NavigatorKey.navigatorKey.currentContext!, error);
      });
    } else {
      if (CommonFunction.isDialogShowing == false &&
          NavigatorKey.navigatorKey.currentContext!.mounted) {
        CommonFunction.showAlert(NavigatorKey.navigatorKey.currentContext!, appName,
            APIManagerConstants.networkError);
      }
      parsed = null;
    }
    return parsed;
  }

  /// [requestURL] API request URL
  /// [queryParameters] API URL Query Parameter
  /// [requestData] for needed API type pass as Body
  /// [context] Current Context for show global alert for network related failure
  /// [isAuthRequired] weather need to add UserToken, Key for Restful API

  /// GET Request
  Future<dynamic> getRequest(
      {required String requestURL,
      Map<String, dynamic>? queryParameters,
      bool isAuthRequired = false}) async {
    dynamic parsed;
    if (await APIManagerUtils.checkConnection()) {
      await dio
          .get(requestURL,
              queryParameters: queryParameters,
              options: Options(headers: headerJSON(isAuthRequired)))
          .then((response) {
        parsed = _handleResponse(response);
      }).catchError((error) {
        parsed = _handleError(NavigatorKey.navigatorKey.currentContext!, error);
      });
    } else {
      if (CommonFunction.isDialogShowing == false &&
          NavigatorKey.navigatorKey.currentContext!.mounted) {
        CommonFunction.showAlert(NavigatorKey.navigatorKey.currentContext!, appName,
            APIManagerConstants.networkError);
      }
      parsed = null;
    }
    return parsed;
  }

  /// DELETE Request
  Future<dynamic> deleteRequest(
      {required String requestURL,
      Map<String, dynamic>? queryParameters,
      Map? requestData,
      bool isAuthRequired = false}) async {
    dynamic parsed;
    if (await APIManagerUtils.checkConnection()) {
      await dio
          .delete(requestURL,
              queryParameters: queryParameters,
              data: requestData,
              options: Options(headers: headerJSON(isAuthRequired)))
          .then((response) {
        parsed = _handleResponse(response);
      }).catchError((error) {
        parsed = _handleError(NavigatorKey.navigatorKey.currentContext!, error);
      });
    } else {
      if (CommonFunction.isDialogShowing == false &&
          NavigatorKey.navigatorKey.currentContext!.mounted) {
        CommonFunction.showAlert(NavigatorKey.navigatorKey.currentContext!, appName,
            APIManagerConstants.networkError);
      }
      parsed = null;
    }
    return parsed;
  }

  /// [requestURL] API request URL
  /// [queryParameters] API URL Query Parameter
  /// [requestData] for needed API type pass as Body
  /// [context] Current Context for show global alert for network related failure
  /// [isAuthRequired] weather need to add UserToken, Key for Restful API

  /// Prepare Success Response Json with StatusCode, StatusMessage, Response
  dynamic _handleResponse(Response response) {
    if (kDebugMode) {
      print(" response.data :: {$response.data}");
    }
    return response.data;
  }

  /// API Request Failure Error Manage with Response Mapping
  dynamic _handleError(BuildContext context, DioException error) {
    String errorMsg = _handleDioError(error);
    if (error.type == DioExceptionType.badResponse && error.response != null) {
      /// When the server response, but with a incorrect status, such as 404, 503...
      /// Manage As per needed @ api call response callback with different status code
      debugPrint(" error statusCode = ${error.response!.statusCode}");
      debugPrint(" error statusMessage = ${error.response!.statusMessage}");
      debugPrint(" error Response = ${error.response}");

      if (error.response!.statusCode == 401) {
        // TODO : Need to check and manage For VConnect & HRMS (If manage expiration) response
        /// Invalid Authentication : Need to redirect login screen
        if (error.response!.data != null) {
          final message = error.response!.data[APIManager.message];
          bool isRedirectTOLogin = false;
          if (message != null) {
            if (message == "Authorization Failed.") {
              isRedirectTOLogin = true;
            }
          } else if (message == null) {
            isRedirectTOLogin = true;
          }
          if (isRedirectTOLogin) {
            if (CommonFunction.isDialogShowing) {
              Navigator.of(context).pop();
            }
            CommonFunction.isDialogShowing = true;
            CommonFunction.showAlertWithCompletionBack(context, appName, message,
                onTapOk: () {
              CommonFunction.isDialogShowing = false;
              /*SecureStorage.removeUserDetail().then((isRemoved) {
                //if (isRemoved == true) {
                GlobalVariable.currentSelectedMenu = MenuItem.timesheet;
                //CommonFunction.isShowLoginContent = true; // TODO : TC
                Navigator.pop(context);
                //goToLogin(context);// TODO : Need to check and manage For VConnect response
                //}
              });*/
            });
            return null;
          }
        }
      } else if (error.response!.statusCode == 404) {
        if (CommonFunction.isDialogShowing == false) {
          CommonFunction.showAlert(context, appName, "Not Found");
        }
        return null;
      }
      return error.response!.data;
    } else if (error.response!.statusCode == 500) {
      // TODO : Need to check and manage For VConnect & HRMS (If manage expiration) response
      /// Invalid Authentication : Need to redirect login screen
      if (error.response!.data == null) {
        const message = AppValidationMessage.validationInternalServerIssue;
        if (CommonFunction.isDialogShowing) {
          Navigator.of(context).pop();
        }
        CommonFunction.isDialogShowing = true;
        CommonFunction.showAlertWithCompletionBack(context, appName, message,
            onTapOk: () {
          CommonFunction.isDialogShowing = false;
          Navigator.pop(context);
        });
        return null;
      }
    } else {
      if (CommonFunction.isDialogShowing == false) {
        CommonFunction.showAlert(context, appName, errorMsg);
      }
    }
    return null;
  }

  /// Dio Default Handle Some types of Error on Failure Response
  /// Based on that Here map different ype of DioError.
  /// Bind appropriate message for the same.
  ///
  String _handleDioError(DioException error) {
    String errorDescription = "";
    switch (error.type) {
      case DioExceptionType.badResponse:
        String errorDescription =
            "Received invalid status code: ${error.response!.statusCode} ??= "
            "";
        return errorDescription;
      case DioExceptionType.unknown:
        errorDescription = APIManagerConstants.networkError;
        break;
      case DioExceptionType.cancel:
        errorDescription = APIManagerConstants.requestCancel;
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = APIManagerConstants.connectionTimeout;
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = APIManagerConstants.connectionTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = APIManagerConstants.receiveTimeout;
        break;
      case DioExceptionType.badCertificate:
        errorDescription = APIManagerConstants.badCertificate;
        break;
      case DioExceptionType.connectionError:
        errorDescription = APIManagerConstants.connectionError;
        break;
    }
    return errorDescription;
  }
}
