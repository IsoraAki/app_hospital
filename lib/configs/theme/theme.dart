import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/app_fonts.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

final ThemeData themeHospital = ThemeData(
  fontFamily: AppFonts.baiJamjuree,
  primaryColor: AppColors.background,

  /// check here
  primaryColorLight: AppColors.background,
  iconTheme: const IconThemeData(color: AppColors.white),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.white),
  // checkboxTheme: CheckboxThemeData(
  //   fillColor: MaterialStateProperty.all(WalletColors.checkboxFill),
  //   checkColor: MaterialStateProperty.all(WalletColors.checkbox),
  //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(
  //       Radius.circular(5.0),
  //     ),
  //   ),
  // ),
  disabledColor: AppColors.hintText,
  unselectedWidgetColor: AppColors.backgroundBottombar,
  // text button
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColors.green),
      textStyle: MaterialStateProperty.all(TextStyle(
        fontFamily: AppFonts.baiJamjuree,
        fontSize: text_16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      )),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(54)),
        backgroundColor: MaterialStateProperty.all(AppColors.blue),
        elevation: MaterialStateProperty.all(0.0),
        textStyle: MaterialStateProperty.all(TextStyle(
          fontFamily: AppFonts.baiJamjuree,
          fontWeight: FontWeight.w600,
          fontSize: text_16,
        )),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size_radius_16),
        ))),
  ),
  dialogBackgroundColor: AppColors.background,
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.white),
    elevation: 0,
    titleTextStyle: TextStyle(
        fontFamily: AppFonts.baiJamjuree,
        fontWeight: FontWeight.w600,
        backgroundColor: AppColors.background,
        decorationColor: AppColors.hintText,
        color: AppColors.white,
        fontSize: text_18,
        height: 1.5 //the height between text, default is null (the actual height depends on the text's fontFamily).
        ),
    toolbarTextStyle: TextTheme(
      titleLarge: TextStyle(fontFamily: AppFonts.baiJamjuree, color: AppColors.white, fontSize: text_26, fontWeight: FontWeight.w700, height: 1.5),
    ).bodyMedium,
    // titleTextStyle: TextTheme(
    //   titleLarge: TextStyle(fontFamily: AppFonts.baiJamjuree, color: AppColors.white, fontSize: text_26, fontWeight: FontWeight.w700, height: 1.5),
    // ).titleLarge,
  ),
  dividerTheme: const DividerThemeData(color: AppColors.backgroundBottombar),
  dialogTheme: DialogTheme(
    backgroundColor: AppColors.backgroundBottombar,
    titleTextStyle: TextStyle(fontFamily: AppFonts.baiJamjuree, color: AppColors.white, fontSize: text_18, fontWeight: FontWeight.w600, height: 1.5),
    contentTextStyle: TextStyle(fontFamily: AppFonts.baiJamjuree, color: AppColors.white, fontSize: text_14, fontWeight: FontWeight.w400, height: 1.5),
  ),
  textTheme: TextTheme(
    headlineSmall: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_20, fontWeight: FontWeight.w600, color: AppColors.white),
    headlineMedium: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_18, fontWeight: FontWeight.w600, color: AppColors.white),
    titleLarge: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_16, fontWeight: FontWeight.w600, color: AppColors.white),
    displaySmall: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_14, fontWeight: FontWeight.w600, color: AppColors.white),
    displayMedium: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_12, fontWeight: FontWeight.w600, color: AppColors.white),

    displayLarge: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_14, fontWeight: FontWeight.w700, color: AppColors.white),

    // hint text
    titleMedium: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_20, fontWeight: FontWeight.w700, color: AppColors.white),
    titleSmall: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_16, fontWeight: FontWeight.w700, color: AppColors.white),

    // default text
    bodyLarge: TextStyle(
      fontFamily: AppFonts.baiJamjuree,
      fontSize: text_16,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFonts.baiJamjuree,
      fontSize: text_14,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),

    bodySmall: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_12, fontWeight: FontWeight.w400, color: AppColors.hintText),

    labelLarge: TextStyle(fontFamily: AppFonts.baiJamjuree, fontSize: text_16, fontWeight: FontWeight.w600, color: AppColors.white),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.blueGray40Color,
    filled: true,
    errorStyle: const TextStyle(fontFamily: AppFonts.baiJamjuree, color: AppColors.error),
    labelStyle: TextStyle(
      fontFamily: AppFonts.baiJamjuree,
      color: AppColors.hintText,
      fontSize: text_16,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: TextStyle(
      fontFamily: AppFonts.baiJamjuree,
      color: AppColors.hintText,
      fontSize: text_16,
      fontWeight: FontWeight.w400,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: size_20_h, horizontal: size_16_w),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(size_radius_16),
        borderSide: const BorderSide(
          color: AppColors.backgroundBottombar,
        ),
        gapPadding: 16),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(size_radius_16),
      borderSide: const BorderSide(
        color: AppColors.green,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(size_radius_16),
      borderSide: const BorderSide(
        color: AppColors.backgroundBottombar,
      ),
    ),
    errorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: AppColors.error), borderRadius: BorderRadius.all(Radius.circular(size_radius_16))),
    focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: AppColors.error), borderRadius: BorderRadius.all(Radius.circular(size_radius_16))),
  ),
  colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.white, primary: AppColors.green).copyWith(secondary: AppColors.error),
  bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.background),
);

