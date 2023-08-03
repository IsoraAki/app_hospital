import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/command/views/command_view.dart';
import 'package:my_app_hospital/app/network/data/model/diagnostic_model.dart';
import 'package:my_app_hospital/app/network/data/model/infor_time_data_model.dart';
import 'package:my_app_hospital/app/network/data/model/thoi_gian_cham_soc_model.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';
import 'package:my_app_hospital/app/network/repositories/app_repository.dart';
import 'package:my_app_hospital/app_state.dart';

import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/date_formatter.dart';

class CommandController extends GetxController {
  TextEditingController searchController = TextEditingController();

  AppRepository appRepository = AppRepository();

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
  var pccsController = TextEditingController().obs;

  var dropDownValue = 'Tất cả'.obs;
  var lv = 'Tất cả'.obs;
  var timeDate = ThoiGianChamSocModel().obs;
  var inforTimeDate = InforTimeDateModel().obs;

  var listPatientInfor = [].obs;
  var sarchlistPatientInfor = [].obs;

  var tenphongban = ''.obs;
  var maphongban = ''.obs;

  var isLoad = false.obs;
  var isError = false;
  var isInsert = false.obs;
  var isGhiChuBS = 0.obs;
  var isSHBatThuong = 0.obs;

  var listThoiGianChamSoc = [].obs;
  var listDiagnostic = [].obs;
  var diagnosticCurrent = DiagnosticModel().obs;

  var colorMach = AppColors.textColor.obs;
  var colorNhietDo = AppColors.textColor.obs;
  var colorHuyetAp = AppColors.textColor.obs;

  var checkboxValue1 = true.obs;
  var checkboxValue2 = false.obs;
  var checkboxValue3 = false.obs;
  var checkboxValue4 = false.obs;

  String benhNhanId = '';

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

