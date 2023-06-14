import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/office_model.dart';
import 'package:my_app_hospital/app_state.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController\
  var dropDownValue = 'Chọn phòng ban'.obs;
  var lv = 'Chọn phòng ban'.obs;
  var listOffice = [];

  @override
  void onInit() {
    getOffice();
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

  void updateData({String? dropDownValue, String? lvValue}) {
    this.dropDownValue.value = dropDownValue ?? this.dropDownValue.value;
    lv.value = lvValue ?? lv.value;
  }

  Future<void> getOffice() async {
    listOffice = [];
    final valueMap = json.decode(AppState.instance.settingBox.read(SettingType.listOffice.toString()).toString().trim());

    for (var element in valueMap) {
      listOffice.add(OfficeModer.fromJson(element));
    }
  }
}
