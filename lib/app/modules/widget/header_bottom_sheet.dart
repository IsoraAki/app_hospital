import 'package:flutter/material.dart';

class HeaderBottomSheet extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final double? height;
  final bool isShowButtonClose;
  final bool isShowButtonCloseLeft;
  final bool showClearButton;
  final Function? onPressedClear;
  final GestureTapCallback? onPressClose;
  final GestureTapCallback? onCreate;
  final Color? bgColor;
  final isShowBtnCreate;

  const HeaderBottomSheet({
    Key? key,
    this.title,
    this.titleWidget,
    this.height,
    this.isShowButtonClose = true,
    this.isShowButtonCloseLeft = false,
    this.isShowBtnCreate = false,
    this.showClearButton = false,
    this.onPressedClear,
    this.bgColor,
    this.onPressClose,
    this.onCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? (titleWidget != null ? 83 : 63),
        width: double.infinity,
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Stack(
            children: [
              // if (isShowButtonCloseLeft)
              //   Positioned.fill(
              //       child: Align(
              //           alignment: Alignment.centerLeft,
              //           child: InkWell(
              //             onTap: () {
              //               Navigator.pop(context);
              //             },
              //             child: SvgPicture.asset(
              //               AppAssets.ic_close,
              //               color: ColorAndTextStyleMode().colorIconDefault,
              //             ),
              //           ))),
              // if (isShowBtnCreate)
              //   Positioned.fill(
              //       child: Align(
              //           alignment: Alignment.centerLeft,
              //           child: InkWell(
              //             onTap: onCreate,
              //             child: SvgPicture.asset(
              //               AppAssets.ic_create_virtual_account,
              //               color: WalletColors.primaryColorV3,
              //             ),
              //           ))),
              Center(
                child: titleWidget ??
                    Text(
                      this.title ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
                    ),
              ),
              // if (isShowButtonClose)
              //   Positioned.fill(
              //       child: Align(
              //           alignment: Alignment.centerRight,
              //           child: InkWell(
              //             onTap: onPressClose ??
              //                 () {
              //                   Navigator.pop(context);
              //                 },
              //             child: SvgPicture.asset(
              //               AppAssets.ic_close,
              //               color: ColorAndTextStyleMode().colorIconDefault,
              //             ),
              //           ))),
              if (showClearButton)
                TextButton(
                    onPressed: () {
                      if (onPressedClear == null) return;
                      onPressedClear!();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text('Clear'),
                    ))
            ],
          ),
        ));
  }
}
