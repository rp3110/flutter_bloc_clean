import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';
import 'app_font_style.dart';
import 'global_variables.dart';

class CommonFunction {
  static bool isDialogShowing = false;

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight({required BuildContext context, bool safeArea = false}) {
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    var finalVal = safeArea ? height - (padding.top) : height;
    return finalVal;
  }

  /*static List<BoxShadow> addShadow() {
    return [
       BoxShadow(
          color: AppColors., spreadRadius: 2, blurRadius: 4, offset: Offset(1, 1))
    ];
  }*/

  static String getDateSuffix(String val) {
    if (val.substring(val.length - 1) == '1') {
      return '${val}st';
    } else if (val.substring(val.length - 1) == '2') {
      return '${val}nd';
    } else if (val.substring(val.length - 1) == '3') {
      return '${val}rd';
    } else {
      return '${val}th';
    }
  }

  static Color getRandomColor() {
    var random = Random();
    return Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
  }

  static Future<void> showAlert(BuildContext context, String title, String message,
      {VoidCallback? onTapOk}) async {
    CommonFunction.isDialogShowing = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            CommonFunction.isDialogShowing = false;
            return Future(() => true);
          },
          child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        title,
                        style: AppFontStyle.customTextStyle(AppColors.primaryBlack,
                            AppFontStyle.fontFamilyPoppins, FontType.medium, 20),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                        color: AppColors.lightGray.withOpacity(0.8),
                        height: 1.5,
                        width: double.maxFinite),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  message,
                                  style: AppFontStyle.customTextStyle(
                                      AppColors.primaryBlack.withOpacity(0.8),
                                      AppFontStyle.fontFamilyPoppins,
                                      FontType.medium,
                                      14),
                                  maxLines: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            child: buildCustomOption(title: "OK", isOpposite: false),
                            onTap: () {
                              CommonFunction.isDialogShowing = false;
                              if (onTapOk != null) {
                                onTapOk();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  static Future<void> showAlertWithActionHandle(
      BuildContext context, String title, String message,
      {required String cancelTitle,
        required VoidCallback onTapCancel,
        required String okTitle,
        required VoidCallback onTapOk}) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      title,
                      style: AppFontStyle.customTextStyle(AppColors.primaryBlack,
                          AppFontStyle.fontFamilyPoppins, FontType.medium, 20),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                      color: AppColors.lightGray.withOpacity(0.8),
                      height: 1.5,
                      width: double.maxFinite),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                message,
                                style: AppFontStyle.customTextStyle(
                                    AppColors.primaryBlack.withOpacity(0.8),
                                    AppFontStyle.fontFamilyPoppins,
                                    FontType.medium,
                                    14),
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: buildCustomOption(
                                  title: cancelTitle,
                                  isOpposite: true,
                                  hasOpposite: true),
                              onTap: () {
                                onTapCancel();
                              },
                            ),
                            InkWell(
                              child: buildCustomOption(
                                  title: okTitle,
                                  isOpposite: false,
                                  hasOpposite: true),
                              onTap: () {
                                onTapOk();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  static Future<void> showAlertWithCompletionBack(
      BuildContext context, String title, String message,
      {required VoidCallback onTapOk}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () {
              CommonFunction.isDialogShowing = false;
              return Future(() => true);
            },
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          title,
                          style: AppFontStyle.customTextStyle(AppColors.primaryBlack,
                              AppFontStyle.fontFamilyPoppins, FontType.medium, 20),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                          color: AppColors.lightGray.withOpacity(0.8),
                          height: 1.5,
                          width: double.maxFinite),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    message,
                                    style: AppFontStyle.customTextStyle(
                                        AppColors.primaryBlack.withOpacity(0.8),
                                        AppFontStyle.fontFamilyPoppins,
                                        FontType.medium,
                                        14),
                                    maxLines: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              child: buildCustomOption(title: "OK", isOpposite: false),
                              onTap: () {
                                onTapOk();
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static AppBar buildCustomAppBarWidget(String title,
      {bool automaticallyImplyLeading = true}) {
    return AppBar(
      title: Text(title, style: AppFontStyle.navbarTitleTextStyle()),
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.primaryBlueColor, AppColors.primaryBlueDarkShade]),
        ),
      ),
    );
  }

  static buildCustomOption(
      {required String title, required bool isOpposite, bool hasOpposite = false}) {
    return Container(
      width: hasOpposite ? 110 : double.maxFinite,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: isOpposite
                ? [AppColors.lightGray5, AppColors.lightGray5.withOpacity(0.6)]
                : [AppColors.primaryBlueDarkShade, AppColors.primaryBlueLightShade]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: AppFontStyle.customTextStyle(
            AppColors.primaryWhite, AppFontStyle.fontFamilyPoppins, FontType.semiBold, 15),
      ),
    );
  }

  static showSnackBar(
      {required BuildContext context,
        required isError,
        required String message,
        int? duration}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(GlobalVariable.materialKey.currentContext!)
          .showSnackBar(SnackBar(
          duration: Duration(seconds: duration ?? 3),
          backgroundColor: isError ? AppColors.red : AppColors.primaryGreen,
          content: Text(
            message,
            style: AppFontStyle.customTextStyle(AppColors.primaryWhite,
                AppFontStyle.fontFamilyPoppins, FontType.medium, 14),
          )));
    });
  }

  static String shortenName(String name) {
    List<String> names = name.toUpperCase().trim().split(" ");
    if (names.length == 1) {
      String name = names[0];
      if (name.length <= 3) {
        return name;
      } else {
        return name[0] + name[1] + name[2];
      }
    } else if (names.length == 2) {
      String name1 = names[0];
      String name2 = names[1];
      return name1[0] + name1[1] + name2[0];
    } else if (names.length >= 3) {
      return names[0][0] + names[1][0] + names[2][0];
    }
    return "";
  }

  static String formatScore(String score) {
    if (score.length == 4) {
      return "0$score";
    } else {
      return score;
    }
  }

  static String convertDate(String date, [String? format]) {
    if (date.isNotEmpty) {
      var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(date, true).toLocal();
      return DateFormat(format ?? 'hh:mm a, EEE, d MMM').format(dateTime).toString();
    } else {
      return "";
    }
  }
}
