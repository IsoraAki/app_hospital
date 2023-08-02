import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/home/views/home_view.dart';
import 'package:my_app_hospital/app/modules/note/views/note_view.dart';
import 'package:my_app_hospital/app/modules/search/views/search_view.dart';
import 'package:my_app_hospital/app/modules/support/views/support_view.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/network/local/cache_helper.dart';
import 'package:my_app_hospital/configs/app_color.dart';

import '../controllers/bottom_bar_controller.dart';
import 'drawer_view.dart';

// ignore: must_be_immutable
class BottomBarView extends GetView<BottomBarController> {
  BottomBarView({Key? key}) : super(key: key);

  List<Widget> listWidget = [
    SupportView(),
    SearchView(),
    HomeView(),
    NoteView(),
    HomeView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bệnh viện tâm thần')),
      drawer: Drawer(
        child: DrawerView(),
      ),
      body: Obx(() => Container(child: listWidget[controller.index.value])),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: AppColors.blue.withOpacity(0.35),
        style: TabStyle.react,
        items: const [
          TabItem(icon: Icons.support_agent, title: 'Hỗ trợ'),
          TabItem(icon: Icons.search, title: 'Tìm kiếm'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.note_alt_outlined, title: 'Ghi chú'),
          TabItem(icon: Icons.power_settings_new, title: 'Thoát'),
        ],
        initialActiveIndex: 2,
        onTap: (int i) {
          if (i == 4) {
            ProgressDialog.showDialogNotification(context, content: 'Thoát ứng dụng', isCanel: true, onPressed: () {
              CacheHelper.removeData(key: 'token');
              SystemNavigator.pop();
            });
          } else {
            controller.index.value = i;
          }
        },
      ),
    );
  }
}
