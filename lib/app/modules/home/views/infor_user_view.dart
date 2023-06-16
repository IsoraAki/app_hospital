import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/infor_user_model.dart';
import 'package:my_app_hospital/app/modules/home/controllers/home_controller.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';

class InforUserView extends StatelessWidget {
  final InforUserModer inforUserModer;
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
                  'http://192.168.1.178:1015/Data/48015/Template/AnhNhanVien/${inforUserModer.uSERID}.jpg',
                  fit: BoxFit.cover,
                  width: 100.sp,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.account_circle,
                      size: 100.sp,
                    );
                  },
                ),
              ),
              Text(
                inforUserModer.fULLNAME ?? '...',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Segoe UI',
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
                    cellText(context, 'Phòng ban:', inforUserModer.dEPARTMENTNAMEEXT ?? '...'),
                    SizedBox(
                      height: size_16_h,
                    ),
                    cellText(context, 'Ngày tạo:', inforUserModer.cREATEDDATE ?? '...'),
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
