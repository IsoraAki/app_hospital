import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';

Widget sickPeopleCell(BuildContext context, Function() ontap, String img, String id, String name, String brithday, String fee, String adr, String note, String bs, String lv) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return InkWell(
    onTap: ontap,
    child: Container(
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
                      "$id: $name",
                      maxLines: 3,
                      style: textTheme.titleSmall,
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    Row(
                      children: [
                        Text(
                          brithday,
                          maxLines: 3,
                          style: textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: size_16_w,
                        ),
                        Text(
                          'Viện phí: $fee',
                          maxLines: 3,
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    Text(
                      adr,
                      style: textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    Text(
                      'Phân cấp chắm sóc: $lv',
                      maxLines: 3,
                      style: textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    Text(
                      'Ghi chú của BS: $note',
                      maxLines: 3,
                      style: textTheme.bodyMedium!.copyWith(color: AppColors.blue),
                    ),
                    SizedBox(
                      height: size_8_h,
                    ),
                    Text(
                      'BS: $bs',
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
    ),
  );
}
