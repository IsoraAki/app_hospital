import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app_hospital/app/data/diagnostic_model.dart';
import 'package:my_app_hospital/app/data/infor_time_data_model.dart';
import 'package:my_app_hospital/app/data/patient_information_model.dart';
import 'package:my_app_hospital/app/data/thoi_gian_cham_soc_model.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/routes/navigate_keys.dart';
import 'package:my_app_hospital/configs/date_formatter.dart';
import 'package:my_app_hospital/configs/theme/theme.dart';
import 'package:sql_conn/sql_conn.dart';

class CommandController extends GetxController {
  TextEditingController searchController = TextEditingController();

  var mach = '...'.obs;
  var nhietdo = '...'.obs;
  var huyetap = '...'.obs;
  var chieucao = '...'.obs;
  var cannang = '...'.obs;
  var nhiptho = '...'.obs;

  var dienbienController = TextEditingController().obs;
  var ylenhchamsocController = TextEditingController().obs;
  var chandoandieuduongController = TextEditingController().obs;
  var luonggiaController = TextEditingController().obs;
  var ghichuController = TextEditingController().obs;
  var chedodinhduongController = TextEditingController().obs;
  var muctieudieuduongController = TextEditingController().obs;
  var canthiepController = TextEditingController().obs;

  var dropDownValue = 'Tất cả'.obs;
  var lv = 'Tất cả'.obs;
  var timeDate = ThoiGianChamSocModel().obs;
  var inforTimeDate = InforTimeDateModel().obs;

  var listPatientInfor = [].obs;
  var sarchlistPatientInfor = [].obs;

  var tenphongban = ''.obs;
  var maphongban = ''.obs;

  var isLoad = false.obs;
  var isGhiChuBS = 0.obs;
  var isSHBatThuong = 0.obs;

  var listThoiGianChamSoc = [].obs;
  var listDiagnostic = [].obs;
  var diagnosticCurrent = DiagnosticModel().obs;

  @override
  void onInit() {
    searchController.clear;
    getList(dropDownValue.value, 0, 0);
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

  resetData() {
    chandoandieuduongController.value.clear();
    muctieudieuduongController.value.clear();
    canthiepController.value.clear();
    diagnosticCurrent = DiagnosticModel().obs;
  }

  void updateData({String? dropDownValue, String? lvValue}) {
    this.dropDownValue.value = dropDownValue ?? this.dropDownValue.value;
    lv.value = lvValue ?? lv.value;
  }

  void updateTimeDate(ThoiGianChamSocModel timeDate) {
    this.timeDate.value = timeDate;
    getInforTimeDate(this.timeDate.value.chamsocId.toString());
  }

  void selecTimeDate(BuildContext context, {DateTime? value}) {
    var timeDate = ThoiGianChamSocModel();
    var date = value?.dateMonyhDayTimeViFormatted();
    for (var element in listThoiGianChamSoc) {
      if (date == element.thoigianchamsoc) {
        timeDate = element;
        break;
      }
    }

    if (timeDate.chamsocId != null) {
      this.timeDate.value = timeDate;
      getInforTimeDate(timeDate.chamsocId.toString());
    } else {
      ProgressDialog.showDialogwWarning(context, content: 'Không có dữ liệu chăm sóc trong thời gian đã chọn');
    }
  }

  void updateCDDD(DiagnosticModel value) {
    this.diagnosticCurrent.value = value;
    chandoandieuduongController.value.text = value.tEN ?? '';
    muctieudieuduongController.value.text = value.mUCTIEU ?? '';
    canthiepController.value.text = value.cANTHIEP ?? '';
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

  Future<void> getList(String PCCS, int isGhiChuBS, int isSHBatThuong) async {
    try {
      isLoad.value = true;
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
      isLoad.value = false;
    } catch (e) {
      isLoad.value = false;
      Get.log('getList error: $e');
    }
  }

  Future<void> getCDDD() async {
    try {
      isLoad.value = true;
      var res = await SqlConn.readData("exec APPMBL_selectedCHANDOANDIEUDUONG");
      Get.log(res.toString().trim());
      if (res != null) {
        listDiagnostic.value = [];
        final valueMap = json.decode(res.toString().trim().replaceAll('\n', '\\n'));
        if (valueMap != null) {
          for (var element in valueMap) {
            listDiagnostic.add(DiagnosticModel.fromJson(element));
          }
        }
      }
      isLoad.value = false;
    } catch (e) {
      isLoad.value = false;
      Get.log('getCDD error: $e');
    }
  }

  Future<void> getTimeDate(String benhNhanId) async {
    try {
      var res = await SqlConn.readData("exec APPMBL_getTimePatientCare $benhNhanId");
      print(res.toString());
      if (res != null) {
        listThoiGianChamSoc.value = [];
        final valueMap = json.decode(res.toString().trim());
        if (valueMap != null) {
          for (var element in valueMap) {
            listThoiGianChamSoc.add(ThoiGianChamSocModel.fromJson(element));
          }
        }
        timeDate.value = listThoiGianChamSoc.first;
        await getInforTimeDate(timeDate.value.chamsocId.toString());
      }
    } catch (e) {
      Get.log('getList error: $e');
    }
  }

  Future<void> getInforTimeDate(String chamsocId) async {
    try {
      var res = await SqlConn.readData("exec APPMBL_getInfoPatientCareFrom_ChamsocID $chamsocId");
      Get.log(res.toString());
      if (res != null) {
        inforTimeDate.value = InforTimeDateModel();
        final valueMap = json.decode(res.toString().trim().replaceAll('\n', '\\n'));
        if (valueMap != null) {
          inforTimeDate.value = InforTimeDateModel.fromJson(valueMap[0]);
        }
        mach.value = inforTimeDate.value.mach ?? '...';
        nhietdo.value = inforTimeDate.value.nhietdo ?? '...';
        huyetap.value = inforTimeDate.value.huyetap ?? '...';
        chieucao.value = inforTimeDate.value.chieucao ?? '...';
        cannang.value = inforTimeDate.value.cannang ?? '...';
        nhiptho.value = inforTimeDate.value.nhiptho ?? '...';

        dienbienController.value.text = inforTimeDate.value.dienbien ?? '';
        ylenhchamsocController.value.text = inforTimeDate.value.ylenhchamsoc ?? '';
        chandoandieuduongController.value.text = inforTimeDate.value.chandoandieuduong ?? '';
        luonggiaController.value.text = inforTimeDate.value.luonggia ?? '';
        ghichuController.value.text = inforTimeDate.value.ghichu ?? '';
        chedodinhduongController.value.text = inforTimeDate.value.chandoandieuduong ?? '';
        muctieudieuduongController.value.text = inforTimeDate.value.muctieudieuduong ?? '';
      }
    } catch (e) {
      Get.log('getInforTimeDate error: $e');
    }
  }
}
