import 'package:flutter/material.dart';
import 'package:my_app_hospital/app/modules/widget/dialog/animation_transition.dart';

import 'alert_style.dart';

import 'dialog_button.dart';

class Alert {
  final String? id;
  final BuildContext context;
  final AlertType? type;
  final AlertStyle style;
  final Widget? image;
  final bool showImageInDialog;
  final String? title;
  final String? desc;
  final Widget content;
  final List<DialogButton>? buttons;
  final Function? closeFunction;
  final Widget? closeIcon;
  final bool onWillPopActive;
  final bool useRootNavigator;
  final AlertAnimation? alertAnimation;
  final bool barrierDismissible;

  /// Alert constructor
  ///
  /// [context], [title] are required.
  Alert({
    required this.context,
    this.title,
    this.id,
    this.type,
    this.barrierDismissible = true,
    this.style = const AlertStyle(),
    this.image,
    this.desc,
    this.content = const SizedBox(),
    this.buttons,
    this.closeFunction,
    this.closeIcon,
    this.onWillPopActive = false,
    this.alertAnimation,
    this.useRootNavigator = false,
    this.showImageInDialog = false,
  });

  /// Displays defined alert window
  Future<bool?> show() async {
    return await showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
          return _buildDialog();
        },
        barrierDismissible: barrierDismissible,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: style.overlayColor,
        useRootNavigator: useRootNavigator,
        transitionDuration: style.animationDuration,
        transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            alertAnimation == null ? _showAnimation(animation, secondaryAnimation, child) : alertAnimation!(context, animation, secondaryAnimation, child));
  }

  /// Dismisses the alert dialog.
  Future<void> dismiss() async {
    Navigator.of(context, rootNavigator: useRootNavigator).pop();
  }

  /// Alert dialog content widget
  Widget _buildDialog() {
    var width = MediaQuery.of(context).size.width;
    final Widget _child = ConstrainedBox(
      constraints: style.constraints ?? BoxConstraints.expand(width: double.infinity, height: double.infinity),
      child: Align(
        alignment: style.alertAlignment,
        child: SingleChildScrollView(
          child: AlertDialog(
              key: id == null ? null : Key(id!),
              backgroundColor: style.backgroundColor,
              shape: style.alertBorder ?? _defaultShape(),
              insetPadding: style.alertPadding,
              elevation: style.alertElevation,
              titlePadding: const EdgeInsets.all(0.0),
              title: Container(
                width: width - 16 * 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image.asset(
                      //   'assets/images/banner-dialog-update.png',
                      //   fit: BoxFit.fitWidth,
                      // ),
                      if (showImageInDialog && type == AlertType.update) _getImage(),
                      _getCloseButton(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, (style.isCloseButton ? 0 : 10), 20, 0),
                        child: Column(
                          children: <Widget>[
                            if (showImageInDialog && type != AlertType.update) _getImage(),
                            SizedBox(
                              height: 16,
                            ),
                            if (title != null)
                              Text(
                                title ?? '',
                                style: style.titleStyle,
                                textAlign: style.titleTextAlign,
                              ),
                            if (title != null)
                              SizedBox(
                                height: desc == null ? 5 : 10,
                              ),
                            desc == null
                                ? const SizedBox()
                                : Text(
                                    desc!,
                                    style: style.descStyle,
                                    textAlign: style.descTextAlign,
                                  ),
                            content,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              contentPadding: style.buttonAreaPadding,
              content: style.buttonsDirection == ButtonsDirection.row
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _getButtons(),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _getButtons(),
                    )),
        ),
      ),
    );
    return onWillPopActive ? WillPopScope(onWillPop: () async => false, child: _child) : _child;
  }

  /// Returns the close button on the top right
  Widget _getCloseButton() {
    return style.isCloseButton
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: GestureDetector(
              onTap: () {
                if (closeFunction == null) {
                  Navigator.of(context, rootNavigator: useRootNavigator).pop();
                } else {
                  closeFunction!();
                }
              },
              child: Container(
                alignment: FractionalOffset.topRight,
                child: this.closeIcon != null ? Container(child: this.closeIcon) : SizedBox(),
              ),
            ),
          )
        : Container();
  }

  /// Returns defined buttons. Default: Cancel Button
  List<Widget> _getButtons() {
    List<Widget> expandedButtons = [];
    if (style.isButtonVisible) {
      if (buttons != null) {
        buttons!.forEach(
          (button) {
            var buttonWidget = Padding(
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: button,
            );
            if ((button.width != null && buttons!.length == 1) || style.buttonsDirection == ButtonsDirection.column) {
              expandedButtons.add(buttonWidget);
            } else {
              expandedButtons.add(Expanded(
                child: buttonWidget,
              ));
            }
          },
        );
      } else {
        Widget cancelButton = DialogButton(
          child: Text(
            "CANCEL",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onPressed: () => Navigator.pop(context),
        );
        if (style.buttonsDirection == ButtonsDirection.row) {
          cancelButton = Expanded(
            child: cancelButton,
          );
        }
        expandedButtons.add(cancelButton);
      }
    }
    return expandedButtons;
  }

  /// Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  /// Returns alert image for icon
  Widget _getImage() {
    Widget response = image ?? Container();
    switch (type) {
      case AlertType.success:
        response = Image.asset(
          '$kImagePath/icon_success.png',
          package: 'rflutter_alert',
        );
        break;
      case AlertType.error:
        response = Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'thông báo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
        break;
      case AlertType.info:
        response = Image.asset(
          '$kImagePath/icon_info.png',
          package: 'rflutter_alert',
        );

        break;
      case AlertType.warning:
        // response = Image.asset(
        //   '$kImagePath/icon_warning.png',
        //   package: 'rflutter_alert',
        // );
        response = Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'thông báo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
        break;
      case AlertType.update:
        response = ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            '$kImagePath/banner-dialog-update.png',
            fit: BoxFit.cover,
            //package: 'rflutter_alert',
          ),
        );
        break;
      case AlertType.none:
      default:
        response = Container();
        break;
    }
    return response;
  }

  /// Shows alert with selected animation
  _showAnimation(animation, secondaryAnimation, child) {
    switch (style.animationType) {
      case AnimationType.fromRight:
        return AnimationTransition.fromRight(animation, secondaryAnimation, child);
      case AnimationType.fromLeft:
        return AnimationTransition.fromLeft(animation, secondaryAnimation, child);
      case AnimationType.fromBottom:
        return AnimationTransition.fromBottom(animation, secondaryAnimation, child);
      case AnimationType.grow:
        return AnimationTransition.grow(animation, secondaryAnimation, child);
      case AnimationType.shrink:
        return AnimationTransition.shrink(animation, secondaryAnimation, child);
      case AnimationType.fromTop:
        return AnimationTransition.fromTop(animation, secondaryAnimation, child);
    }
  }
}
