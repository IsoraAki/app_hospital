import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum SettingType { isSave, user, password, inforUser, listOffice, usercode }

class AppState extends GetxController {
  static final AppState instance = AppState();
  final settingBox = GetStorage();
}
