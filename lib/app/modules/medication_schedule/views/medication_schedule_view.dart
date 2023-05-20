import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/medication_schedule/views/stick_details.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/app/modules/widget/sick_people_cell.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/app_fonts.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

import '../controllers/medication_schedule_controller.dart';

// ignore: must_be_immutable
class MedicationScheduleView extends GetView<MedicationScheduleController> {
  MedicationScheduleView({Key? key}) : super(key: key);
  final List<int> list = [1, 1, 1, 1, 1, 1, 1, 1];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch dùng thuốc'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Tổng BN: ${list.length}",
            maxLines: 3,
            style: textTheme.titleSmall,
          ),
          SizedBox(
            height: size_8_h,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: TextEditingController(),
                  typeInput: TypeInput.text,
                  lableText: 'Tìm bệnh nhân',
                  hideText: 'Nhập thông tin BN',
                  prefixIcon: const Icon(Icons.search),
                  //validator: (value) => Validator.validateEmail(value),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              _buildLV(context),
            ],
          ),
          // SizedBox(
          //   height: size_16_h,
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...list.map(
                    (e) => sickPeopleCell(
                      context,
                      () {
                        Get.to(StickDetails());
                      },
                      '',
                      '22.002.5',
                      'bệnh nhân',
                      '1986',
                      '22.000.000',
                      'Phường An khê, Thành phố Đà Nẵng',
                      'thoe dõi thường xuyên',
                      'Phạm Tú',
                      '1',
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildLV(BuildContext context) {
    List<String> _data = [
      'Cấp 1',
      'Cấp 2',
      'Cấp 3',
      'Cấp 4',
      'Chưa đăng nhập',
    ];
    return SizedBox(
      width: Get.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleInputBox(context, 'PCCS'),
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
                items: _data.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (String? val) {
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
