// import 'package:u2u_exchange/config/global_translations.dart';
// import 'package:u2u_exchange/utils/utils.dart';
// import 'package:u2u_exchange/widget/custom_text.dart';

// int MAX_LENGTH_CHARACTER = 100;

// class Validator {
//   static validateEmail(String? value) {
//     if (!Utils.isNullOrEmpty(value)) {
//       if (value!.length > MAX_LENGTH_CHARACTER) {
//         return u2uText.text('validate.maxInput') + MAX_LENGTH_CHARACTER.toString() + u2uText.text('validate.character');
//       } else if (RegExp(EMAIL_REGEXP).hasMatch(value) == false) {
//         return u2uText.text('validate.checkEmail');
//       }
//     } else {
//       return u2uText.text('validate.inputEmail');
//     }
//   }

//   static validateTelegram(
//     String? value,
//   ) {
//     if (!Utils.isNullOrEmpty(value)) {
//       if (value!.length > MAX_LENGTH_CHARACTER) {
//         return u2uText.text('validate.maxInput') + MAX_LENGTH_CHARACTER.toString() + u2uText.text('validate.character');
//       } else {
//         if (Utils.isNullOrEmpty(value) || value == ' ' || value.contains('  ')) {
//           return u2uText.text('validate.checkTelegram');
//         } else {
//           return null;
//         }
//       }
//     }
//   }

//   static checkNull(String? value, {String? messageErrorNull, int? maxChar, int? minChar}) {
//     if (value == null || value.isEmpty || value == '' || value.contains('  ')) {
//       return messageErrorNull;
//     }
//     if (!Utils.isNullOrEmpty(maxChar) && value.length > maxChar!) {
//       return u2uText.text('validate.maxInput') + maxChar.toString() + u2uText.text('validate.character');
//     }
//     if (!Utils.isNullOrEmpty(minChar) && value.length < minChar!) {
//       return u2uText.text('validate.minInput') + minChar.toString() + u2uText.text('validate.character');
//     }
//     return null;
//   }

//   static checkPhoneNumber(String? value) {
//     if (value == null || (value.length <= 8 || value.length > 12 || value.isEmpty)) {
//       return u2uText.text('validate.checkPhoneNember');
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(value.replaceFirst('-', '').replaceFirst('+', ''))) {
//       return u2uText.text('validate.inputNumber');
//     }
//     return null;
//   }

//   // static checkValidateYear(String? value, TypeTime typeTime) {
//   //   if (Utils.isNullOrEmpty(value)) {
//   //     return 'Không thể để trống';
//   //   }
//   //   if (double.parse(value!) <= 0) {
//   //     return 'Số  phải lớn hơn 0';
//   //   }

//   //   if (int.parse(value) > 20 && typeTime == TypeTime.year) {
//   //     return 'Nhập tối đa 20 năm';
//   //   }
//   //   if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//   //     return "Phải nhập số nguyên";
//   //   }
//   //   if (int.parse(value) > 12 && typeTime == TypeTime.month) {
//   //     return 'Nhập tối đa 12 tháng';
//   //   }
//   //   return null;
//   // }

//   static checkPassword(String? value) {
//     if (Utils.isNullOrEmpty(value) || value == ' ' || value!.contains('  ')) {
//       return u2uText.text('validate.inputPassword');
//     } else if (value.length > MAX_LENGTH_CHARACTER) {
//       return u2uText.text('validate.maxInput') + MAX_LENGTH_CHARACTER.toString() + u2uText.text('validate.character');
//     } else if (RegExp(EMOJI_REGEXP).hasMatch(value)) {
//       return u2uText.text('validate.checkCharacter');
//     } else if (value.length < 8) {
//       return u2uText.text('validate.minPassword');
//     }
//     return null;
//   }

//   static checkInputNumberAmount(String? value, {double? min, double? max, bool checkNull = true, int maxlength = 14}) {
//     var newVal = value!.replaceAll(',', '').replaceAll('.', '');
//     var newValInter = value.split('.').first.replaceAll(',', '');
//     print(newValInter);
//     if (Utils.isNullOrEmpty(newVal) && checkNull) {
//       return u2uText.text('error.notBlank');
//     }
//     if (newVal.length > maxlength) {
//       return 'Nhập tối đa $maxlength kí tự';
//     }
//     if (newValInter.length > maxlength - 2) {
//       return 'Nhập tối đa ${maxlength - 2} số nguyên';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(newVal)) {
//       return "Phải nhập số nguyên";
//     }
//     if (double.parse(newVal) <= 0) {
//       return 'Số tiền phải lớn hơn 0';
//     }
//     if (!Utils.isNullOrEmpty(min) && double.parse(newVal) < (min ?? 0)) {
//       return 'Số tiền không thể nhỏ hơn ${Utils.moneyFormat(min!)}';
//     }
//     if (!Utils.isNullOrEmpty(max) && double.parse(newVal) > (max ?? 0)) {
//       return 'Số tiền không thể lớn hơn $max';
//     }
//     return null;
//   }

//   // static checkInputNumber(String? value, {double? min, double? max, double maxLength = 14}) {
//   //   if (Utils.isNullOrEmpty(value)) {
//   //     return 'Không thể để trống';
//   //   }
//   //   if (double.parse(value!) <= 0) {
//   //     return 'Số  phải lớn hơn 0';
//   //   }
//   //   if (value.length >= maxLength) {
//   //     return 'Nhập tối đa $maxLength kí tự';
//   //   }
//   //   if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//   //     return "Phải nhập số nguyên";
//   //   }
//   //   if (!Utils.isNullOrEmpty(min) && double.parse(value) < (min ?? 0)) {
//   //     return 'Không nhỏ hơn $min';
//   //   }
//   //   if (!Utils.isNullOrEmpty(max) && double.parse(value) > (max ?? 0)) {
//   //     return 'Không lớn hơn $max';
//   //   }
//   //   return null;
//   // }

//   static checkIdentify(
//     String? value,
//   ) {
//     if (Utils.isNullOrEmpty(value)) {
//       return u2uText.text('validate.inputInfo');
//     }

//     if (value!.length >= 14) {
//       return '${u2uText.text('validate.maxInput')}14${u2uText.text('validate.character')}';
//     }
//     if (value.length < 9) {
//       return '${u2uText.text('validate.minInput')}9${u2uText.text('validate.character')}';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//       return u2uText.text('validate.checkInterger');
//     }

//     return null;
//   }
// }
