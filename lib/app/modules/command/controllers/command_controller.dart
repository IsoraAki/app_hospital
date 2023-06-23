import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/diagnostic_model.dart';
import 'package:my_app_hospital/app/data/infor_time_data_model.dart';
import 'package:my_app_hospital/app/data/patient_information_model.dart';
import 'package:my_app_hospital/app/data/thoi_gian_cham_soc_model.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/routes/app_pages.dart';
import 'package:my_app_hospital/app_state.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/date_formatter.dart';
import 'package:sql_conn/sql_conn.dart';

class CommandController extends GetxController {
  TextEditingController searchController = TextEditingController();

  var machController = TextEditingController().obs;
  var nhietdoController = TextEditingController().obs;
  var huyetapController = TextEditingController().obs;
  var chieucaoController = TextEditingController().obs;
  var cannangController = TextEditingController().obs;
  var nhipthoController = TextEditingController().obs;

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
  var isInsert = false.obs;
  var isGhiChuBS = 0.obs;
  var isSHBatThuong = 0.obs;

  var listThoiGianChamSoc = [].obs;
  var listDiagnostic = [].obs;
  var diagnosticCurrent = DiagnosticModel().obs;

  var colorMach = AppColors.textColor.obs;
  var colorNhietDo = AppColors.textColor.obs;
  var colorHuyetAp = AppColors.textColor.obs;

  @override
  void onInit() {
    searchController.clear;
    //getList(dropDownValue.value, 0, 0);
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
    isInsert.value = false;
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
    diagnosticCurrent.value = value;
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

  Future<void> getList(BuildContext context, String PCCS, int isGhiChuBS, int isSHBatThuong, {bool? isGetTo}) async {
    try {
      isLoad.value = true;
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
        Get.toNamed(Routes.COMMAND);
      }
      isLoad.value = false;
    } catch (e) {
      ProgressDialog.showDialogNotification(context, content: 'Phát sinh lỗi: $e');
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
        machController.value.text = inforTimeDate.value.mach ?? '';
        nhietdoController.value.text = inforTimeDate.value.nhietdo ?? '';
        huyetapController.value.text = inforTimeDate.value.huyetap ?? '';
        chieucaoController.value.text = inforTimeDate.value.chieucao ?? '';
        cannangController.value.text = inforTimeDate.value.cannang ?? '';
        nhipthoController.value.text = inforTimeDate.value.nhiptho ?? '';

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

  void addYL() {
    isInsert.value = true;
    timeDate.value = ThoiGianChamSocModel(thoigianchamsoc: DateTime.now().dateMonyhDayTimeViFormatted());
    machController.value.text;
    nhietdoController.value.clear();
    huyetapController.value.clear();
    chieucaoController.value.clear();
    cannangController.value.clear();
    nhipthoController.value.clear();

    dienbienController.value.clear();
    ylenhchamsocController.value.clear();
    chandoandieuduongController.value.clear();
    canthiepController.value.clear();
    luonggiaController.value.clear();
    ghichuController.value.clear();
    chedodinhduongController.value.clear();
    muctieudieuduongController.value.clear();
  }

  Future<void> saveYL(BuildContext context) async {
    try {
      if (inforTimeDate.value.nguoithuchienCode == AppState.instance.settingBox.read(SettingType.usercode.toString())) {
        ProgressDialog.showDialogNotification(context, content: 'Xác nhận lưu y lệnh', isCanel: true, onPressed: () async {
          if (isInsert.value) {
            ProgressDialog.show(context);
            var res = await SqlConn.readData(
                "Exec APPMBL_InsertNewPatientCare @${inforTimeDate.value.benhanId}, @${timeDate.value.thoigianchamsoc}, @${AppState.instance.settingBox.read(SettingType.usercode.toString())}, @${machController.value.text}, @${nhietdoController.value.text}, @${huyetapController.value.text}, @${cannangController.value.text}, @${nhipthoController.value.text}, @${chieucaoController.value.text}, @${dienbienController.value.text}, ,@${canthiepController.value.text}, @${chandoandieuduongController.value.text}, @${luonggiaController.value.text}, @${ghichuController.value.text}, @${inforTimeDate.value.phancapchamsoc}, @${ylenhchamsocController.value.text},@${inforTimeDate.value.chamsocId}, @${inforTimeDate.value.dieuduong}, @${muctieudieuduongController.value.text}");
            isInsert.value = false;
            ProgressDialog.hide(context);
            Navigator.of(context).pop();
          } else {
            ProgressDialog.show(context);
            var res = await SqlConn.readData(
                "Exec APPMBL_UpdatePatientCareBy_ChamsocID @${timeDate.value.chamsocId.toString()}, @${timeDate.value.thoigianchamsoc}, @${AppState.instance.settingBox.read(SettingType.usercode.toString())}, @${machController.value.text}, @${nhietdoController.value.text}, @${huyetapController.value.text}, @${cannangController.value.text}, @${nhipthoController.value.text}, @${chieucaoController.value.text}, @${dienbienController.value.text}, ,@${canthiepController.value.text}, @${chandoandieuduongController.value.text}, @${luonggiaController.value.text}, @${ghichuController.value.text}, @${inforTimeDate.value.phancapchamsoc}, @${ylenhchamsocController.value.text},@${inforTimeDate.value.chamsocId}, @${inforTimeDate.value.dieuduong}, @${muctieudieuduongController.value.text}");
            ProgressDialog.hide(context);
            Navigator.of(context).pop();
          }
        });
      } else {
        ProgressDialog.showDialogNotification(context, content: 'Chỉ có "${inforTimeDate.value.dieuduong}" mới có thể\nLƯU y lệnh chăm sóc này');
      }
    } catch (e) {
      Get.log('saveYL error: $e');
    }
  }

  Future<void> deletaYL(BuildContext context) async {
    try {
      if (inforTimeDate.value.nguoithuchienCode == AppState.instance.settingBox.read(SettingType.usercode.toString())) {
        ProgressDialog.showDialogNotification(context, content: 'Xác nhận xóa Y lệnh', isCanel: true, onPressed: () async {
          ProgressDialog.show(context);
          await SqlConn.readData("Exec APPMBL_deleteInfoPatientCareBy_ChamsocID @${timeDate.value.chamsocId.toString()}");
          ProgressDialog.hide(context);
          Navigator.of(context).pop();
        });
      } else {
        ProgressDialog.showDialogNotification(context, content: 'Chỉ có "${inforTimeDate.value.dieuduong}" mới có thể\nXÓA y lệnh chăm sóc này');
      }
    } catch (e) {
      ProgressDialog.showDialogNotification(context, content: 'Xóa y lệnh thất bại\nLỗi: $e');
      Get.log('deletaYL error: $e');
    }
    ProgressDialog.hide(context);
  }
}
