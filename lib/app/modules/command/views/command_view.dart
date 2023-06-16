import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/command/views/command_details_view.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/app/modules/widget/sick_people_cell.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/app_fonts.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

import '../controllers/command_controller.dart';

class CommandView extends GetView<CommandController> {
  CommandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Y lệnh chăm sóc'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            controller.tenphongban.value,
            maxLines: 3,
            style: textTheme.titleSmall,
          ),
          SizedBox(
            height: size_8_h,
          ),
          Text(
            "Tổng BN: ${controller.listPatientInfor.length}",
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
              child: Obx(() => Column(
                    children: [
                      ...controller.listPatientInfor.map(
                        (e) => sickPeopleCell(
                          context,
                          () {
                            Get.to(CommandDetails());
                          },
                          'http://192.168.1.178:1015/Data/48015/Media/${e.mAYTE}/${e.fILENAME}',
                          e.sOBENHAN.toString(),
                          e.tENBENHNHAN ?? '...',
                          e.nAMSINH.toString(),
                          '...',
                          e.dIACHI,
                          e.gHICHUBS ?? 'Không có ghi chú BS trong ngày',
                          e.bSDIEUTRI ?? '...',
                          e.pCCS.toString(),
                          e.sEX,
                        ),
                      )
                    ],
                  )),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildLV(BuildContext context) {
    List<String> _data = [
      'Tất cả',
      'Cấp 1',
      'Cấp 2',
      'Cấp 3',
      'Chưa nhập',
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
                  if (val != null) {
                    controller.getList(val.replaceAll('Cấp ', ''), 0, 0);
                  }
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
