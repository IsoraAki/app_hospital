import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class DateFormatter {
  static final String DEFAULT_MONTH_DAY_YEAR = "MMM d, yyyy";
  static final String DEFAULT_MONTH_DAY_YEAR_VI = "dd/MM/yyyy";

  static final String DEFAULT_DAY_MONTH_YEAR = "d MMM, yyyy";
  static final String DEFAULT_DAY_MONTH_YEAR_VI = "d MMM, yyyy";

  static final String DEFAULT_MONTH_DAY_YEAR_TIME = "MMM d, yyyy - HH:mma";
  static final String DEFAULT_MONTH_DAY_YEAR_TIME_VI = "dd/MM/yyyy - HH:mm";

  static final String MONTH_DAY_YEAR_TIME = "MMM d, yyyy 'at' HH:mma";
  static final String MONTH_DAY_YEAR_TIME_VI = "dd/MM/yyyy - HH:mm";

  static final String DEFAULT_TIME_NOT_SECOND = "HH:mma";
  static final String DEFAULT_TIME_NOT_SECOND_VI = "HH:mm";

  static final String DEFAULT_NOT_SECOND_DATE_FORMAT = "yyyy-MM-dd HH:mm";
  static final String DEFAULT_NOT_SECOND_DATE_FORMAT_VI = "yyyy-MM-dd HH:mm";

  static final String DEFAULT_DATE_FORMAT = "HH:mm dd-MM-yyyy";
  static final String SHORT_DATE_FORMAT = "yyyy-MM-dd";
  static final String SHORT_DATE_FORMAT_VI = "yyyy-MM-dd";
  static final String NORMAL_DATE_FORMAT = "dd-MM-yyyy";
  static final String DISPLAY_DATE_FORMAT = "dd/MM/yyyy";
  static final String DAY_OF_WEEK = "EE, dd MMM";

  static final String DAY_OF_WEEK_MONTH = "EEE, dd/MM/yyyy";
  static final String DAY_OF_WEEK_MONTH_VI = "EEE, dd 'tháng' MM yyyy";

  static final String DAY_OF_WEEK_DEFAULT = "dd MMM yyyy";
  static final String DAY_MONTH_VN = "dd MMM";
  static final String DAY_MONTH_YEAR_VN = "dd MMM yyyy";
  static final String DEFAULT_DATE_FORMAT_VN = "HH:mm, dd MMM yyyy";
  static final String DATE_FORMAT_ZONE = "yyyy-MM-dd'T'HH:mm:ss'.000Z'";
  static final String DATE_FORMAT_ZONE_NOT_Z = "yyyy-MM-dd HH:mm:ss'.000'";
  static final String HOUR_MINUTE_FORMAT = "HH:mm";

  static final String YEAR_NUM_MONTH_WEEKDAY_DAY = "yMEd";
  static final String YEAR_NUM_MONTH_WEEKDAY_DAY_VI = "yMEd";

  static final List listDateFormatter = [
    DEFAULT_MONTH_DAY_YEAR_TIME,
    DEFAULT_MONTH_DAY_YEAR_TIME_VI,
    MONTH_DAY_YEAR_TIME,
    MONTH_DAY_YEAR_TIME_VI,
    DEFAULT_MONTH_DAY_YEAR,
    DEFAULT_MONTH_DAY_YEAR_VI,
    DEFAULT_DAY_MONTH_YEAR,
    DEFAULT_DAY_MONTH_YEAR_VI,
    DEFAULT_TIME_NOT_SECOND,
    DEFAULT_TIME_NOT_SECOND_VI,
    DEFAULT_NOT_SECOND_DATE_FORMAT,
    DEFAULT_NOT_SECOND_DATE_FORMAT_VI,
    DAY_OF_WEEK_MONTH,
    DAY_OF_WEEK_MONTH_VI,
    YEAR_NUM_MONTH_WEEKDAY_DAY,
    YEAR_NUM_MONTH_WEEKDAY_DAY_VI,
    SHORT_DATE_FORMAT,
    SHORT_DATE_FORMAT_VI,
  ];

  static DateTime parseStringToDateTime(String? time) {
    return time != null
        ? DateTime.parse(
            time.replaceAll(new RegExp(r'/'), '-'),
          )
        : DateTime.now();
  }

  DateTime coverTime(String datetime) {
    DateTime serverDatetime = DateTime.parse(datetime.replaceAll(RegExp(r'/'), '-'));

    ///Funtion 1
    // DateTime localDatetime = DateTime.now();
    //
    // var timezoneOffset = localDatetime.timeZoneOffset;
    // var timeDiff = new Duration(hours: timezoneOffset.inHours, minutes: timezoneOffset.inMinutes % 60);

    // log("Time cover1: $value");
    // log("Time cover2: ${serverDatetime.add(timeDiff)}");

    // return serverDatetime.add(timeDiff);

    ///Funtion 2
    //DateTime value = serverDatetime.toLocal();
    final pacificTimeZone = tz.getLocation('Asia/Ho_Chi_Minh');
    DateTime value = tz.TZDateTime.from(serverDatetime, pacificTimeZone);
    return value;
  }

  // static String formatTimeLocate(String dateFormatterName, DateTime dateTime) {
  //   if (u2uText.locale.languageCode == "vi") {
  //     final String value = listDateFormatter.firstWhere((element) => element == dateFormatterName).toString();
  //     return '${DateFormat(listDateFormatter[listDateFormatter.indexOf(value) + 1], 'vi').format(dateTime)}';
  //     // return '${DateFormat(listDateFormatter[listDateFormatter.indexOf(value) + 1], 'en_US').format(dateTime)}';
  //   } else {
  //     final String value = listDateFormatter.firstWhere((element) => element == dateFormatterName).toString();
  //     return '${DateFormat(value, 'en_US').format(dateTime)}';
  //   }
  // }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

extension DurationFormatter on Duration {
  /// Returns a day, hour, minute, second string representation of this `Duration`.
  ///
  ///
  /// Returns a string with days, hours, minutes, and seconds in the
  /// following format: `dd:HH:MM:SS`. For example,
  ///
  ///   var d = new Duration(days:19, hours:22, minutes:33);
  ///    d.dayHourMinuteSecondFormatted();  // "19:22:33:00"
  String dayHourMinuteSecondFormatted() {
    return [inDays, inHours.remainder(24), inMinutes.remainder(60), inSeconds.remainder(60)].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }

  String minuteSecondFormatted() {
    return [
      inMinutes.remainder(60),
      inSeconds.remainder(60),
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }
}

extension DateTimeFormatter on DateTime {
  static final String DEFAULT_MONTH_DAY_YEAR = "MMM d, yyyy";
  static final String DEFAULT_MONTH_DAY_YEAR_VI = "dd/MM/yyyy";

  static final String DEFAULT_DAY_MONTH_YEAR = "d MMM, yyyy";
  static final String DEFAULT_DAY_MONTH_YEAR_VI = "d MMM, yyyy";

  static final String DEFAULT_MONTH_DAY_YEAR_TIME = "MMM d, yyyy - HH:mma";
  static final String DEFAULT_MONTH_DAY_YEAR_TIME_VI = "dd/MM/yyyy - HH:mm";

  static final String MONTH_DAY_YEAR_TIME = "MMM d, yyyy 'at' HH:mma";
  static final String MONTH_DAY_YEAR_TIME_VI = "dd/MM/yyyy HH:mm";

  static final String DEFAULT_TIME_NOT_SECOND = "HH:mma";
  static final String DEFAULT_TIME_NOT_SECOND_VI = "HH:mm";

  static final String DEFAULT_NOT_SECOND_DATE_FORMAT = "yyyy-MM-dd HH:mm";
  static final String DEFAULT_NOT_SECOND_DATE_FORMAT_VI = "yyyy-MM-dd HH:mm";

  static final String DEFAULT_DATE_FORMAT = "HH:mm dd-MM-yyyy";
  static final String SHORT_DATE_FORMAT = "yyyy-MM-dd";
  static final String NORMAL_DATE_FORMAT = "dd-MM-yyyy";
  static final String DISPLAY_DATE_FORMAT = "dd/MM/yyyy";
  static final String DAY_OF_WEEK = "EE, dd MMM";

  static final String DAY_OF_WEEK_MONTH = "EEE, dd/MM/yyyy";
  static final String DAY_OF_WEEK_MONTH_VI = "EEE, dd 'tháng' MM yyyy";

  static final String DAY_OF_WEEK_DEFAULT = "dd MMM yyyy";
  static final String DAY_MONTH_VN = "dd MMM";
  static final String DAY_MONTH_YEAR_VN = "dd MMM yyyy";
  static final String DEFAULT_DATE_FORMAT_VN = "HH:mm, dd MMM yyyy";
  static final String DATE_FORMAT_ZONE = "yyyy-MM-dd'T'HH:mm:ss'.000Z'";
  static final String DATE_FORMAT_ZONE_NOT_Z = "yyyy-MM-dd HH:mm:ss'.000'";
  static final String HOUR_MINUTE_FORMAT = "HH:mm";

  static final String YEAR_NUM_MONTH_WEEKDAY_DAY = "yMEd";
  static final String YEAR_NUM_MONTH_WEEKDAY_DAY_VI = "yMEd";

  static final String DISPLAY_DATE_TIME_FORMAT = 'dd/MM/yyyy, HH:mm';

  static final String DEFAULT_DATE_FORMAT_FLIGHT_SEARCH = "yyyy-MM-dd";
  static final String DATE_FORMAT_FLIGHT_APP_BAR = "EEE, dd/MM";

  String shortTimeFormatted() {
    return DateFormat(
      'h:mm a',
    ).format(this);
  }

  String shortTimeDefaultFormatted() {
    return DateFormat(
      DEFAULT_TIME_NOT_SECOND_VI,
    ).format(this);
  }

  String shortDateFormatted() {
    return DateFormat(
      SHORT_DATE_FORMAT,
    ).format(this);
  }

  String dateDisplayFormatted() {
    return DateFormat(
      DISPLAY_DATE_FORMAT,
    ).format(this);
  }

  String dateTimeDisplayFormatted() {
    return DateFormat(
      DISPLAY_DATE_TIME_FORMAT,
    ).format(this);
  }

  String dateFlightSearchFormatted() {
    return DateFormat(
      DEFAULT_DATE_FORMAT_FLIGHT_SEARCH,
    ).format(this);
  }

  String dateMonyhDayTimeViFormatted() {
    return DateFormat(
      MONTH_DAY_YEAR_TIME_VI,
    ).format(this);
  }

  String shortMonthDateFormatted() {
    return DateFormat(
      DISPLAY_DATE_FORMAT,
    ).format(this);
  }

  // String dateFlightAppBarFormatted() {
  //   return DateFormat(DATE_FORMAT_FLIGHT_APP_BAR, u2uText.locale.languageCode == "vi" ? 'vi' : 'en_US').format(this);
  // }

  String fromNowLimit({int dayDiff = 1}) => DateTime.now().difference(this).inDays > dayDiff ? shortDateFormatted() : shortTimeFormatted();

  bool isSameDay(DateTime? b) {
    if (b == null) {
      return false;
    }
    return year == b.year && month == b.month && day == b.day;
  }

  static DateTime parseStringToDateTime(String? time) {
    return time != null
        ? DateTime.parse(
            time.replaceAll(RegExp(r'/'), '-'),
          )
        : DateTime.now();
  }
}
