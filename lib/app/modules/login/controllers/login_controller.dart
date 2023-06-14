import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/routes/app_pages.dart';
import 'package:my_app_hospital/app_state.dart';
import 'package:sql_conn/sql_conn.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

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

  Future<void> login() async {
    try {
      await SqlConn.connect(
        ip: "192.168.1.178",
        port: "1433",
        databaseName: "STAGING_HIS",
        username: emailController.text, //appmobi
        password: pwdController.text, //123456a@
      );

      var res = await SqlConn.readData("SELECT * FROM [PRODUCT_USR].[dbo].[TBL_USER] where EMPLOYEECODE='admin'");
      print(res.toString());
      if (res != null) {
        //var encodedString = jsonEncode(res.toString());
        if (isSave.value) {
          AppState.instance.settingBox.write(SettingType.user.toString(), emailController.text);
          AppState.instance.settingBox.write(SettingType.password.toString(), pwdController.text);
          AppState.instance.settingBox.write(SettingType.inforUser.toString(), res.toString());
        }

        final valueMap = json.decode(res.toString().trim());

        inforUser.value = InforUserModer.fromJson(valueMap[0]);
        Get.offNamed(Routes.BOTTOM_BAR);
      }

      var resOffice = await SqlConn.readData("APPMBL_getPermissDEP 'ADMIN'"); //${inforUser.value.uSERID}
      print(resOffice.toString());
      if (resOffice != null) {
        AppState.instance.settingBox.write(SettingType.listOffice.toString(), resOffice.toString());
      }
    } catch (e) {
      Get.log(e.toString());
    }
  }
}
