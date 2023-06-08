import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

import '../controllers/medication_schedule_controller.dart';

class StickDetails extends GetView<MedicationScheduleController> {
  const StickDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác nhận phát thuốc'),
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
            inforCell(context, 'BS kê lệnh', 'Nguyễn Duy An'),
            SizedBox(
              height: size_8_h,
            ),
            Row(
              children: [
                const Icon(
                  Icons.event_note,
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
            buildNote(context),
            SizedBox(
              height: size_8_h,
            ),
            buildCheck(context),
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
          inforCell(context, 'Chuẩn đoán',
              'Rối loạn tiền đình là tình trạng quá trình truyền dẫn và tiếp nhận thông tin của tiền đình bị rối loạn hoặc tắc nghẽn do dây thần kinh số 8 hoặc động mạch nuôi'),
          SizedBox(
            height: size_16_h,
          ),
          inforCell(context, 'Diễn biến', 'bệnh nhân ăn uống bình thường'),
          SizedBox(
            height: size_16_h,
          ),
          inforCell(context, 'Ghi chú', '12h00 đo dấu sinh tồn'),
          SizedBox(
            height: size_16_h,
          ),
          inforCell(context, 'Chế độ dinh dưỡng', 'BT01'),
          SizedBox(
            height: size_16_h,
          ),
          inforCell(context, 'Phân cấp chăm sóc', 'Cấp 3'),
        ],
      ),
    );
  }

  Widget buildNote(BuildContext context) {
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
      child: Column(children: [
        inforCell(context, 'Ghi chú',
            'Hoài sơn 183mg, Cao khô kiên tâm 35mg, Hoài sơn 183mg, Cao khô kiên tâm 35mg, Hoài sơn 183mg, Cao khô kiên tâm 35mg, Hoài sơn 183mg, Cao khô kiên tâm 35mg'),
      ]),
    );
  }

  Widget buildCheck(BuildContext context) {
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
          () => Expanded(
            child: Column(
              children: <Widget>[
                CheckboxListTile(
                  value: controller.checkboxValue1.value,
                  onChanged: (bool? value) {
                    controller.checkboxValue1.value = value!;
                  },
                  title: const Text('Sáng'),
                  secondary: const Icon(Icons.sunny_snowing, color: AppColors.white),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: controller.checkboxValue2.value,
                  onChanged: (bool? value) {
                    controller.checkboxValue2.value = value!;
                  },
                  title: const Text('Trưa'),
                  secondary: const Icon(Icons.sunny, color: AppColors.white),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: controller.checkboxValue3.value,
                  onChanged: (bool? value) {
                    controller.checkboxValue3.value = value!;
                  },
                  title: const Text('Chiều'),
                  secondary: const Icon(Icons.brightness_4_outlined, color: AppColors.white),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: controller.checkboxValue4.value,
                  onChanged: (bool? value) {
                    controller.checkboxValue4.value = value!;
                  },
                  title: const Text('Tối'),
                  secondary: const Icon(Icons.mode_night_rounded, color: AppColors.white),
                ),
              ],
            ),
          ),
        ));
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
