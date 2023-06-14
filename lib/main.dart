import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app_hospital/app/modules/home/controllers/home_controller.dart';
import 'package:my_app_hospital/app/modules/login/controllers/login_controller.dart';
import 'package:my_app_hospital/app_state.dart';
import 'package:my_app_hospital/configs/theme/theme.dart';

import 'app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  init();
  if (AppState.instance.settingBox.read(SettingType.isSave.toString()) == null) {
    AppState.instance.settingBox.write(SettingType.isSave.toString(), false);
  }
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
  ));
}

Future<void> init() async {
  // await Get.putAsync(() async {
  //   await GetStorage.init();
  //   return GetStorage();
  // });
  Get.put(
    LoginController(),
    permanent: true,
  );

  Get.put(
    BottomBarController(),
    permanent: true,
  );

  Get.put(
    HomeController(),
    permanent: true,
  );
}