  void updateTimeDate(BuildContext context, ThoiGianChamSocModel timeDate) {
    this.timeDate.value = timeDate;
    getInforTimeDate(context, this.timeDate.value.chamsocId.toString());
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
      getInforTimeDate(context, timeDate.chamsocId.toString());
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

  Future<void> getList(BuildContext context, String PCCS, int isGhiChuBS, int isSHBatThuong, {bool? isGetTo, bool? isYLCS = true}) async {
    try {
      isLoad.value = true;
      listPatientInfor.value = [];
      final MyResponse? myResponse = await appRepository
          .listPatient(maphongban: maphongban.value, PCCS: PCCS, isGhiChuBS: isGhiChuBS, isSHBatThuong: isSHBatThuong)
          .timeout(const Duration(seconds: 60));

      if (myResponse != null) {
        if (myResponse.code == "SUCCESS") {
          if (myResponse.data != null) {
            listPatientInfor.value = [];
            listPatientInfor.value = myResponse.data!;
          }
        }
      }
      if (isGetTo == true) {
        Get.to(CommandView(isYLCS: isYLCS));
        //Get.toNamed(Routes.COMMAND);
      }
      isLoad.value = false;
    } catch (e) {
      Get.to(CommandView(isYLCS: isYLCS));
      //Get.toNamed(Routes.COMMAND);
      //ProgressDialog.showDialogNotification(context, content: 'Phát sinh lỗi: $e');
      isLoad.value = false;
      Get.log('getList error: $e');
    }
  }

  Future<void> getCDDD() async {
    try {
      isLoad.value = true;
      final MyResponse? myResponse = await appRepository.cddd().timeout(const Duration(seconds: 60));

      if (myResponse != null) {
        if (myResponse.code == "SUCCESS") {
          if (myResponse.data != null) {
            listDiagnostic.value = [];
            listDiagnostic.value = myResponse.data!;
          }
        }
      }

      isLoad.value = false;
    } catch (e) {
      isLoad.value = false;
      Get.log('getCDD error: $e');
    }
  }

  Future<void> getTimeDate(BuildContext context, String benhNhanId) async {
    try {
      isError = false;
      //var res = await SqlConn.readData("exec APPMBL_getTimePatientCare $benhNhanId");
      final MyResponse? res = await appRepository.getTimeDate(benhnhan_id: benhNhanId).timeout(const Duration(seconds: 60));

      print(res.toString());
      if (res != null && res.code == "SUCCESS") {
        if (res.data != null) {
          this.benhNhanId = benhNhanId;
          listThoiGianChamSoc.value = [];
          listThoiGianChamSoc.value = res.data!;
          // final valueMap = json.decode(res.toString().trim());
          // if (valueMap != null) {
          //   for (var element in valueMap) {
          //     listThoiGianChamSoc.add(ThoiGianChamSocModel.fromJson(element));
          //   }
          // }
          timeDate.value = listThoiGianChamSoc.first;
          // ignore: use_build_context_synchronously
          await getInforTimeDate(context, timeDate.value.chamsocId.toString());
        }
      }
    } catch (e) {
      isError = true;
      ProgressDialog.showDialogNotification(context, content: 'Phát sinh lỗi: $e');
      Get.log('getTimeDate error: $e');
    }
  }

  Future<void> getInforTimeDate(BuildContext context, String chamsocId) async {
    try {
      isError = false;

      final MyResponse? myResponse = await appRepository.infoPatient(chamsoc_id: chamsocId).timeout(const Duration(seconds: 60));

      if (myResponse != null) {
        if (myResponse.code == "SUCCESS") {
          if (myResponse.data != null) {
            inforTimeDate.value = InforTimeDateModel();
            inforTimeDate.value = myResponse.data!.first;

            // final valueMap = json.decode(res.toString().trim().replaceAll('\n', '\\n'));
            // if (valueMap != null) {
            //   inforTimeDate.value = InforTimeDateModel.fromJson(valueMap[0]);
            // }
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
            pccsController.value.text = inforTimeDate.value.phancapchamsoc == null ? '' : inforTimeDate.value.phancapchamsoc.toString();
          }
        }
      }

      // var res = await SqlConn.readData("exec APPMBL_getInfoPatientCareFrom_ChamsocID $chamsocId");
      // Get.log(res.toString());
      // if (res != null) {
      //   inforTimeDate.value = InforTimeDateModel();
      //   final valueMap = json.decode(res.toString().trim().replaceAll('\n', '\\n'));
      //   if (valueMap != null) {
      //     inforTimeDate.value = InforTimeDateModel.fromJson(valueMap[0]);
      //   }
      //   machController.value.text = inforTimeDate.value.mach ?? '';
      //   nhietdoController.value.text = inforTimeDate.value.nhietdo ?? '';
      //   huyetapController.value.text = inforTimeDate.value.huyetap ?? '';
      //   chieucaoController.value.text = inforTimeDate.value.chieucao ?? '';
      //   cannangController.value.text = inforTimeDate.value.cannang ?? '';
      //   nhipthoController.value.text = inforTimeDate.value.nhiptho ?? '';

      //   dienbienController.value.text = inforTimeDate.value.dienbien ?? '';
      //   ylenhchamsocController.value.text = inforTimeDate.value.ylenhchamsoc ?? '';
      //   chandoandieuduongController.value.text = inforTimeDate.value.chandoandieuduong ?? '';

      //   luonggiaController.value.text = inforTimeDate.value.luonggia ?? '';
      //   ghichuController.value.text = inforTimeDate.value.ghichu ?? '';
      //   chedodinhduongController.value.text = inforTimeDate.value.chandoandieuduong ?? '';
      //   muctieudieuduongController.value.text = inforTimeDate.value.muctieudieuduong ?? '';
      //   pccsController.value.text = inforTimeDate.value.phancapchamsoc == null ? '' : inforTimeDate.value.phancapchamsoc.toString();
      // }
    } catch (e) {
      isError = true;
      ProgressDialog.showDialogNotification(context, content: 'Phát sinh lỗi: $e');
      Get.log('getInforTimeDate error: $e');
    }
  }

  void addYL() {
    isInsert.value = true;
    timeDate.value = ThoiGianChamSocModel(thoigianchamsoc: DateTime.now().dateMonyhDayTimeViFormatted());
    machController.value.text = '';
    nhietdoController.value.text = '';
    huyetapController.value.text = '';
    chieucaoController.value.text = '';
    cannangController.value.text = '';
    nhipthoController.value.text = '';

    dienbienController.value.text = '';
    ylenhchamsocController.value.text = '';
    chandoandieuduongController.value.text = '';
    canthiepController.value.text = '';
    luonggiaController.value.text = '';
    ghichuController.value.text = '';
    chedodinhduongController.value.text = '';
    muctieudieuduongController.value.text = '';
    pccsController.value.text = '';
  }

  Future<void> saveYL(BuildContext context) async {
    try {
      ProgressDialog.showDialogNotification(context, content: 'Xác nhận lưu y lệnh', isCanel: true, onPressed: () async {
        if (isInsert.value) {
          Navigator.of(context).pop();

          // await SqlConn.readData(
          //     "Exec APPMBL_InsertNewPatientCare @${inforTimeDate.value.benhanId ?? ''}, @${timeDate.value.thoigianchamsoc}, @${AppState.instance.settingBox.read(SettingType.usercode.toString())}, @${machController.value.text}, @${nhietdoController.value.text}, @${huyetapController.value.text}, @${cannangController.value.text}, @${nhipthoController.value.text}, @${chieucaoController.value.text}, @${dienbienController.value.text}, @${canthiepController.value.text}, @${chandoandieuduongController.value.text}, @${luonggiaController.value.text}, @${ghichuController.value.text}, @${pccsController.value.text}, @${ylenhchamsocController.value.text}, @${inforTimeDate.value.chamsocId ?? ''}, @${inforTimeDate.value.dieuduong ?? ''}, @${muctieudieuduongController.value.text}");

          ProgressDialog.show(context);
          final MyResponse? myResponse = await appRepository
              .addYL(
                BENHAN_ID: inforTimeDate.value.benhanId,
                THOIGIANTHUCHIEN: timeDate.value.thoigianchamsoc,
                MACH: machController.value.text,
                USERCODE: AppState.instance.settingBox.read(SettingType.usercode.toString()),
                NHIET: nhietdoController.value.text,
                HUYETAP: huyetapController.value.text,
                CANNANG: cannangController.value.text,
                NHIPTHO: nhipthoController.value.text,
                CHIEUCAO: chieucaoController.value.text,
                TINHTRANGBN: dienbienController.value.text,
                CANTHIEPDD: canthiepController.value.text.toString().trim().replaceAll('\n', '\\n'),
                CHANDOANDD: chandoandieuduongController.value.text,
                LUONGGIA: luonggiaController.value.text,
                LOIDAN: ghichuController.value.text,
                PCCS: pccsController.value.text,
                YLENHDD: ylenhchamsocController.value.text,
                MACHAMSOC: '',
                TENCHAMSOC: AppState.instance.settingBox.read(SettingType.nameUser.toString()),
                MUCTIEUDD: muctieudieuduongController.value.text,
              )
              .timeout(const Duration(seconds: 60));
          // ignore: use_build_context_synchronously
          ProgressDialog.hide(context);
          if (myResponse?.code == "SUCCESS") {
            // ignore: use_build_context_synchronously
            isInsert.value = false;
            // ignore: use_build_context_synchronously
            ProgressDialog.showDialogNotification(context, content: 'Thêm y lệnh thành công', onPressed: () {
              ProgressDialog.show(context);
              getTimeDate(context, benhNhanId);
              ProgressDialog.hide(context);
              Get.back();
            });
          } else {
            // ignore: use_build_context_synchronously
            ProgressDialog.showDialogNotification(context, content: 'Thêm y lệnh thất bại');
          }
        } else if (inforTimeDate.value.nguoithuchienCode == AppState.instance.settingBox.read(SettingType.usercode.toString())) {
          Navigator.of(context).pop();
          // ProgressDialog.show(context);
          // await SqlConn.readData(
          //     "Exec APPMBL_UpdatePatientCareBy_ChamsocID @${timeDate.value.chamsocId ?? ''}, @${timeDate.value.thoigianchamsoc}, @${AppState.instance.settingBox.read(SettingType.usercode.toString())}, @${machController.value.text}, @${nhietdoController.value.text}, @${huyetapController.value.text}, @${cannangController.value.text}, @${nhipthoController.value.text}, @${chieucaoController.value.text}, @${dienbienController.value.text}, @${canthiepController.value.text}, @${chandoandieuduongController.value.text}, @${luonggiaController.value.text}, @${ghichuController.value.text}, @${pccsController.value.text}, @${ylenhchamsocController.value.text}, @${inforTimeDate.value.chamsocId ?? ''}, @${inforTimeDate.value.dieuduong ?? ''}, @${muctieudieuduongController.value.text}");
          // ProgressDialog.hide(context);
          ProgressDialog.show(context);
          final MyResponse? myResponse = await appRepository
              .editYL(
                chamsoc_id: timeDate.value.chamsocId,
                THOIGIANTHUCHIEN: timeDate.value.thoigianchamsoc,
                MACH: machController.value.text,
                USERCODE: AppState.instance.settingBox.read(SettingType.usercode.toString()),
                NHIET: nhietdoController.value.text,
                HUYETAP: huyetapController.value.text,
                CANNANG: cannangController.value.text,
                NHIPTHO: nhipthoController.value.text,
                CHIEUCAO: chieucaoController.value.text,
                TINHTRANGBN: dienbienController.value.text,
                CANTHIEPDD: canthiepController.value.text.toString().trim().replaceAll('\n', '\\n'),
                CHANDOANDD: chandoandieuduongController.value.text,
                LUONGGIA: luonggiaController.value.text,
                LOIDAN: ghichuController.value.text,
                PCCS: pccsController.value.text,
                YLENHDD: ylenhchamsocController.value.text,
                MACHAMSOC: inforTimeDate.value.chamsocId.toString(),
                TENCHAMSOC: inforTimeDate.value.dieuduong ?? '',
                MUCTIEUDD: muctieudieuduongController.value.text,
              )
              .timeout(const Duration(seconds: 60));
          ProgressDialog.hide(context);
          if (myResponse?.code == "SUCCESS") {
            // ignore: use_build_context_synchronously
            ProgressDialog.showDialogNotification(context, content: 'Sửa lệnh thành công', onPressed: () {
              ProgressDialog.show(context);
              getTimeDate(context, benhNhanId);
              ProgressDialog.hide(context);
              Get.back();
            });
          } else {
            // ignore: use_build_context_synchronously
            ProgressDialog.showDialogNotification(context, content: 'Sửa y lệnh thất bại');
          }
        } else {
          Navigator.of(context).pop();
          ProgressDialog.showDialogNotification(context, content: 'Chỉ có "${inforTimeDate.value.dieuduong}" mới có thể\nLƯU y lệnh chăm sóc này');
        }
      });
    } catch (e) {
      ProgressDialog.showDialogNotification(context, content: 'Phát sinh lỗi: $e');
      Get.log('saveYL error: $e');
    }
  }

  Future<void> deletaYL(BuildContext context) async {
    try {
      if (inforTimeDate.value.nguoithuchienCode == AppState.instance.settingBox.read(SettingType.usercode.toString())) {
        ProgressDialog.showDialogNotification(context, content: 'Xác nhận xóa Y lệnh', isCanel: true, onPressed: () async {
          Navigator.of(context).pop();

          if (timeDate.value.chamsocId != null) {
            //await SqlConn.readData("Exec APPMBL_deleteInfoPatientCareBy_ChamsocID @${timeDate.value.chamsocId ?? ''}");
            ProgressDialog.show(context);
            final MyResponse? myResponse =
                await appRepository.deletaYL(chamsoc_id: timeDate.value.chamsocId.toString()).timeout(const Duration(seconds: 60));
            ProgressDialog.hide(context);
            if (myResponse?.code == "SUCCESS") {
              // ignore: use_build_context_synchronously
              ProgressDialog.showDialogNotification(context, content: 'Xóa y lệnh thành công', onPressed: () {
                ProgressDialog.show(context);
                getTimeDate(context, benhNhanId);
                ProgressDialog.hide(context);
                Get.back();
              });
            } else {
              // ignore: use_build_context_synchronously
              ProgressDialog.showDialogNotification(context, content: 'Xóa y lệnh thất bại');
            }
          }
        });
      } else {
        ProgressDialog.showDialogNotification(context, content: 'Chỉ có "${inforTimeDate.value.dieuduong}" mới có thể\nXÓA y lệnh chăm sóc này');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      ProgressDialog.showDialogNotification(context, content: 'Xóa y lệnh thất bại\nLỗi: $e');
      Get.log('deletaYL error: $e');
    }
  }
}
