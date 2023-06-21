import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/office_model.dart';
import 'package:my_app_hospital/app/modules/command/controllers/command_controller.dart';
import 'package:my_app_hospital/app/modules/medication_schedule/controllers/medication_schedule_controller.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/routes/app_pages.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/app_fonts.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<HomeController>();
  final commandController = Get.find<CommandController>();
  final medicationScheduleController = Get.find<MedicationScheduleController>();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Expanded(
                //   child: CustomTextField(
                //     controller: TextEditingController(),
                //     typeInput: TypeInput.text,
                //     lableText: 'Khoa phòng làm việc',
                //     hideText: 'Nhập khoa phòng',
                //     prefixIcon: const Icon(Icons.search),
                //     //validator: (value) => Validator.validateEmail(value),
                //   ),
                // ),
                buildOffice(context),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'http://192.168.1.178:1015/Data/48015/Template/AnhNhanVien/${controller.inforUser.value.manhanvien}.jpg',
                        fit: BoxFit.cover,
                        width: 100.sp,
                        errorBuilder: (context, error, stackTrace) {
                          return controller.inforUser.value.gioitinh == 1
                              ? Image.asset(
                                  'assets/images/icon_doctor_man.png',
                                  width: 100.sp,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  'assets/images/icon_doctor_woman.png',
                                  width: 100.sp,
                                  fit: BoxFit.contain,
                                );
                        },
                      ),
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    Text(
                      controller.inforUser.value.tennhanvien ?? '...',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMenu('assets/svg/Icon-03.svg', 'Khám sức khỏe', () {}),
                buildMenu('assets/svg/Icon-14.svg', 'Đánh giá CBNV', () {}),
                buildMenu('assets/svg/Icon-24.svg', 'Y lệnh chăm sóc', () async {
                  commandController.maphongban.value = controller.dropDownValue.value.rESOURCENAME ?? '';
                  commandController.tenphongban.value = controller.dropDownValue.value.tENPHONGBAN ?? '';
                  //commandController.listPatientInfor == controller.listPatientInfor;
                  ProgressDialog.show(context);
                  await commandController.getCDDD();
                  await commandController.getList(context, 'Tất cả', 0, 0, isGetTo: true);
                  ProgressDialog.hide(context);
                }),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMenu('assets/svg/Icon-26.svg', 'XN dùng thuốc', () {}),
                buildMenu('assets/svg/Icon-13.svg', 'Lịch dùng thuốc', () async {
                  medicationScheduleController.maphongban.value = controller.dropDownValue.value.rESOURCENAME ?? '';
                  medicationScheduleController.tenphongban.value = controller.dropDownValue.value.tENPHONGBAN ?? '';
                  //commandController.listPatientInfor == controller.listPatientInfor;
                  ProgressDialog.show(context);
                  await medicationScheduleController.getList(context, 'Tất cả', 0, 0, isGetTo: true);
                  ProgressDialog.hide(context);
                }),
                buildMenu('assets/svg/Icon-07.svg', 'Trò chuyện', () {}),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bgBottomAppBarLight.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.0, color: Colors.white30),
                  boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/Icon-22.svg',
                      width: 40,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Tra cứu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu(String img, String title, Function() ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.bgBottomAppBarLight.withOpacity(0.35),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.0, color: Colors.white30),
          boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
        ),
        // decoration: BoxDecoration(
        //   color: Colors.blue,
        //   borderRadius: BorderRadius.circular(30),
        //   border: Border.all(width: 1.0, color: Colors.white30),
        //   boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
        // ),
        child: Column(
          children: [
            SvgPicture.asset(
              img,
              height: 40.0.sp,
              width: 40.0.sp,
              allowDrawingOutsideViewBox: true,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOffice(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleInputBox(context, 'Khoa phòng làm việc'),
          Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 0.5, bottom: 0.5),
            decoration: BoxDecoration(
              color: AppColors.bgBottomAppBarLight.withOpacity(0.35),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.7, color: AppColors.hintText),
              //boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
            ),
            child: DropdownButton(
              hint: Obx(
                () => Text(controller.dropDownValue.value.tENPHONGBAN ?? '...',
                    maxLines: 1, style: TextStyle(fontSize: text_14, fontWeight: FontWeight.bold, color: AppColors.black, fontFamily: AppFonts.baiJamjuree)),
              ),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.black),
              underline: Container(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black),
              items: controller.listOffice.map(
                (val) {
                  return DropdownMenuItem<OfficeModer>(
                    value: val,
                    child: Text(val.tENPHONGBAN),
                  );
                },
              ).toList(),
              onChanged: (OfficeModer? val) async {
                if (val != null) {
                  controller.updateData(val);
                  // controller.dropDownValue.value = val;
                  // for (var e in controller.listOffice) {
                  //   if (e.tENPHONGBAN == val) {
                  //     controller.tenphongban.value = e.tENPHONGBAN;
                  //     controller.maphongban.value = e.rESOURCENAME;
                  //     break;
                  //   }
                  // }
                }
                setState(() {});
                // ProgressDialog.show(context);
                // await controller.getList('Tất cả', 0, 0);
                // ProgressDialog.hide(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleInputBox(BuildContext context, String titleText, {String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 16),
            child: Text(
              titleText,
              style: Theme.of(context).textTheme.titleSmall,
            )),
        hintText != null
            ? Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  hintText,
                  style: Theme.of(context).textTheme.bodySmall,
                ))
            : SizedBox(),
      ],
    );
  }
}
