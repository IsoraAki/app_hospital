import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/staff_infor_model.dart';
import 'package:my_app_hospital/app_state.dart';
import 'package:sql_conn/sql_conn.dart';

class BottomBarController extends GetxController {
  final inforUser = StaffInforModel().obs;
  final count = 0.obs;
  final index = 2.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    SqlConn.disconnect();
    super.onClose();
  }

  Future<void> getInForUser() async {
    var valueMapUser;
    if (AppState.instance.settingBox.read(SettingType.inforUser.toString()) != null &&
        AppState.instance.settingBox.read(SettingType.inforUser.toString()) != '') {
      valueMapUser = json.decode(AppState.instance.settingBox.read(SettingType.inforUser.toString()).toString().trim());
    }

    if (valueMapUser != null && valueMapUser != '') {
      inforUser.value = StaffInforModel.fromJson(valueMapUser[0]);
    }
  }
}
