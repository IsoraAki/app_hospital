import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';
import 'package:my_app_hospital/app/network/repositories/app_repository.dart';
import 'package:my_app_hospital/app/routes/navigate_keys.dart';
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

  Future<void> connectSQL() async {
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

        // final valueMap = json.decode(res.toString().trim());

        // inforUser.value = InforUserModer.fromJson(valueMap[0]);
      } else {
        ProgressDialog.showDialogNotification(NavigateKeys().navigationKey.currentContext!, content: 'Kết nối data không thành công');
      }

      var resOffice = await SqlConn.readData("APPMBL_getPermissDEP 'ADMIN'"); //${inforUser.value.uSERID}
      print(resOffice.toString());
      if (resOffice != null) {
        AppState.instance.settingBox.write(SettingType.listOffice.toString(), resOffice.toString());
      } else {
        ProgressDialog.showDialogNotification(NavigateKeys().navigationKey.currentContext!, content: 'Kết nối data không thành công');
      }
    } catch (e) {
      ProgressDialog.showDialogNotification(NavigateKeys().navigationKey.currentContext!, content: 'Kết nối data không thành công');
      Get.log(e.toString());
    }
  }

  Future<void> logIn() async {
    try {
      AppState.instance.settingBox.remove(SettingType.inforUser.toString());
      final MyResponse? myResponse = await _appRepository
          .login(
            username: emailController.text,
            password: md5.convert(utf8.encode(pwdController.text)).toString(),
          )
          .timeout(const Duration(seconds: 60));
      Get.log('username: ${emailController.text} || password: ${pwdController.text}');
      if (myResponse != null) {
        if (myResponse.success == true) {
          await connectSQL();
          // CacheHelper.saveData(key: 'user_name', value: username);
          // CacheHelper.saveData(key: 'password', value: password);
          // CacheHelper.saveData(key: 'token', value: myResponse.data!.first.token);
        }
      }
    } on TimeoutException catch (e) {
      //log(e.toString());
      //emit(LoginErrorState());
    } catch (e) {
      //emit(LoginErrorState());
      //ProgressDialog.showDialogwWarning(context, content: e.toString());
      Get.log(e.toString());
    }
  }
}
