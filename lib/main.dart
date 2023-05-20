import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:my_app_hospital/configs/theme/theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (ctx, child) => GetMaterialApp(
      title: "Application",
      theme: themeHospital,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  )
      // GetMaterialApp(
      //   title: "Application",
      //   theme: themeHospital,
      //   initialRoute: AppPages.INITIAL,
      //   getPages: AppPages.routes,
      // ),
      );
}
