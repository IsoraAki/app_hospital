import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/command/controllers/command_controller.dart';
import 'package:my_app_hospital/app/modules/widget/header_bottom_sheet.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/text.dart';

class CdddView extends StatelessWidget {
  CdddView({super.key});
  final commandController = Get.find<CommandController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderBottomSheet(
          title: 'Chọn chuẩn đoán',
          isShowButtonClose: false,
        ),
        Expanded(
            child: ListView.separated(
          //physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const Divider(
            color: AppColors.hintText,
            thickness: 0.5,
            height: 1,
          ),
          itemCount: commandController.listDiagnostic.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                commandController.updateCDDD(commandController.listDiagnostic[index]);
                Navigator.of(context).pop();
              },
              // child:
              //     filterCurrent == index ? _Selec(index) : _noSelec(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                color: commandController.diagnosticCurrent.value == commandController.listDiagnostic[index] ? AppColors.backgroundBottombar : Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      commandController.listDiagnostic[index].mA ?? '...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: text_16,
                        color: commandController.diagnosticCurrent.value == commandController.listDiagnostic[index] ? Colors.white : AppColors.hintText,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                    Flexible(
                        child: Text(
                      commandController.listDiagnostic[index].nHOM ?? '...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: text_16,
                        color: commandController.diagnosticCurrent.value == commandController.listDiagnostic[index] ? Colors.white : AppColors.hintText,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                    Flexible(
                        child: Text(
                      commandController.listDiagnostic[index].tEN ?? '...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: text_16,
                        color: commandController.diagnosticCurrent.value == commandController.listDiagnostic[index] ? Colors.white : AppColors.hintText,
                        fontWeight: FontWeight.w500,
                      ),
                    )),

                    // if (filterCurrent == index)
                    //   SvgPicture.asset(AppAssets.ic_right),
                  ],
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}
