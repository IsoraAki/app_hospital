import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/data/staff_infor_model.dart';
import 'package:my_app_hospital/app_state.dart';

class BottomBarController extends GetxController {
  //TODO: Implement BottomBarController

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
    super.onClose();
  }

  Future<void> getInForUser() async {
    final valueMapUser = json.decode(AppState.instance.settingBox.read(SettingType.inforUser.toString()).toString().trim());
    if (valueMapUser != null) {
      inforUser.value = StaffInforModel.fromJson(valueMapUser[0]);
    }
  }
}
