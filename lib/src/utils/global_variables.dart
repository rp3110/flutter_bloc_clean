import 'package:flutter/material.dart';

import '../data/models/common/user_details.dart';

const String appName = 'GoolGoal';
const String appVersion = "v.1.0.0";

///Build Environment
enum BuildEnvironment { dev, staging, live }

/// GlobalVariable
class GlobalVariable {
  ///To Fetch Global Context
  static var materialKey = GlobalKey<NavigatorState>();

  ///Get/ Set User details globally
  static UserDetail userDetail = UserDetail();

  ///isInitiateAppForDefaultLogin
  static bool isInitiateAppForDefaultLogin = true;

  ///Define Build Environment
  static var currentEnvironment = BuildEnvironment
      .staging; // TODO: Always set environment while sharing build DEV/QA/LIVE Release

  static late String fcmToken;
}
