import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/home/controllers/home_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
