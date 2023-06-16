import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/data/office_model.dart';
import 'package:my_app_hospital/app/data/patient_information_model.dart';
import 'package:my_app_hospital/app_state.dart';
import 'package:sql_conn/sql_conn.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController\
  var dropDownValue = 'Chọn phòng ban'.obs;
  //var lv = 'Chọn phòng ban'.obs;
  var listOffice = [].obs;
  final inforUser = InforUserModer().obs;
  var tenphongban = ''.obs;
  var maphongban = ''.obs;
  var listPatientInfor = [].obs;

  @override
  void onInit() {
    //getOffice();
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

  void updateData(String dropDownValue) {
    this.dropDownValue.value = dropDownValue;
    //lv.value = lvValue;
  }

  Future<void> getList(String PCCS, int isGhiChuBS, int isSHBatThuong) async {
    try {
      var resOffice = await SqlConn.readData("exec APPMBL_SelectedListPatient '${maphongban.value}',N'$PCCS', $isGhiChuBS,$isSHBatThuong");
      print(resOffice.toString());
      if (resOffice != null) {
        listPatientInfor.value = [];
        final valueMap = json.decode(resOffice.toString().trim());
        if (valueMap != null) {
          for (var element in valueMap) {
            listPatientInfor.add(PatientInformationModel.fromJson(element));
          }
        }
      }
    } catch (e) {
      Get.log('getList error: $e');
    }
  }

  Future<void> getOffice() async {
    final valueMapUser = json.decode(AppState.instance.settingBox.read(SettingType.inforUser.toString()).toString().trim());
    if (valueMapUser != null) {
      inforUser.value = InforUserModer.fromJson(valueMapUser[0]);
    }

    listOffice.value = [];
    final valueMap = json.decode(AppState.instance.settingBox.read(SettingType.listOffice.toString()).toString().trim());
    if (valueMap != null) {
      for (var element in valueMap) {
        listOffice.add(OfficeModer.fromJson(element));
      }
    }
  }
}
