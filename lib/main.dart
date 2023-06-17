import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app_hospital/app/modules/bottom_bar/bindings/bottom_bar_binding.dart';
import 'package:my_app_hospital/app/modules/command/bindings/command_binding.dart';
import 'package:my_app_hospital/app/modules/home/bindings/home_binding.dart';
import 'package:my_app_hospital/app/modules/login/bindings/login_binding.dart';
import 'package:my_app_hospital/app/network/local/cache_helper.dart';
import 'package:my_app_hospital/app/network/remote/dio.dart';
import 'package:my_app_hospital/app_state.dart';
import 'package:my_app_hospital/configs/theme/theme.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  await CacheHelper.init();
  await DioHelper.init();

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
  LoginBinding().dependencies();
  // Get.lazyPut(() => LoginController());
  BottomBarBinding().dependencies();
  //Get.lazyPut(() => BottomBarController());
  HomeBinding().dependencies();
  //Get.lazyPut(() => HomeController());
  //CommandBinding().dependencies();
  //Get.lazyPut(() => CommandController());
  //CommandBinding().dependencies();
}
