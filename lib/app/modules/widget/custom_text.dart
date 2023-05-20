import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/text.dart';
import 'package:my_app_hospital/configs/theme/theme.dart';
import 'package:my_app_hospital/configs/utils.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double paddingHoz;
  final double paddingVer;
  final TextAlign textAlign;
  const CustomText(
      {super.key,
      required this.text,
      this.fontSize = 14,
      this.fontWeight,
      this.color = AppColors.textColor,
      this.paddingHoz = 0,
      this.paddingVer = 0,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHoz, vertical: paddingVer),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: 1.35,
        ),
      ),
    );
  }
}

enum TypeInput { name, phone, email, idCard, password, confirmPassword, number, text, multiline }

const EMOJI_REGEXP = r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])';
const MAX_LENGTH_CHARACTER = 50;
const String EMAIL_REGEXP = r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TypeInput typeInput;
  final String lableText;
  final bool isShowLable;
  final bool readOnly;
  final double paddingVer;
  final double paddingHoz;
  final bool amount;
  final bool vnd;
  final FormFieldValidator<String?>? validator;
  final String initVal;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool isPaste;
  final GestureTapCallback? onTap;
  final bool? obscureText;
  final int maxLine;
  final bool number;
  final bool isDense;
  final bool isGetAll;
  final String hideText;
  final ValueChanged<String>? onChanged;
  final Color colorEnableBoder;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Function()? onTapGetAll;
  final GestureTapCallback? onTapPaste;
  final TextStyle? style;
  final InputDecoration? decoration;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.typeInput,
    this.lableText = '',
    this.maxLine = 1,
    this.initVal = '',
    this.amount = false,
    this.isShowLable = true,
    this.isDense = false,
    this.isGetAll = false,
    this.vnd = false,
    this.prefixIcon,
    this.number = false,
    this.colorEnableBoder = AppColors.hintText,
    this.readOnly = false,
    this.hideText = '',
    this.paddingHoz = 00,
    this.paddingVer = 5,
    this.validator,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.suffix,
    this.onTap,
    this.obscureText,
    this.onChanged,
    this.onTapGetAll,
    this.onTapPaste,
    this.fillColor,
    this.isPaste = false,
    this.style,
    this.decoration,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = false;

  TextInputType textTypeInput(TypeInput typeInput) {
    switch (typeInput) {
      case TypeInput.name:
        return TextInputType.text;
      case TypeInput.number:
        return TextInputType.number;
      case TypeInput.phone:
        return TextInputType.phone;
      case TypeInput.email:
        return TextInputType.emailAddress;
      case TypeInput.password:
        return TextInputType.visiblePassword;
      case TypeInput.confirmPassword:
        return TextInputType.visiblePassword;
      case TypeInput.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: widget.paddingVer.h, horizontal: widget.paddingHoz),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isShowLable
                  ? CustomText(
                      text: widget.lableText,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                      paddingVer: text_14,
                    )
                  : SizedBox(),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: widget.onChanged,
                maxLines: widget.maxLine,
                cursorColor: Colors.grey.shade700,
                textAlignVertical: TextAlignVertical.center,
                textAlign: widget.textAlign,
                readOnly: widget.readOnly,
                inputFormatters: [
                  if (widget.amount) ...{NumericTextFormatter('amount')},
                  if (widget.vnd) ...{
                    NumericTextFormatter('VND'),
                  },
                  widget.number ? LengthLimitingTextInputFormatter(15) : LengthLimitingTextInputFormatter(355),
                  if (widget.number) ...{FilteringTextInputFormatter.digitsOnly}
                ],
                obscureText: widget.obscureText ?? widget.typeInput == TypeInput.password || widget.typeInput == TypeInput.confirmPassword ? !_passwordVisible : false,
                keyboardType: textTypeInput(widget.typeInput),
                style: widget.style ?? TextStyle(color: widget.readOnly ? AppColors.hintText : AppColors.textColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                controller: widget.controller,
                onTap: widget.onTap,
                decoration: widget.decoration ??
                    InputDecoration(
                      fillColor: widget.fillColor,
                      filled: widget.fillColor != null,
                      prefixIcon: widget.prefixIcon,
                      prefixIconColor: AppColors.textColor,
                      isDense: widget.isDense,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                      errorStyle: TextStyle(color: AppColors.error, fontSize: 12.sp),
                      suffixIcon: widget.suffixIcon ??
                          (widget.typeInput == TypeInput.password || widget.typeInput == TypeInput.confirmPassword
                              ? IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    color: AppColors.hintText,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                )
                              : null),
                      suffix: widget.suffix == null
                          ? null
                          : (widget.isGetAll
                              ? IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      widget.suffix ?? const SizedBox(),
                                      serticalDividerBuilder,
                                      InkWell(
                                        onTap: widget.onTapGetAll,
                                        child: Text(
                                          'Tất cả',
                                          style: TextStyle(
                                            color: AppColors.green,
                                            fontWeight: FontWeight.w600,
                                            fontSize: text_15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : widget.isPaste
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: widget.onTapPaste,
                                          child: const Text(
                                            'Paste',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        widget.suffixIcon ?? const SizedBox(),
                                      ],
                                    )
                                  : widget.suffix),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        borderSide: BorderSide(color: widget.colorEnableBoder, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        borderSide: BorderSide(color: AppColors.green),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        borderSide: const BorderSide(color: AppColors.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        borderSide: const BorderSide(color: AppColors.error),
                      ),
                      alignLabelWithHint: true,
                      hintText: widget.hideText,
                      hintStyle: const TextStyle(color: AppColors.hintText, fontWeight: FontWeight.normal),
                    ),
                validator: widget.validator,
              ),
            ],
          )),
    );
  }
}
