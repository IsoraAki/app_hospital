import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/patient_information_model.dart';
import 'package:my_app_hospital/app/routes/app_pages.dart';
import 'package:sql_conn/sql_conn.dart';

class MedicationScheduleController extends GetxController {
  //TODO: Implement MedicationScheduleController

  TextEditingController searchController = TextEditingController();

  var dropDownValue = 'Tất cả'.obs;
  var lv = 'Tất cả'.obs;
  var listPatientInfor = [].obs;

  var tenphongban = ''.obs;
  var maphongban = ''.obs;

  var isGhiChuBS = 0.obs;
  var isSHBatThuong = 0.obs;

  var sarchlistPatientInfor = [].obs;

  var checkboxValue1 = true.obs;
  var checkboxValue2 = false.obs;
  var checkboxValue3 = false.obs;
  var checkboxValue4 = false.obs;

  @override
  void onInit() {
    searchController.clear;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void updateData({String? dropDownValue, String? lvValue}) {
    this.dropDownValue.value = dropDownValue ?? this.dropDownValue.value;
    lv.value = lvValue ?? lv.value;
  }

  void onSearchTextChanged(String text) async {
    var newList = [];

    for (var element in listPatientInfor) {
      if (element.tENBENHNHAN.toString().toLowerCase().contains(text.toLowerCase()) ||
          element.mAYTE.toString().toLowerCase().contains(text.toLowerCase()) ||
          element.sOBENHAN.toString().toLowerCase().contains(text.toLowerCase())) {
        newList.add(element);
      }
    }
    sarchlistPatientInfor.value = newList.isNotEmpty ? newList : listPatientInfor;
  }

  Future<void> getList(BuildContext context, String PCCS, int isGhiChuBS, int isSHBatThuong, {bool? isGetTo}) async {
    try {
      listPatientInfor.value = [];
      var resOffice = await SqlConn.readData("exec APPMBL_SelectedListPatient '${maphongban.value}',N'$PCCS', $isGhiChuBS,$isSHBatThuong");
      print(resOffice.toString());
      if (resOffice != null) {
        final valueMap = json.decode(resOffice.toString().trim());
        if (valueMap != null) {
          for (var element in valueMap) {
            listPatientInfor.add(PatientInformationModel.fromJson(element));
          }
        }
      }
      if (isGetTo == true) {
        Get.toNamed(Routes.MEDICATION_SCHEDULE);
      }
    } catch (e) {
      Get.toNamed(Routes.MEDICATION_SCHEDULE);
      //ProgressDialog.showDialogNotification(context, content: 'Phát sinh lỗi: $e');
      Get.log('getList error: $e');
    }
  }
}
