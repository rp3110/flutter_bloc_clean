import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

enum FontType {
  light,
  regular,
  medium,
  semiBold,
  bold,
}

class AppFontStyle {
  static const String fontFamilyPoppins = 'Poppins';
  static const String fontFamilyRedHatDisplay = 'RedHatDisplay';
  static const String fontFamilyLato = 'Lato-Regular.ttf';

  static FontWeight fontWeight(FontType fontType) {
    switch (fontType) {
      case FontType.light:
        return FontWeight.w300;
      case FontType.regular:
        return FontWeight.w400;
      case FontType.medium:
        return FontWeight.w500;
      case FontType.semiBold:
        return FontWeight.w600;
      case FontType.bold:
        return FontWeight.w700;
    }
  }

  static TextStyle textFieldTitleStyle() {
    return TextStyle(
        color: AppColors.primaryBlueColor,
        fontFamily: AppFontStyle.fontFamilyPoppins,
        fontWeight: AppFontStyle.fontWeight(FontType.regular),
        fontSize: 13);
  }

  static TextStyle textFieldPlaceholderStyle() {
    return TextStyle(
        color: AppColors.primaryBlack,
        fontFamily: AppFontStyle.fontFamilyPoppins,
        fontWeight: AppFontStyle.fontWeight(FontType.regular),
        fontSize: 14);
  }

  static TextStyle textFieldTextStyle() {
    return TextStyle(
        color: AppColors.primaryBlack,
        fontFamily: AppFontStyle.fontFamilyPoppins,
        fontWeight: AppFontStyle.fontWeight(FontType.regular),
        fontSize: 14);
  }

  static TextStyle buttonTextStyle() {
    return TextStyle(
        color: AppColors.primaryWhite,
        fontFamily: AppFontStyle.fontFamilyPoppins,
        fontWeight: AppFontStyle.fontWeight(FontType.medium),
        fontSize: 15);
  }

  static TextStyle tabLabelSelectedTextStyle() {
    return TextStyle(
        color: AppColors.primaryBlueColor,
        fontFamily: AppFontStyle.fontFamilyRedHatDisplay,
        fontWeight: AppFontStyle.fontWeight(FontType.bold),
        fontSize: 14);
  }

  static TextStyle tabLabelUnSelectedTextStyle() {
    return TextStyle(
        color: AppColors.primaryBlack,
        fontFamily: AppFontStyle.fontFamilyRedHatDisplay,
        fontWeight: AppFontStyle.fontWeight(FontType.medium),
        fontSize: 14);
  }

  static TextStyle navbarTitleTextStyle() {
    return TextStyle(
        color: AppColors.primaryWhite,
        fontFamily: AppFontStyle.fontFamilyRedHatDisplay,
        fontWeight: AppFontStyle.fontWeight(FontType.semiBold),
        fontSize: 17);
  }

  static TextStyle customTextStyle(
      Color color, String fontFamily, FontType fontType, double fontSize,
      {TextDecoration? decoration, double? height}) {
    return TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontWeight: AppFontStyle.fontWeight(fontType),
        fontSize: fontSize,
        decoration: decoration,
        height: height);
  }
}
