import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:my_app_hospital/configs/utils.dart';
import 'package:my_app_hospital/util/config_regexp.dart';

class Validator {
  static bool isValidPhone(String? phone) {
    return (phone!.length >= 10 && phone.length <= 15 && RegExp(PHONE_NUMBER_REGEXP).hasMatch(phone));
  }

  static bool isContainAccent(String text) {
    return (RegExp(ONLY_CHARACTER).hasMatch(text));
  }

  static bool isValidMail(String? mail) {
    return RegExp(EMAIL_REGEXP).hasMatch(mail!);
  }

  static String? mailValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Email không được trống!";
    }

    if (!isValidMail(text)) {
      return 'Email không hợp lệ!';
    }

    return null;
  }

  static String? phoneOrMailValidator(String? text) {
    if (isValidMail(text) || isValidPhone(text)) {
      return null;
    }
    return "Giá trị không hợp lệ!";
  }

  static String? phoneValidator(String? text) {
    if (isValidPhone(text)) {
      return null;
    }
    return "Số điện thoại không hợp lệ";
  }

  // static String? phoneVNValidator(String? text) {
  //   if (text == null || text.isEmpty || text.length < 10 || text.length > 11 || !RegExp(PHONE_NUMBER_REGEXP).hasMatch(text)) {
  //     return "Giá trị không hợp lệ!";
  //   }

  //   if (text.length == 11) {
  //     int _firstPhone = int.parse(text.substring(0, 4).trim());
  //     if (FirstNumberViettel11.contains(_firstPhone) ||
  //         FirstNumberVinaPhone11.contains(_firstPhone) ||
  //         FirstNumberMobifone11.contains(_firstPhone) ||
  //         FirstNumberVietnammobile11.contains(_firstPhone) ||
  //         FirstNumberGmobile11.contains(_firstPhone)) return null;
  //   }

  //   if (text.length == 10) {
  //     int _firstPhone = int.parse(text.substring(0, 3).trim());
  //     if (FirstNumberViettel10.contains(_firstPhone) ||
  //         FirstNumberVinaPhone10.contains(_firstPhone) ||
  //         FirstNumberMobifone10.contains(_firstPhone) ||
  //         FirstNumberVietnammobile10.contains(_firstPhone) ||
  //         FirstNumberGmobile10.contains(_firstPhone)) return null;
  //   }

  //   return "Số điện thoại không hợp lệ";
  // }

  static bool isValiPassportl(String? passport) {
    return RegExp(PASSPORT).hasMatch(passport!);
  }

  static String? password(String? text) {
    final maxLength = 128;
    final minLength = 6;
    final pattern = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    // if (!pattern.hasMatch(text!)) {
    //   return "Phải chứa ít nhất 1 chữ hoa, 1 số,1 kí tự đặc biệt. ";
    // }

    if (Utils.isNullOrEmpty(text)) {
      return "Mật khẩu không được để trống";
    }
    if (text!.length < minLength) {
      return _minLengthFormat("Mật khẩu phải lớn hơn $minLength kí tự", minLength);
    }
    if (text.length > maxLength) {
      return _maxLengthFormat("Mật khẩu phải ít hơn $maxLength kí tư", maxLength);
    }
    return null;
  }

  static String? username(String? text) {
    final maxLength = 50;
    final minLength = 6;

    if (Utils.isNullOrEmpty(text)) {
      return "Tên không được để trống";
    }
    // } else if (text.length < minLength) {
    //   return _minLengthFormat("Tên phải lớn hơn $minLength kí tự", minLength);
    // } else if (text.length > maxLength) {
    //   return _maxLengthFormat("Tên người dùng phải ít hơn $maxLength ký tự", maxLength);
    // } else if (!isContainAccent(text)) return "Số điện thoại không hợp lệ";
    return null;
  }

  static String? numberValidate(String? text) {
    if (Utils.isNullOrEmpty(text)) {
      return "Không được để trống";
    }
    if (!RegExp(ONLY_NUMBER).hasMatch(text!)) {
      return "Không đúng định dạng";
    }
    return null;
  }

  static String? birthdayValidate(String? text) {
    if (Utils.isNullOrEmpty(text)) {
      return "Ngày sinh không được để trống";
    }

    DateTime _time = DateTime.now().subtract(Duration(days: 365 * 18));

    if (DateTime.parse(text!).compareTo(_time) > 0) {
      return "Bạn chưa đủ 18 tuổi.";
    }

    return null;
  }

  // static String? fullName(String text) {
  //   final maxLength = 100;
  //   final minLength = 6;

  //   if (text.isEmpty) {
  //     return "Tên không được để trống";
  //   } else if (text.length < minLength) {
  //     return _minLengthFormat("Tên phải lớn hơn $minLength kí tự", minLength);
  //   } else if (text.length > maxLength) {
  //     return _maxLengthFormat("Tên người dùng phải ít hơn $maxLength ký tự", maxLength);
  //   }

  //   if (!RegExp(ONLY_CHARACTER).hasMatch(convertStringVi(text.trim()))) {
  //     return "Họ và tên không được chứa ký tự đặ biệt";
  //   }

  //   return null;
  // }

  static String? firstName(String text) {
    final maxLength = 50;
    if (text.isEmpty) {
      return "Tên không được để trống";
    }
    if (text.length > maxLength) {
      return _maxLengthFormat("Tên phải ít hơn $maxLength ký tự", maxLength);
    }
    return null;
  }

  static String? lastName(String text) {
    final maxLength = 50;
    if (text.isEmpty) {
      return "Họ không được để trống";
    }
    if (text.length > maxLength) {
      return _maxLengthFormat("Họ phải ít hơn $maxLength ký tự", maxLength);
    }
    return null;
  }

  static bool isValidName(String? name) {
    return !RegExp(ONLY_LETTER).hasMatch(name!);
  }

  static String? zaloName(String? text) {
    final minLength = 8;
    final maxLength = 16;
    if (Utils.isNullOrEmpty(text)) {
      return null;
    }
    if (text!.length > maxLength) {
      return _maxLengthFormat("Tên phải ít hơn $maxLength ký tự", maxLength);
    }

    if ((text.length) < minLength) {
      return _minLengthFormat("Tên phải lớn hơn $minLength kí tự", minLength);
    }
    return null;
  }

  static String? telegramName(String? text) {
    final minLength = 8;
    final maxLength = 25;
    if (Utils.isNullOrEmpty(text)) {
      return null;
    }
    if (text!.length > maxLength) {
      return _maxLengthFormat("Tên phải ít hơn $maxLength ký tự", maxLength);
    }

    if ((text.length) < minLength) {
      return _minLengthFormat("Tên phải lớn hơn $minLength kí tự", minLength);
    }
    return null;
  }

  static String? profilePath(String? text) {
    final minLength = 4;
    final maxLength = 16;
    String _registerUrl = "";
    String _getLanguage = "";

    // if (walletI18n.locale.languageCode.toLowerCase() == 'vi') {
    //   _getLanguage = 'vi';
    // } else {
    //   _getLanguage = 'en';
    // }

    // _registerUrl = Utils.prepareRequestClientSideUrl("$_getLanguage/profile/");

    if (Utils.isNullOrEmpty(text)) {
      return 'Không được để chống';
    }

    if (text!.length > (_registerUrl.length + maxLength)) {
      return _maxLengthFormat("Tên phải ít hơn $maxLength ký tự", maxLength);
    }

    if ((text.length) < (_registerUrl.length + minLength)) {
      return _minLengthFormat("Tên phải lớn hơn $minLength kí tự", minLength);
    }
    return null;
  }

  static String? bio(String? text) {
    final maxLength = 500;
    final minLength = 10;
    if (Utils.isNullOrEmpty(text)) {
      return null;
    }
    if ((text!.length) > maxLength) {
      return _maxLengthFormat("Họ phải ít hơn $maxLength ký tự", maxLength);
    }
    if ((text.length) < minLength) {
      return _minLengthFormat("Tên phải lớn hơn $minLength kí tự", minLength);
    }
    return null;
  }

  static String? bankName(String text) {
    final maxLength = 250;
    if (text.isEmpty) {
      return 'Không được để chống';
    }
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(text)) {
      return "Tên ngân hàng chỉ có thể là các chữ cái và không dấu";
    }

    if (text.length > maxLength) {
      return _maxLengthFormat("Tên phải ít hơn $maxLength ký tự", maxLength);
    }
    return null;
  }

  static String? accountNameInBank(String text) {
    final maxLength = 100;
    if (text.isEmpty) {
      return 'Không được để chống';
    }
    if (!isContainAccent(text)) {
      return "Tên tài khoản chỉ có thể là các chữ cái và không dấu";
    }

    if (text.length > maxLength) {
      return _maxLengthFormat("Tên tài khoản phải ít hơn $maxLength ký tự.", maxLength);
    }
    return null;
  }

  static String? validatorAccountBankNumber(String? value) {
    if (value != null && (value.length < 5)) {
      return _minLengthFormat("Số tài khoản phải lớn hơn 5 ký tự.", 5);
    }
    if (value != null && (value.length > 17)) {
      return _maxLengthFormat("Số tài khoản phải ít hơn 17 ký tự.", 17);
    }
    return Validator.isNotBlank(value!);
  }

  static String? validatorBranchBankName(String? value) {
    if (value != null && (value.length > 100)) {
      return _maxLengthFormat("Tên ngân hàng phải ít hơn 100 ký tự.", 100);
    }
    return Validator.isNotBlank(value!);
  }

  static String? confirmPassword(String password, String text) {
    if (text.isEmpty) {
      return "Mật khẩu không được để trống";
    }
    if (text != password) {
      return "Không khớp với mật khẩu";
    }
    return null;
  }

  static String? isNotBlank(String text) {
    if (text.isEmpty) {
      return 'Không được để chống';
    }
    return null;
  }

  static String? generalMaxLength(String text, int maxLength) {
    if (text.length > maxLength) {
      return _maxLengthFormat("Độ dài văn bản không được vượt quá $maxLength ký tự", maxLength);
    }
    return null;
  }

  static String? lowerBound(int? number, int lowerBound) {
    if (number == null) {
      return _lowerBoundFormat("Vui lòng nhập một số bằng hoặc lớn hơn $lowerBound", lowerBound);
    }
    if (number < lowerBound) {
      return _lowerBoundFormat("Vui lòng nhập một số bằng hoặc lớn hơn $lowerBound", lowerBound);
    }
    return null;
  }

  static String? upperBound(int? number, int upperBound) {
    if (number == null) {
      return _upperBoundFormat("Vui lòng nhập một số bằng hoặc nhỏ hơn $upperBound", upperBound);
    }
    if (number > upperBound) {
      return _upperBoundFormat("Vui lòng nhập một số bằng hoặc nhỏ hơn $upperBound", upperBound);
    }
    return null;
  }

  static String _lowerBoundFormat(String s, int lowerBound) {
    return s.replaceAll("{_lowerBound_}", lowerBound.toString());
  }

  static String _upperBoundFormat(String s, int upperBound) {
    return s.replaceAll("{_upperBound_}", upperBound.toString());
  }

  static String _minLengthFormat(String s, int min) {
    return s.replaceAll("{_minLength_}", min.toString());
  }

  static String _maxLengthFormat(String s, int max) {
    return s.replaceAll("{_maxLength_}", max.toString());
  }

  static int getStrengthPassword(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r"[a-z]"))) strength++;
    if (password.contains(RegExp(r"[A-Z]"))) strength++;
    if (password.contains(RegExp(r"[0-9]"))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;
    return strength;
  }
}
