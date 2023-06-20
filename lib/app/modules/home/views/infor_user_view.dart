import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/data/staff_infor_model.dart';
import 'package:my_app_hospital/app/modules/home/controllers/home_controller.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';

class InforUserView extends StatelessWidget {
  final StaffInforModel inforUserModer;
  InforUserView({super.key, required this.inforUserModer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'http://192.168.1.178:1015/Data/48015/Template/AnhNhanVien/${inforUserModer.manhanvien}.jpg',
                  fit: BoxFit.cover,
                  width: 100.sp,
                  errorBuilder: (context, error, stackTrace) {
                    return inforUserModer.gioitinh == 1
                        ? Image.asset(
                            'assets/images/icon_doctor_man.png',
                            width: 100.sp,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'assets/images/icon_doctor_woman.jpg',
                            width: 100.sp,
                            fit: BoxFit.contain,
                          );
                  },
                ),
              ),
              SizedBox(
                height: size_16_h,
              ),
              Text(
                inforUserModer.tennhanvien ?? '...',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: size_24_h,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.bgBottomAppBar,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.0, color: Colors.white30),
                  boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
                ),
                child: Column(
                  children: [
                    cellText(context, 'Mã nhân viên:', inforUserModer.manhanvien ?? '...'),
                    SizedBox(
                      height: size_16_h,
                    ),
                    cellText(context, 'Mã phòng ban:', inforUserModer.maphongban ?? '...'),
                    SizedBox(
                      height: size_16_h,
                    ),
                    cellText(context, 'Phòng ban:', inforUserModer.tenphongban ?? '...'),
                    SizedBox(
                      height: size_16_h,
                    ),
                    cellText(context, 'Giới tính:', inforUserModer.gioitinh == 1 ? 'Nam' : 'Nữ'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cellText(BuildContext context, String title, String bodySmall) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.hintText),
        ),
        Text(
          bodySmall,
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
      ],
    );
  }
}
