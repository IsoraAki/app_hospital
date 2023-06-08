import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_app_hospital/app/modules/command/controllers/command_controller.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

class CommandDetails extends GetView<CommandController> {
  const CommandDetails({super.key});

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
        child: SingleChildScrollView(
          child: Column(children: [
            sickPeople(context, '', '22.002.5', 'tên bệnh nhân', '1986', '22.000.000'),
            SizedBox(
              height: size_8_h,
            ),
            inforCell(context, 'Điều dưỡng', 'Nguyễn Duy An'),
            SizedBox(
              height: size_8_h,
            ),
            Row(
              children: [
                const Icon(
                  Icons.local_hotel_rounded,
                  color: AppColors.red50Color,
                ),
                SizedBox(
                  width: size_8_w,
                ),
                Text(
                  "15/05/2023 08:15",
                  maxLines: 3,
                  style: textTheme.titleSmall!.copyWith(color: Colors.yellow),
                ),
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
            buildButton(),
            SizedBox(
              height: size_24_h,
            ),
          ]),
        ),
      ),
    );
  }

  Widget sickPeople(BuildContext context, String img, String id, String name, String brithday, String fee) {
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
              Image.network(
                img,
                height: size_40_h,
                width: size_30_w,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.account_box_rounded,
                    size: size_60_h,
                  );
                },
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
                      "Năm sinh: $brithday - Viện phí: $fee",
                      maxLines: 3,
                      style: textTheme.titleSmall,
                    ),
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
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Nhịp tim',
            hideText: 'Nhập nhịp tim',
            suffix: const Text('Lần/phút'),
            prefixIcon: const Icon(Icons.monitor_heart_outlined),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Nhiệt độ cơ thể',
            hideText: 'Nhập Nhiệt độ cơ thể',
            prefixIcon: const Icon(Icons.thermostat),
            suffix: const Text('°C'),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Huyết áp',
            hideText: 'Nhập huyết áp',
            suffix: const Text('mmHg'),
            prefixIcon: const Icon(Icons.bloodtype_rounded),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Cân nặng',
            hideText: 'Nhập cân nặng',
            suffix: const Text('Kg'),
            prefixIcon: const Icon(Icons.monitor_weight),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Chiều cao',
            hideText: 'Nhập chiều cao',
            suffix: const Text('Cm'),
            prefixIcon: const Icon(Icons.man_3_rounded),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Nhịp thở',
            hideText: 'Nhập nhịp thở',
            suffix: const Text('Lần/phút'),
            prefixIcon: const Icon(Icons.air),
            //validator: (value) => Validator.validateEmail(value),
          ),
        ],
      ),
    );
  }

  Widget buildInfo(BuildContext context) {
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
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Tình trạng bệnh nhân',
            hideText: 'Chọn chuẩn đoán',
            suffixIcon: Icon(Icons.arrow_drop_down_outlined, color: AppColors.white),
            prefixIcon: const Icon(Icons.analytics_outlined),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Chuẩn đoán DD',
            hideText: 'Nhập nội dung',
            prefixIcon: const Icon(Icons.analytics_outlined),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Mục tiêu DD',
            hideText: 'Nhập nội dung',
            prefixIcon: const Icon(Icons.analytics_outlined),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Can thiệp DD',
            hideText: 'Nhập nội dung',
            prefixIcon: const Icon(Icons.analytics_outlined),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Lượng giá',
            hideText: 'Nhập nội dung',

            prefixIcon: const Icon(Icons.info_outline),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Lời dặn',
            hideText: 'Nhập nội dung',

            prefixIcon: const Icon(Icons.sms),
            //validator: (value) => Validator.validateEmail(value),
          ),
          CustomTextField(
            controller: TextEditingController(),
            typeInput: TypeInput.text,
            lableText: 'Y lệnh',
            hideText: 'Nhập nội dung',

            prefixIcon: const Icon(Icons.note_alt_outlined),
            //validator: (value) => Validator.validateEmail(value),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {},
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
            onPressed: () {},
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
        ElevatedButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.delete),
                  SizedBox(
                    width: size_8_w,
                  ),
                  const Text('Xóa YL'),
                ],
              ),
            )),
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
}
