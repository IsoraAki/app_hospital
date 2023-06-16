import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/patient_information_model.dart';
import 'package:sql_conn/sql_conn.dart';

class MedicationScheduleController extends GetxController {
  //TODO: Implement MedicationScheduleController

  var dropDownValue = 'Tất cả'.obs;
  var lv = 'Tất cả'.obs;
  var listPatientInfor = [].obs;

  var tenphongban = ''.obs;
  var maphongban = ''.obs;

  var isGhiChuBS = 0.obs;
  var isSHBatThuong = 0.obs;

  var checkboxValue1 = true.obs;
  var checkboxValue2 = false.obs;
  var checkboxValue3 = false.obs;
  var checkboxValue4 = false.obs;

  @override
  void onInit() {
    getList(dropDownValue.value, 0, 0);
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
}
