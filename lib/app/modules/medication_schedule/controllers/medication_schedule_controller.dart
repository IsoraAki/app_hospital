import 'package:get/get.dart';

class MedicationScheduleController extends GetxController {
  //TODO: Implement MedicationScheduleController

  var dropDownValue = 'Tất cả'.obs;
  var lv = 'Tất cả'.obs;

  var checkboxValue1 = true.obs;
  var checkboxValue2 = false.obs;
  var checkboxValue3 = false.obs;
  var checkboxValue4 = false.obs;
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

  void updateData({String? dropDownValue, String? lvValue}) {
    this.dropDownValue.value = dropDownValue ?? this.dropDownValue.value;
    lv.value = lvValue ?? lv.value;
  }
}
