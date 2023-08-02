import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/command/views/command_details_view.dart';
import 'package:my_app_hospital/app/modules/widget/custom_bottom_sheet.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/process_dialog.dart';
import 'package:my_app_hospital/app/modules/widget/sick_people_cell.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/app_fonts.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../controllers/command_controller.dart';

class CommandView extends StatefulWidget {
  const CommandView({super.key});

  @override
  State<CommandView> createState() => _CommandViewState();
}

class _CommandViewState extends State<CommandView> {
  final controller = Get.find<CommandController>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Y lệnh chăm sóc'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                CustomBottomSheet.showModalNotFullScreen(
                    context,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Bộ lọc",
                            maxLines: 3,
                            style: textTheme.titleSmall,
                          ),
                          Obx(() => Material(
                                color: Colors.transparent,
                                child: CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: Colors.blue[400],
                                  checkColor: Colors.white,
                                  title: const Text(
                                    'Lọc sinh hiệu bất thường',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  value: controller.isSHBatThuong.value == 1,
                                  onChanged: (bool? value) {
                                    controller.isSHBatThuong.value = value == true ? 1 : 0;
                                    controller.searchController.clear();
                                    controller.getList(context, controller.dropDownValue.replaceAll('Cấp ', ''), controller.isGhiChuBS.value,
                                        controller.isSHBatThuong.value);
                                  },
                                ),
                              )),
                          Obx(() => Material(
                                color: Colors.transparent,
                                child: CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: Colors.blue[400],
                                  checkColor: Colors.white,
                                  title: const Text(
                                    'Lọc ghi chú BS',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  value: controller.isGhiChuBS.value == 1,
                                  onChanged: (bool? value) {
                                    controller.isGhiChuBS.value = value == true ? 1 : 0;
                                    controller.searchController.clear();
                                    controller.getList(context, controller.dropDownValue.replaceAll('Cấp ', ''), controller.isGhiChuBS.value,
                                        controller.isSHBatThuong.value);
                                  },
                                ),
                              )),
                        ],
                      ),
                    ));
              },
              icon: Icon(Icons.filter_alt))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              controller.tenphongban.value,
              maxLines: 3,
              style: textTheme.titleSmall,
            ),
            SizedBox(
              height: size_8_h,
            ),
            Obx(() => Text(
                  "Tổng BN: ${controller.listPatientInfor.length}",
                  maxLines: 3,
                  style: textTheme.titleSmall,
                )),
            SizedBox(
              height: size_8_h,
            ),
            StickyHeader(
              header: Container(
                color: AppColors.background,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.searchController,
                        typeInput: TypeInput.text,
                        lableText: 'Tìm bệnh nhân',
                        hideText: 'Nhập thông tin BN',
                        prefixIcon: const Icon(Icons.search),
                        //validator: (value) => Validator.validateEmail(value),
                        onChanged: (value) {
                          controller.onSearchTextChanged(value);
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    _buildLV(context),
                  ],
                ),
              ),
              content: Obx(
                () => controller.searchController.text.isNotEmpty
                    ? controller.sarchlistPatientInfor.isNotEmpty
                        ? Column(
                            children: [
                              ...controller.sarchlistPatientInfor.map(
                                (e) => sickPeopleCell(
                                  context,
                                  () async {
                                    ProgressDialog.show(context);
                                    controller.resetData();
                                    //await controller.getTimeDate(context, e.bENHANID.toString());
                                    ProgressDialog.hide(context);
                                    if (controller.isError == false) {
                                      Get.to(CommandDetails(e));
                                    }
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
                          )
                        : SizedBox(
                            height: Get.height / 2,
                            child: Center(
                              child: Text(
                                "Không có dữ liệu",
                                style: textTheme.bodyLarge!.copyWith(color: AppColors.hintText),
                              ),
                            ),
                          )
                    : controller.listPatientInfor.isNotEmpty
                        ? Column(
                            children: [
                              ...controller.listPatientInfor.map(
                                (e) => sickPeopleCell(
                                  context,
                                  () async {
                                    ProgressDialog.show(context);
                                    controller.resetData();
                                    //await controller.getTimeDate(context, e.bENHANID.toString());
                                    ProgressDialog.hide(context);
                                    if (controller.isError == false) {
                                      Get.to(CommandDetails(e));
                                    }
                                  },
                                  'http://192.168.1.178:1015/Data/48015/Media/${e.mAYTE}/${e.fILENAME}',
                                  e.sOBENHAN.toString(),
                                  e.tENBENHNHAN ?? '...',
                                  e.nAMSINH.toString(),
                                  e.dOITUONG,
                                  e.dIACHI,
                                  e.gHICHUBS ?? 'Không có ghi chú BS trong ngày',
                                  e.bSDIEUTRI ?? '...',
                                  e.pCCS.toString(),
                                  e.sEX,
                                ),
                              )
                            ],
                          )
                        : SizedBox(
                            height: Get.height / 2,
                            child: Center(
                              child: Text(
                                "Không có dữ liệu",
                                style: textTheme.bodyLarge!.copyWith(color: AppColors.hintText),
                              ),
                            ),
                          ),
              ),
            )

            // SizedBox(
            //   height: size_16_h,
            // ),
          ]),
        ),
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
                    maxLines: 1,
                    style: TextStyle(fontSize: text_14, fontWeight: FontWeight.bold, color: AppColors.white, fontFamily: AppFonts.baiJamjuree)),
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
                  controller.searchController.clear();
                  controller.updateData(dropDownValue: val, lvValue: val);
                  if (val != null) {
                    controller.getList(
                        context, controller.dropDownValue.replaceAll('Cấp ', ''), controller.isGhiChuBS.value, controller.isSHBatThuong.value);
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
