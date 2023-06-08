import 'package:get/get.dart';

import '../modules/bottom_bar/bindings/bottom_bar_binding.dart';
import '../modules/bottom_bar/views/bottom_bar_view.dart';
import '../modules/command/bindings/command_binding.dart';
import '../modules/command/views/command_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/medication_schedule/bindings/medication_schedule_binding.dart';
import '../modules/medication_schedule/views/medication_schedule_view.dart';
import '../modules/note/bindings/note_binding.dart';
import '../modules/note/views/note_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.NOTE,
      page: () => const NoteView(),
      binding: NoteBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.MEDICATION_SCHEDULE,
      page: () => MedicationScheduleView(),
      binding: MedicationScheduleBinding(),
    ),
    GetPage(
      name: _Paths.COMMAND,
      page: () => CommandView(),
      binding: CommandBinding(),
    ),
  ];
}
