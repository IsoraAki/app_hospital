import 'package:flutter/material.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/theme.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Image.asset(
              'assets/images/bvtamthandn.png',
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            title: const Text('Trang chủ'),
            leading: Icon(
              Icons.home,
              color: AppColors.white,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: separatorBuilder,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: AppColors.white,
            ),
            title: const Text('Thông tin cá nhân'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AppColors.white,
            ),
            title: const Text('Cài đặt'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: AppColors.white,
            ),
            title: const Text('Đăng xuất'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: separatorBuilder,
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: AppColors.white,
            ),
            title: const Text('Chia sẻ'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.note_alt_outlined,
              color: AppColors.white,
            ),
            title: const Text('Đánh giá'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: AppColors.white,
            ),
            title: const Text('Thông tin ứng dụng'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}