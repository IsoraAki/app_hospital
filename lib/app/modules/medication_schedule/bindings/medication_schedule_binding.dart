import 'package:get/get.dart';

import '../controllers/medication_schedule_controller.dart';

class MedicationScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicationScheduleController>(
      () => MedicationScheduleController(),
    );
  }
}
