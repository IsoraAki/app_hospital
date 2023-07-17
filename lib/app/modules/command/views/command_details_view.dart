import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/data/patient_information_model.dart';
import 'package:my_app_hospital/app/data/thoi_gian_cham_soc_model.dart';
import 'package:my_app_hospital/app/modules/command/controllers/command_controller.dart';
import 'package:my_app_hospital/app/modules/command/views/cddd_view.dart';
import 'package:my_app_hospital/app/modules/widget/custom_bottom_sheet.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CommandDetails extends GetView<CommandController> {
  final PatientInformationModel patientInformationModel;
  const CommandDetails(this.patientInformationModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Y lệnh chăm sóc'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              sickPeople(
                context,
                'http://192.168.1.178:1015/Data/48015/Media/${patientInformationModel.mAYTE}/${patientInformationModel.fILENAME}',
                patientInformationModel.sOBENHAN.toString(),
                patientInformationModel.tENBENHNHAN ?? '...',
                patientInformationModel.nAMSINH.toString(),
                patientInformationModel.dOITUONG ?? '...',
                patientInformationModel.pCCS ?? '...',
                patientInformationModel.sEX ?? 1,
              ),
              SizedBox(
                height: size_8_h,
              ),
              Row(
                children: [
                  buildTimeDate(context),
                  IconButton(
                      onPressed: () async {
                        DateTime? dateTime = await showOmniDateTimePicker(
                          context: context,
                          theme: ThemeData(
                            brightness: Brightness.light,
                          ),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                          lastDate: DateTime.now().add(
                            const Duration(days: 3652),
                          ),
                          is24HourMode: true,
                          isShowSeconds: false,
                          minutesInterval: 1,
                          secondsInterval: 1,
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          constraints: const BoxConstraints(
                            maxWidth: 350,
                            maxHeight: 650,
                          ),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return FadeTransition(
                              opacity: anim1.drive(
                                Tween(
                                  begin: 0,
                                  end: 1,
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 200),
                          barrierDismissible: true,
                          selectableDayPredicate: (dateTime) {
                            // Disable 25th Feb 2023
                            if (dateTime == DateTime(2023, 2, 25)) {
                              return false;
                            } else {
                              return true;
                            }
                          },
                        );
                        if (dateTime != null) {
                          // ignore: use_build_context_synchronously
                          controller.selecTimeDate(context, value: dateTime);
                        }
                      },
                      icon: const Icon(Icons.calendar_month_outlined))
                ],
              ),
              SizedBox(
                height: size_8_h,
              ),
              buildDetails(context),
              SizedBox(
                height: size_8_h,
              ),
              buildInfo(context),
              SizedBox(
                height: size_8_h,
              ),
              buildButton(context),
              SizedBox(
                height: size_24_h,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildTimeDate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size_16_w),
      child: SizedBox(
        width: Get.width * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              hint: Obx(
                () => Row(
                  children: [
                    const Icon(
                      Icons.local_hotel_rounded,
                      color: AppColors.red50Color,
                    ),
                    SizedBox(
                      width: size_8_w,
                    ),
                    Text(controller.timeDate.value.thoigianchamsoc ?? '...',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: text_14,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ))
                  ],
                ),
              ),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              underline: Container(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black),
              items: controller.listThoiGianChamSoc.map(
                (val) {
                  return DropdownMenuItem<ThoiGianChamSocModel>(
                    value: val,
                    child: Text(val.thoigianchamsoc),
                  );
                },
              ).toList(),
              onChanged: (ThoiGianChamSocModel? val) async {
                if (val != null) {
                  controller.updateTimeDate(context, val);
                }
                // setState(() {});
                // ProgressDialog.show(context);
                // await controller.getList('Tất cả', 0, 0);
                // ProgressDialog.hide(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget sickPeople(BuildContext context, String img, String id, String name, String brithday, String fee, String pccs, int sex) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.bgBottomAppBar,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.0, color: Colors.white30),
        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      builder: (BuildContext context) {
                        return imgDialog();
                      },
                      context: context);
                },
                child: Image.network(
                  img,
                  width: 60.sp,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return sex == 1
                        ? Image.asset(
                            'assets/images/icon_account_man.png',
                            width: 60.sp,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'assets/images/icon_account_woman.jpg',
                            width: 60.sp,
                            fit: BoxFit.contain,
                          );
                  },
                ),
              ),
              SizedBox(
                width: size_16_w,
              ),
              SizedBox(
                width: Get.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SBA: $id - $name",
                      maxLines: 3,
                      style: textTheme.titleSmall,
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    Text(
                      "Năm sinh: $brithday - $fee",
                      maxLines: 3,
                      style: textTheme.titleSmall,
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    // Text(
                    //   "PCCS: $pccs",
                    //   maxLines: 3,
                    //   style: textTheme.titleSmall,
                    // ),
                    Row(
                      children: [
                        Text(
                          "PCCS:",
                          style: textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: size_50_w,
                          child: CustomTextField(
                            controller: controller.pccsController.value,
                            isShowLable: false,
                            paddingVer: 0,
                            paddingHoz: 0,
                            maxNumber: 6,
                            style: TextStyle(color: AppColors.hintText, fontSize: text_16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                            typeInput: TypeInput.text,
                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
                              hintText: '...',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    inforCell(context, 'Điều dưỡng', controller.inforTimeDate.value.dieuduong ?? '...')
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildDetails(BuildContext context) {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.bgBottomAppBar,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.0, color: Colors.white30),
          boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
        ),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cellInfor(Icons.monitor_heart_outlined, controller.machController.value, 'Lần/phút', type: 'mach'),
                  cellInfor(Icons.thermostat, controller.nhietdoController.value, '°C', type: 'nhietdo'),
                  cellInfor(Icons.bloodtype_rounded, controller.huyetapController.value, 'mmHg', typeInput: TypeInput.datetime, type: 'huyetap'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cellInfor(Icons.monitor_weight, controller.cannangController.value, 'Kg'),
                  cellInfor(Icons.man_3_rounded, controller.chieucaoController.value, 'Cm'),
                  cellInfor(Icons.air, controller.nhipthoController.value, 'Lần/phút'),
                ],
              )
            ],
          ),
        ));
  }

  Widget cellInfor(IconData icon, TextEditingController textEditingController, String describe, {TypeInput? typeInput, String? type}) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: size_8_w,
        ),
        SizedBox(
          width: size_50_w,
          child: CustomTextField(
            controller: textEditingController,
            isShowLable: false,
            paddingVer: 0,
            paddingHoz: 0,
            maxNumber: 6,
            style: TextStyle(
                color: type == 'mach'
                    ? controller.colorMach.value
                    : type == 'nhietdo'
                        ? controller.colorNhietDo.value
                        : type == 'huyetap'
                            ? controller.colorHuyetAp.value
                            : AppColors.white,
                fontSize: text_16,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            typeInput: typeInput ?? TypeInput.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                switch (type) {
                  case 'mach':
                    if (int.parse(value) < 55 || int.parse(value) > 100) {
                      controller.colorMach.value = AppColors.error;
                    } else {
                      controller.colorMach.value = AppColors.white;
                    }
                    break;
                  case 'nhietdo':
                    if (int.parse(value) < 36 || int.parse(value) >= 38) {
                      controller.colorNhietDo.value = AppColors.error;
                    } else {
                      controller.colorNhietDo.value = AppColors.white;
                    }
                    break;
                  case 'huyetap':
                    String cao = '0';

                    String thap = '0';

                    if (value.contains('/')) {
                      cao = value.split('/').first.trim();
                      thap = value.split('/').last.trim();
                    } else if (value.contains(' ')) {
                      cao = value.split(' ').first.trim();
                      thap = value.split(' ').last.trim();
                    } else {
                      cao = value;
                      thap = '0';
                    }

                    if (int.parse(cao) < 90 || int.parse(cao) > 140 || int.parse(thap) < 60 || int.parse(thap) > 90) {
                      controller.colorHuyetAp.value = AppColors.error;
                    } else {
                      controller.colorHuyetAp.value = AppColors.white;
                    }
                    break;
                  default:
                }
              }
            },
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 0, bottom: size_15_h, right: 0),
              hintText: '...',
            ),
          ),
        ),
        SizedBox(
          width: size_8_w,
        ),
        Text(
          describe,
          style: TextStyle(color: AppColors.hintText, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget buildInfo(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.bgBottomAppBar,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.0, color: Colors.white30),
        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black38, offset: Offset(1, 1))],
      ),
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.dienbienController.value,
                typeInput: TypeInput.multiline,
                lableText: 'Tình trạng bệnh nhân',
                hideText: 'Chọn chuẩn đoán',
                //suffixIcon: const Icon(Icons.arrow_drop_down_outlined, color: AppColors.white),
                prefixIcon: const Icon(Icons.analytics_outlined),
                //validator: (value) => Validator.validateEmail(value),
              ),
              InkWell(
                onTap: () {
                  CustomBottomSheet.showModalNotFullScreenWithHeight(
                    context,
                    CdddView(),
                    height: Get.height * 0.9,
                  );
                },
                child: CustomTextField(
                  readOnly: true,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onTap: () {
                    CustomBottomSheet.showModalNotFullScreenWithHeight(
                      context,
                      CdddView(),
                      height: Get.height * 0.9,
                    );
                  },
                  controller: controller.chandoandieuduongController.value,
                  typeInput: TypeInput.multiline,
                  lableText: 'Chuẩn đoán DD',
                  hideText: 'Nhập nội dung',
                  suffixIcon: const Icon(Icons.arrow_drop_down_outlined, color: AppColors.white),
                  prefixIcon: const Icon(Icons.analytics_outlined),
                  //validator: (value) => Validator.validateEmail(value),
                ),
              ),
              CustomTextField(
                controller: controller.muctieudieuduongController.value,
                typeInput: TypeInput.multiline,
                lableText: 'Mục tiêu DD',
                hideText: 'Nhập nội dung',
                prefixIcon: const Icon(Icons.analytics_outlined),
                //validator: (value) => Validator.validateEmail(value),
              ),
              CustomTextField(
                controller: controller.canthiepController.value,
                typeInput: TypeInput.multiline,
                lableText: 'Can thiệp DD',
                hideText: 'Nhập nội dung',
                prefixIcon: const Icon(Icons.analytics_outlined),
                //validator: (value) => Validator.validateEmail(value),
              ),
              CustomTextField(
                controller: controller.luonggiaController.value,
                typeInput: TypeInput.multiline,
                lableText: 'Lượng giá',
                hideText: 'Nhập nội dung',
                prefixIcon: const Icon(Icons.info_outline),
                //validator: (value) => Validator.validateEmail(value),
              ),
              CustomTextField(
                controller: controller.ghichuController.value,
                typeInput: TypeInput.multiline,
                lableText: 'Lời dặn',
                hideText: 'Nhập nội dung',
                prefixIcon: const Icon(Icons.sms),
                //validator: (value) => Validator.validateEmail(value),
              ),
              CustomTextField(
                controller: controller.ylenhchamsocController.value,
                typeInput: TypeInput.multiline,
                lableText: 'Y lệnh',
                hideText: 'Nhập nội dung',
                prefixIcon: const Icon(Icons.note_alt_outlined),
                //validator: (value) => Validator.validateEmail(value),
              ),
            ],
          )),
    );
  }

  Widget buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {
              controller.addYL();
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.add_chart),
                  SizedBox(
                    width: size_8_w,
                  ),
                  const Text('Thêm YL'),
                ],
              ),
            )),
        ElevatedButton(
            onPressed: () {
              controller.saveYL(context);
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.save),
                  SizedBox(
                    width: size_8_w,
                  ),
                  const Text('Lưu YL'),
                ],
              ),
            )),
        Obx(() => ElevatedButton(
            onPressed: () {
              if (controller.isInsert.value == false) {
                controller.deletaYL(context);
              }
            },
            style: controller.isInsert.value == true
                ? ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.backgroundBottombar))
                : ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.delete, color: controller.isInsert.value == true ? AppColors.hintText : AppColors.white),
                  SizedBox(
                    width: size_8_w,
                  ),
                  Text(
                    'Xóa YL',
                    style: TextStyle(color: controller.isInsert.value == true ? AppColors.hintText : AppColors.white),
                  ),
                ],
              ),
            ))),
      ],
    );
  }

  Widget inforCell(BuildContext context, String title, String infor) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: Theme.of(context).textTheme.titleSmall,
        children: <TextSpan>[
          TextSpan(
            text: infor,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: text_16),
          ),
        ],
      ),
    );
  }

  Widget imgDialog() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AlertDialog(
        backgroundColor: AppColors.blueGray100Color,
        contentPadding: const EdgeInsets.all(6),
        insetPadding: const EdgeInsets.all(6),
        content: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Image.network(
            'http://192.168.1.178:1015/Data/48015/Media/${patientInformationModel.mAYTE}/${patientInformationModel.fILENAME}',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return patientInformationModel.sEX == 1
                  ? Image.asset(
                      'assets/images/icon_account_man.png',
                      width: 100.sp,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      'assets/images/icon_account_woman.jpg',
                      width: 100.sp,
                      fit: BoxFit.contain,
                    );
            },
          ),
        ),
      ),
    );
  }
}
