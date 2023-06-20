import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/text.dart';
import 'package:overlay_dialog/overlay_dialog.dart';

import 'alert_custom.dart';
import 'alert_style.dart';
import 'dialog_button.dart';

class ProgressDialog {
  static DialogWidget? _dialog;

  static _initIfNeeded() {
    if (_dialog == null) {
      _dialog = DialogWidget.custom(child: CustomerProgressDialog());
    }
  }

  static show(BuildContext context) {
    _initIfNeeded();
    if (_dialog != null) {
      DialogHelper().show(context, _dialog!);
    }
  }

  static hide(BuildContext context) {
    DialogHelper().hide(context);
  }

  static Future<void> hideIfNeeded(BuildContext context) async {
    DialogHelper().hide(context);
    return Future.value();
  }

  static void showDialogwError(BuildContext context, {required String content, String? title, Function()? onPressed, bool canDismissible = false}) {
    Alert(
        context: context,
        barrierDismissible: canDismissible,
        type: AlertType.error,
        title: title ?? 'ERROR',
        showImageInDialog: true,
        style: AlertStyle(backgroundColor: AppColors.backgroundBottombar, titleStyle: Theme.of(context).textTheme.headlineMedium!, overlayColor: Colors.black38),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 26),
            Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: text_14),
              ),
            ),
            const SizedBox(height: 46),
          ],
        ),
        buttons: [
          DialogButton(
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.all(0.0),
            color: Colors.blue,
            radius: BorderRadius.circular(10.0),
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
            child: Text(
              "Ok",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.black),
            ),
          )
        ]).show();
  }

  static void showDialogwWarning(BuildContext context, {required String content, String? title, Function()? onPressed, bool canDismissible = false}) {
    Alert(
        context: context,
        barrierDismissible: canDismissible,
        type: AlertType.warning,
        showImageInDialog: true,
        style: AlertStyle(backgroundColor: Theme.of(context).dialogBackgroundColor, titleStyle: Theme.of(context).textTheme.headline4!, overlayColor: Colors.black38),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 26),
            Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: text_14),
              ),
            ),
            const SizedBox(height: 46),
          ],
        ),
        buttons: [
          DialogButton(
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.all(0.0),
            color: Colors.blue,
            radius: BorderRadius.circular(10.0),
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
            child: Text(
              "Ok",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.black),
            ),
          )
        ]).show();
  }

  static void showDialogNotification(BuildContext context,
      {required String content, String? title, Function()? onPressed, bool isCanel = false, bool canDismissible = false, String? okTitle, String? canTitle}) {
    Alert(
        context: context,
        barrierDismissible: canDismissible,
        type: AlertType.warning,
        showImageInDialog: true,
        style: AlertStyle(backgroundColor: Theme.of(context).dialogBackgroundColor, titleStyle: Theme.of(context).textTheme.headline4!, overlayColor: Colors.black38),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 26),
            Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: text_14, height: 1.5),
              ),
            ),
            const SizedBox(height: 46),
          ],
        ),
        buttons: [
          if (isCanel)
            DialogButton(
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding: const EdgeInsets.all(0.0),
              color: Theme.of(context).disabledColor,
              radius: BorderRadius.circular(10.0),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                canTitle ?? "Hủy",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          DialogButton(
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.all(0.0),
            color: AppColors.blue,
            radius: BorderRadius.circular(10.0),
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
            child: Text(
              okTitle ?? "Ok",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ]).show();
  }
}

class CustomerProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AbsorbPointer(
        absorbing: true,
        child: Stack(
          children: [
            Container(
              color: Color(0xFF0A0A0B).withOpacity(0.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: Container(
                  color: Color(0x01000000),
                  child: FractionallySizedBox(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.all(24.0),
                        decoration: BoxDecoration(color: AppColors.backgroudColor, borderRadius: BorderRadius.all(const Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: 2,
                            ),
                            const SizedBox(height: 8),
                            Text('loading...', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
