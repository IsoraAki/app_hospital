import 'package:get/get.dart';

import '../controllers/command_controller.dart';

class CommandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommandController>(
      () => CommandController(),
    );
  }
}
