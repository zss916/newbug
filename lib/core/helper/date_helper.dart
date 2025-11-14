import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// HH:mm:ss
  String get timeFormatted => DateFormat('HH:mm:ss').format(this);

  /// yyyy-MM-dd
  String get dateFormatted => DateFormat('yyyy-MM-dd').format(this);

  //计算年龄
  int get calculateAge {
    final now = DateTime.now().toUtc();
    final birthDate = toUtc();

    if (birthDate.isAfter(now)) return 0;

    int age = now.year - birthDate.year;
    final monthDiff = now.month - birthDate.month;
    final dayDiff = now.day - birthDate.day;

    if (monthDiff < 0 || (monthDiff == 0 && dayDiff < 0)) {
      age--;
    }
    return age;
  }
}

extension TimestampExtension on int {
  ///时间戳转换为格式：13 Feb 7:30 PM
  String get timestampFormatted2 => DateFormat(
    'dd MMM h:mm a',
  ).format(DateTime.fromMillisecondsSinceEpoch(this * 1000));

  String get timestampFormatted => DateFormat(
    'yyyy-MM-dd HH:mm:ss',
  ).format(DateTime.fromMillisecondsSinceEpoch(this));

  String get formatted => NumberFormat('00').format(this);

  String get msgTime => DateFormat(
    'hh:mm:ss',
  ).format(DateTime.fromMillisecondsSinceEpoch(this * 1000));
}
