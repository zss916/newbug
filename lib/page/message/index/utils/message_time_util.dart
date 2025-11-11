import 'package:intl/intl.dart';

class MessageTimeUtil {
  //获取会话显示时间
  static String convertConversationTime(int millis) {
    String timeText = "";
    Intl.defaultLocale = 'en_US';
    DateTime messageDate = DateTime.fromMillisecondsSinceEpoch(millis);
    DateFormat formatter;

    if (isSameYear(messageDate)) {
      if (isSameMonth(messageDate)) {
        int intervalDays = getIntervalDays(messageDate);
        if (intervalDays == 0) {
          formatter = DateFormat.Hm();
          return timeText = formatter.format(messageDate);
        } else if (intervalDays == 1) {
          return timeText = "Yesterday";
        } else if (intervalDays < 7 && isCurrentWeek(messageDate)) {
          formatter = DateFormat.EEEE();
          return timeText = formatter.format(messageDate);
        } else {
          formatter = DateFormat.Md();
          return timeText = formatter.format(messageDate);
        }
      }
      formatter = DateFormat.Md();
      return timeText = formatter.format(messageDate);
    }
    formatter = DateFormat.yMd();
    return timeText = formatter.format(messageDate);
  }

  static bool isSameYear(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year;
  }

  static bool isSameMonth(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  static int getIntervalDays(DateTime date) {
    final Duration duration = DateTime.now().difference(date);
    final int diffDays =
        duration.inDays +
        (duration.inMinutes >
                DateTime.now()
                    .difference(
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),
                    )
                    .inMinutes
            ? 1
            : 0);
    return diffDays;
  }

  static bool isCurrentWeek(DateTime date) {
    DateTime now = DateTime.now();
    int currentWeek =
        now
            .difference(
              DateTime(now.year, now.month, now.day - now.weekday + 1),
            )
            .inDays ~/
        7;
    int targetWeek =
        date
            .difference(
              DateTime(date.year, date.month, date.day - date.weekday + 1),
            )
            .inDays ~/
        7;
    return currentWeek == targetWeek;
  }

  /*static String convertTimestampToString(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat dateFormatter = DateFormat('d MMMM yyyy, H:mm', 'en_US');
    String dateString = dateFormatter.format(dateTime);
    return dateString;
  }*/
}
