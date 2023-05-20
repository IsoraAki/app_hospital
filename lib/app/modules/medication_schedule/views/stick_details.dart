import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/medication_schedule_controller.dart';

class StickDetails extends GetView<MedicationScheduleController> {
  const StickDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác nhận phát thuốc'),
        centerTitle: true,
      ),
      body: Column(),
    );
  }
}
