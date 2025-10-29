import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get timeFormatted => DateFormat('HH:mm:ss').format(this);
}

///时间戳转换为格式：13 Feb 7:30 PM
extension TimestampExtension on int {
  String get timestampFormatted => DateFormat(
    'dd MMM h:mm a',
  ).format(DateTime.fromMillisecondsSinceEpoch(this * 1000));
}
