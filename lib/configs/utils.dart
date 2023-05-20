import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String ALL_DATA = 'Tất cả';
const LIMIT_PERPAGE = 10;
const CLIENT_ID = 2;
const app_name = 'Exchange-Rate-Tools';

class Utils {
  static String moneyFormat(double money) {
    return NumberFormat('###,###.###').format(money);
  }

  String convertDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  String convertDateFormPicker(DateTime date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(date);
    return outputDate.toString();
  }

  String convertDateFormAPI(DateTime date) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(date);
    return outputDate.toString();
  }

  String convertDateTime(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm:ss dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  // static String prepareImagetUrl(String imageUrl) {
  //   return "${ApiRootGlobal.getInstance().baseDomainWeb}images/$imageUrl";
  // }

  static bool isNullOrEmpty(dynamic obj) => obj == '' || obj == null || (((obj is String && obj.toLowerCase() == 'null') || obj is List || obj is Map) && obj.isEmpty);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650; //iphone
  static bool isTab(BuildContext context) =>
      MediaQuery.of(context).size.width < 1300 && MediaQuery.of(context).size.width >= 650; //ipad pro9.7, ipad pro10.5, ipad air2, ipad mini4
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1300;
}

extension MapExtension on Map {
  String mapToString() {
    String data = '';
    forEach((key, value) {
      data = '$data$key=$value';
    });
    return data;
  }
}

extension StringExtension on String {
  String removeHTML() {
    String currentValue = this;
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return currentValue.replaceAll(exp, '');
  }
}

class NumericTextFormatter extends TextInputFormatter {
  String moneyType;

  NumericTextFormatter(this.moneyType);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newStr = newValue.text;
    String oldStr = oldValue.text;
    if (newStr.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (!RegExp(r'[0-9.,]+$').hasMatch(newStr.replaceAll(',', ''))) {
      ///nếu giá trị mới không phải giống format tiền thì lấy giá trị cũ
      return oldValue;
    } else if (newStr.compareTo(oldStr) != 0) {
      final int selectionIndexFromTheRight = newStr.length - newValue.selection.end;
      final f = NumberFormat("#,###");

      late List data;
      late String finalData;
      late int number;

      if (moneyType == 'VND' || moneyType == 'VNDT') {
        number = checkMaxLength(newStr) && !newStr.contains('.')
            ? int.parse(Utils.isNullOrEmpty(newStr) ? '0' : newStr.replaceAll(f.symbols.GROUP_SEP, ''))
            : int.parse(Utils.isNullOrEmpty(oldStr) ? '0' : oldStr.replaceAll(f.symbols.GROUP_SEP, ''));
      } else {
        if (newStr.contains('.')) {
          // data = newStr.split('.').toList();
          var dataSplit = newStr.split('.').toList();
          data = checkMaxLength(dataSplit.first) ? dataSplit : oldStr.split('.').toList();

          number = data[0] == '' ? 0 : int.parse(data[0].replaceAll(f.symbols.GROUP_SEP, ''));
          if (data[1] != '') {
            if (moneyType == 'amount') {
              if (data[1].length > 2) data[1] = data[1].substring(0, 2);
            } else if (data[1].length > 8) {
              data[1] = data[1].substring(0, 8);
            }
            finalData = '.' + data[1];
          } else {
            finalData = '.';
          }
        } else {
          number = checkMaxLength(newStr) ? int.parse(newStr.replaceAll(f.symbols.GROUP_SEP, '')) : int.parse(oldStr.replaceAll(f.symbols.GROUP_SEP, ''));
          if (!Platform.isAndroid) {
            finalData = '.0';
          } else {
            finalData = "";
          }
        }
      }

      final newString = moneyType == 'VND' || moneyType == 'VNDT' ? f.format(number) : f.format(number) + finalData;

      int offset = moneyType == 'VND' || moneyType == 'VNDT'
          ? newString.length - selectionIndexFromTheRight
          : (Platform.isAndroid && finalData == '' || (Platform.isIOS && finalData == '.0'))
              ? newString.length - finalData.length
              : newString.length;

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(offset: offset),
      );
    } else {
      return checkMaxLength(newStr) ? newValue : oldValue;
    }
  }

  bool checkMaxLength(String text) {
    const MAX_LENGTH_CHARACTER = 15;
    if (text.replaceAll(',', '').length < MAX_LENGTH_CHARACTER) return true;
    return false;
  }
}
