import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';
import 'package:my_app_hospital/app/network/repositories/app_repository.dart';
import 'package:my_app_hospital/app_state.dart';
import 'package:sql_conn/sql_conn.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  AppRepository _appRepository = AppRepository();

  final inforUser = InforUserModer().obs;

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

  Future<void> connectSQL(BuildContext context) async {
    try {
      await SqlConn.connect(
        ip: "192.168.1.178",
        port: "1433",
        databaseName: "STAGING_HIS",
        username: 'appmobi',
        password: '123456a@',
      );

      // var res = await SqlConn.readData("SELECT * FROM [PRODUCT_USR].[dbo].[TBL_USER] where EMPLOYEECODE='admin'");
      var res = await SqlConn.readData("APPMBL_getDepPermissFromUserCode '${emailController.text}'");

      print(res.toString());
      if (res != null) {
        //var encodedString = jsonEncode(res.toString());
        AppState.instance.settingBox.write(SettingType.inforUser.toString(), res.toString());
        if (isSave.value) {
          AppState.instance.settingBox.write(SettingType.user.toString(), emailController.text);
          AppState.instance.settingBox.write(SettingType.password.toString(), pwdController.text);
        }
      } else {
        ProgressDialog.showDialogNotification(context, content: 'Kết nối data không thành công');
      }

      var resOffice = await SqlConn.readData("APPMBL_getPermissDEP 'ADMIN'"); //${inforUser.value.uSERID}
      print(resOffice.toString());
      if (resOffice != null) {
        AppState.instance.settingBox.write(SettingType.listOffice.toString(), resOffice.toString());
      } else {
        ProgressDialog.showDialogNotification(context, content: 'Kết nối data không thành công');
      }
    } catch (e) {
      ProgressDialog.showDialogNotification(context, content: 'Kết nối data không thành công');
      Get.log(e.toString());
    }
  }

  Future<void> passwordEncrypt(BuildContext context) async {
    try {
      final MyResponse? myResponse = await _appRepository
          .passwordEncrypt(
            password: pwdController.text,
          )
          .timeout(const Duration(seconds: 60));
      Get.log('username: ${emailController.text} || password: ${pwdController.text}');
      if (myResponse?.data != null) {
        String password = myResponse!.data!.first.toString();
        // ignore: use_build_context_synchronously
        await logIn(context, password);
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

  Future<void> logIn(BuildContext context, String password) async {
    try {
      AppState.instance.settingBox.remove(SettingType.inforUser.toString());
      final MyResponse? myResponse = await _appRepository
          .login(
            username: emailController.text,
            password: password,
          )
          .timeout(const Duration(seconds: 60));
      Get.log('username: ${emailController.text} || password: ${pwdController.text}');
      if (myResponse != null) {
        if (myResponse.success == true) {
          Get.log('${myResponse.result?.first['LOGINRESULTTYPE']}');
          if (myResponse.result?.first['LOGINRESULTTYPE'] == 0) {
            // ignore: use_build_context_synchronously
            await connectSQL(context);
          } else {
            // ignore: use_build_context_synchronously
            ProgressDialog.showDialogNotification(context, content: 'Sai tài khoản hoặc mật khẩu');
          }
        }
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
}