const spacing0 = 0.0;
const spacing4 = 4.0;
const spacing6 = 6.0;
const spacing8 = 8.0;
const spacing10 = 10.0;
const spacing12 = 12.0;
const spacing16 = 16.0;
const spacing17 = 17.0;
const spacing64 = 24.0;
const spacing80 = 30.0;
const spacing13 = 13.0;
const spacing15 = 15.0;
const spacing30 = 30.0;
const spacing50 = 50.0;
const spacing20 = 20.0;
const spacing32 = 32.0;
const spacing24 = 24.0;
const spacing34 = 34.0;

const separatorBuilder = Divider(
  color: AppColors.white,
  thickness: 0.0,
);

const serticalDividerBuilder = VerticalDivider(
  thickness: 1,
  color: AppColors.white,
);

class FlutterU2U {
  static Widget spacing(size) {
    return SizedBox(
      height: size,
    );
  }

  static Widget spacingWidth(size) {
    return SizedBox(
      width: size,
    );
  }

  static Widget lineHorizontal({double? height, double? thickness, Color? color}) {
    return Divider(
      color: color ?? AppColors.backgroundBottombar.withOpacity(0.15),
      height: height ?? 1,
      thickness: thickness ?? 0.5,
    );
  }

  static Widget lineVertical({double? width, double? thickness, Color? color}) {
    return VerticalDivider(
      color: color,
      width: width ?? 1,
      thickness: thickness ?? 0.5,
    );
  }

  static Widget separatorBuilder({double? height, double? thickness, Color? color}) {
    return Divider(
      color: color ?? AppColors.backgroundBottombar.withOpacity(0.15),
      height: height ?? size_1_h,
      thickness: thickness ?? 0.5,
    );
  }

  static Text describeTextStyle(String content) {
    // Theme.of(context).textTheme.bodyText2!.copyWith(color: WalletColors.hintTextColor, height: 1.5),
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: AppFonts.baiJamjuree,
        color: AppColors.hintText,
        height: 1.5,
        fontWeight: FontWeight.w700,
        fontSize: text_14,
      ),
    );
  }
}

Future<bool?> showToast(String? message, {bool showLong = false, bool showOnTop = false}) {
  return Fluttertoast.showToast(
    msg: message ?? '',
    toastLength: showLong ? Toast.LENGTH_LONG : null,
    gravity: showOnTop ? ToastGravity.TOP : null,
  );
}
