

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class APIManagerUtils {
  //static String secretKey = ""; // TODO : Need to remove after demo purpose

  static Future<bool> checkConnection() async {
    ConnectivityResult connectivityResult =
    await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      debugPrint(" APIManagerUtils:: checkConnection >> Internet Connected");
      return true;
    } else {
      debugPrint(
          " APIManagerUtils:: checkConnection >> Internet Not Connected");
      return false;
    }
  }

/*  static Future<bool?> apiCallGetUserProfile(BuildContext context,
      {bool isInBackground = false, bool isRefresh = false}) async {
    if (GlobalVariable.userDetail.user != null) {
      return true;
    }

    var map = <String, dynamic>{};
    if (GlobalVariable.userDetail.token?.id != null) {
      map["UserId"] = GlobalVariable.userDetail.token?.id!;
    }

    if (!isInBackground && !isRefresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LoaderWidget.show();
      });
    }

    await APIManager.instance
        .postRequest(
        requestURL: APIConstant.getUserProfile,
        requestData: map,
        context: context,
        isAuthRequired: true)
        .then((response) {
      if (!isInBackground && !isRefresh) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          LoaderWidget.dismiss();
        });
      }
      if (response != null) {
        if (response[APIManager.statusCode] == 200) {
          //Success Response
          final responseData = response[APIManager.data];
          if (responseData != null) {
            GlobalVariable.userDetail.user = User.fromJson(responseData);
          }
        } else {
          final message = response[APIManager.message];
          if (message != null) {
            CommonFunction.showAlert(context, appName, message);
          }
        }
      }
      return true;
    });
    return null;
  }*/
}