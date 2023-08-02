import 'dart:async';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/network/data/model/office_model.dart';

import 'package:my_app_hospital/app/network/data/model/staff_infor_model.dart';
import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';
import 'package:my_app_hospital/app/network/repositories/app_repository.dart';

class HomeController extends GetxController {
  AppRepository appRepository = AppRepository();
  var dropDownValue = OfficeModer().obs;
  //var lv = 'Chọn phòng ban'.obs;
  var listOffice = [].obs;
  final inforUser = StaffInforModel().obs;
  var listPatientInfor = [].obs;

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

  void updateData(OfficeModer dropDownValue) {
    this.dropDownValue.value = dropDownValue;
    //lv.value = lvValue;
  }

  Future<void> getList(String PCCS, int isGhiChuBS, int isSHBatThuong) async {
    try {
      final MyResponse? myResponse = await appRepository
          .listPatient(maphongban: dropDownValue.value.rESOURCENAME, PCCS: PCCS, isGhiChuBS: isGhiChuBS, isSHBatThuong: isSHBatThuong)
          .timeout(const Duration(seconds: 60));

      if (myResponse != null) {
        if (myResponse.code == "SUCCESS") {
          if (myResponse.data != null) {
            listPatientInfor.value = [];
            listPatientInfor.value = myResponse.data!;
          }
        }
      }
    } catch (e) {
      Get.log('getList error: $e');
    }
  }

  Future<void> getOffice() async {
    try {
      final MyResponse? myResponse = await appRepository.department().timeout(const Duration(seconds: 60));

      if (myResponse != null) {
        if (myResponse.code == "SUCCESS") {
          if (myResponse.data != null) {
            listOffice.value = [];
            listOffice.value = myResponse.data!;
          }
        }
      }
    } on TimeoutException {
      // ignore: use_build_context_synchronously
    } catch (e) {
      // ignore: use_build_context_synchronously
      Get.log(e.toString());
    }
  }
}
