import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:my_app_hospital/configs/app_color.dart';

class CustomBottomSheet {
  static void showModal(
    BuildContext context,
    Widget child, {
    bool isScrollControlled = true,
    double initialChildSize = 0.95,
    Function? bottomSheetClose,
  }) {
    showModalBottomSheet(
        isScrollControlled: isScrollControlled,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.background.withOpacity(0.4),
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: initialChildSize,
              builder: (BuildContext context, ScrollController scrollController) {
                return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                        color: Colors.transparent,
                        // padding: EdgeInsets.only(
                        // bottom: Platform.isAndroid
                        //     ? kBottomNavigationBarHeight
                        //     : 0),
                        child: Column(
                          children: [
                            Container(
                              width: 85,
                              height: 4,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  color: AppColors.colorBorder),
                              margin: EdgeInsets.only(bottom: 6),
                            ),
                            Expanded(
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Container(
                                      color: AppColors.background,
                                      child: child,
                                    )))
                          ],
                        )));
              });
        }).then((value) {
      if (bottomSheetClose != null) bottomSheetClose();
    });
  }

  static void showModalFullScreen(
    BuildContext context,
    Widget child, {
    bool isScrollControlled = true,
    double initialChildSize = 1,
  }) {
    showModalBottomSheet(
        isScrollControlled: isScrollControlled,
        backgroundColor: AppColors.backgroundBottombar,
        barrierColor: AppColors.background.withOpacity(0.4),
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: initialChildSize,
              builder: (BuildContext context, ScrollController scrollController) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  // borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    color: Colors.transparent,
                    // padding: EdgeInsets.only(
                    //     bottom: Platform.isAndroid
                    //         ? kBottomNavigationBarHeight
                    //         : 0),
                    child: child,
                  ),
                );
              });
        });
  }

  static void showModalNotFullScreenWithHeight(BuildContext context, Widget child, {double? height}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        //barrierColor: AppColors.background,
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: Container(
                  height: height ?? Device.screenHeight * 0.75,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 85,
                        height: 4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                          color: AppColors.colorBorder,
                        ),
                        margin: const EdgeInsets.only(bottom: 6),
                      ),
                      Expanded(
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                              child: Container(
                                color: AppColors.background,
                                child: child,
                              )))
                    ],
                  )));
        });
  }

  static void showModalNotFullScreen(
    BuildContext context,
    Widget child,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        //barrierColor: AppColors.background.withOpacity(0.4),
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 85,
                    height: 4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                      color: AppColors.colorBorder,
                    ),
                    margin: EdgeInsets.only(bottom: 8)),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                    color: AppColors.background,
                  ),
                  child: child,
                ),
              ],
            ),
          );
        });
  }

  // static void showModalPickImageType(BuildContext context, List<ImageSourceItem> listImageSource, Function chooseSourceImage) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => ImagePickerModal(listImageSource: listImageSource, chooseSourceImage: chooseSourceImage),
  //   );
  // }
}
