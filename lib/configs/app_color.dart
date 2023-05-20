import 'package:flutter/material.dart';

class AppColors {
  static const Color scaffoldBg = Color(0xFF0F172A);
  static const Color scaffoldBgLight = Color(0xFFF9FAFC);

  static const Color bgBottomAppBarLight = Color(0xFFFFFFFF);
  static const Color bgBottomAppBar = Color(0xFF1E293B);

  static const Color white = Color((0xffffffff));
  static const Color black = Color((0xff000000));

  static const Color red10Color = Color(0xFFFDE8E9);
  static const Color red20Color = Color(0xFFF9B9BB);
  static const Color red30Color = Color(0xFFF7979A);
  static const Color red40Color = Color(0xFFF3676C);
  static const Color red50Color = Color(0xFFF14950);
  static const Color red60Color = Color(0xFFED1C24);
  static const Color red70Color = Color(0xFFD81921);
  static const Color red80Color = Color(0xFFA8141A);
  static const Color red90Color = Color(0xFF820F14);
  static const Color red100Color = Color(0xFF640C0F);

  static const Color blueGray10Color = Color(0xFFF8FAFC);
  static const Color blueGray20Color = Color(0xFFF1F5F9);
  static const Color blueGray30Color = Color(0xFFE2E8F0);
  static const Color blueGray40Color = Color(0xFFCBD5E1);
  static const Color blueGray50Color = Color(0xFF94A3B8);
  static const Color blueGray60Color = Color(0xFF64748B);
  static const Color blueGray70Color = Color(0xFF475569);
  static const Color blueGray80Color = Color(0xFF334155);
  static const Color blueGray90Color = Color(0xFF1E293B);
  static const Color blueGray100Color = Color(0xFF0F172A);

  static const Color endbustomColor = Color(0xFFD51027);
  static const Color sratbustomColor = Color(0xFFEE5E6F);

  //---------------------------------------------------------------------------

  static const Color greyLight = Color.fromARGB(255, 207, 207, 207);
  static const Color grey = Colors.grey;
  //static const Color hint = Color.fromARGB(255, 97, 97, 97);
  static const Color yellowLight = Color.fromARGB(255, 245, 228, 197);

  static const Color blue = Colors.blue;
  static const Color error = Color.fromARGB(255, 235, 91, 80);

  //
  // static const Color backgroudColor = Color.fromARGB(255, 15, 23, 42);
  static const Color backgroudColor = blueGray80Color;
  static const Color buttonColor = Color.fromARGB(255, 56, 201, 148);
  static const Color textColor = Color.fromARGB(255, 255, 255, 255);
  static const Color titleColor = Color.fromARGB(255, 173, 173, 173);
  static const Color hintTextColor = Color.fromARGB(255, 134, 134, 134);
  static const Color containerColor = Color.fromARGB(255, 42, 49, 66);

  static const Color green = Color(0xFF38C994);

  static const Color hintText = Color(0xFF94a3b8);
  static const Color background = Color(0xFF0f172a);
  static const Color colorBorder = Color(0xFF4C556B);

  static const Color backgroundBottombar = Color(0xFF2A3142);

  static final Color lightBlueGrey = Color(0xFFccd5d8);
  static final Color slateGreyThree = Color(0xFF656970);

  static Color parse(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
