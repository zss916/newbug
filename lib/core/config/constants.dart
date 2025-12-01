import 'package:flutter/cupertino.dart';

class App {
  static const String name = 'New Bag';

  static const Color primaryColor = Color(0xFFFF0092);

  static String contactUsEmail = "";

  static double getStatusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  ///todo 测试版本
  static String adjustToken = 'zv6xxvhg8d1c';
  static bool isAdjustRelease = false;
  static bool isHttpEncrypt = false;
}
