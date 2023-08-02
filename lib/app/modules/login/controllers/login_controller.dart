import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/network/data/model/staff_infor_model.dart';
import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';
import 'package:my_app_hospital/app/network/local/cache_helper.dart';
import 'package:my_app_hospital/app/network/repositories/app_repository.dart';

import 'package:my_app_hospital/app_state.dart';

class LoginController extends GetxController {
  AppRepository appRepository = AppRepository();

  final inforUser = InforUserModer().obs;

  final inforBS = StaffInforModel().obs;

  final isSave = false.obs;

  final TextEditingController pwdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    isSave.value = AppState.instance.settingBox.read(SettingType.isSave.toString()) ?? false;
    emailController.text = AppState.instance.settingBox.read(SettingType.user.toString()) ?? emailController.text;
    pwdController.text = AppState.instance.settingBox.read(SettingType.password.toString()) ?? pwdController.text;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> logIn(BuildContext context) async {
    try {
      AppState.instance.settingBox.remove(SettingType.inforUser.toString());
      final MyResponse? myResponse = await appRepository
          .login(
            username: emailController.text,
            password: pwdController.text,
          )
          .timeout(const Duration(seconds: 60));
      Get.log('username: ${emailController.text} || password: ${pwdController.text}');
      if (myResponse != null) {
        if (myResponse.code == "SUCCESS") {
          if (isSave.value) {
            AppState.instance.settingBox.write(SettingType.user.toString(), emailController.text);
            AppState.instance.settingBox.write(SettingType.password.toString(), pwdController.text);
          }
          CacheHelper.saveData(key: 'token', value: myResponse.data?.first['token']);
          // ignore: use_build_context_synchronously
          await profile(context);
        } else {
          // ignore: use_build_context_synchronously
          ProgressDialog.showDialogNotification(context, content: 'Sai tài khoản hoặc mật khẩu');
        }
      } else {
        // ignore: use_build_context_synchronously
        ProgressDialog.showDialogNotification(context, content: 'Sai tài khoản hoặc mật khẩu');
      }
    } on TimeoutException {
      // ignore: use_build_context_synchronously
      ProgressDialog.showDialogNotification(context, content: 'Kết nối đươc với máy chủ');
    } catch (e) {
      // ignore: use_build_context_synchronously
      ProgressDialog.showDialogNotification(context, content: 'Đăng nhập không thành công');
      Get.log(e.toString());
    }
  }

  Future<void> profile(BuildContext context) async {
    try {
      final MyResponse? myResponse = await appRepository.profile().timeout(const Duration(seconds: 60));

      if (myResponse != null) {
        if (myResponse.code == "SUCCESS") {
          inforBS.value = myResponse.data?.first;
        } else {
          // ignore: use_build_context_synchronously
          ProgressDialog.showDialogNotification(context, content: 'Không lấy được thông tin tài khoản');
        }
      } else {
        // ignore: use_build_context_synchronously
        ProgressDialog.showDialogNotification(context, content: 'Không lấy được thông tin tài khoản');
      }
    } on TimeoutException {
      // ignore: use_build_context_synchronously
      ProgressDialog.showDialogNotification(context, content: 'Kết nối đươc với máy chủ');
    } catch (e) {
      // ignore: use_build_context_synchronously
      ProgressDialog.showDialogNotification(context, content: 'Không lấy được thông tin tài khoản');
      Get.log(e.toString());
    }
  }
}
