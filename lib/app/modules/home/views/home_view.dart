import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/app/routes/app_pages.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/app_fonts.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
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
                Image.asset(
                  'assets/images/iconapp.png',
                  width: 100,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMenu('assets/images/iconapp.png', 'Khám sức khỏe', () {}),
                buildMenu('assets/images/iconapp.png', 'Đánh giá CBNV', () {}),
                buildMenu('assets/images/iconapp.png', 'Y lệnh chăm sóc', () {
                  Get.toNamed(Routes.COMMAND);
                }),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMenu('assets/images/iconapp.png', 'XN dùng thuốc', () {}),
                buildMenu('assets/images/iconapp.png', 'Lịch dùng thuốc', () {
                  Get.toNamed(Routes.MEDICATION_SCHEDULE);
                }),
                buildMenu('assets/images/iconapp.png', 'Trò chuyện', () {}),
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
                  color: AppColors.bgBottomAppBar,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.0, color: Colors.white30),
                  boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/iconapp.png',
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
                        color: Colors.white,
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
          color: AppColors.bgBottomAppBar,
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
            Image.asset(
              img,
              width: 40,
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
                color: Colors.white,
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
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.7, color: AppColors.hintText),
              //boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
            ),
            child: Obx(
              () => DropdownButton(
                hint: Text(controller.dropDownValue.value,
                    maxLines: 1, style: TextStyle(fontSize: text_14, fontWeight: FontWeight.bold, color: AppColors.white, fontFamily: AppFonts.baiJamjuree)),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                underline: Container(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black),
                items: controller.listOffice.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.tENPHONGBAN,
                      child: Text(val.tENPHONGBAN),
                    );
                  },
                ).toList(),
                onChanged: (String? val) {
                  controller.getOffice();
                  controller.updateData(dropDownValue: val, lvValue: val);
                },
              ),
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
