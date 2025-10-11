import 'package:flutter/cupertino.dart';

class App {
  static const String name = 'New Bag';

  static const Color primaryColor = Color(0xFFFF0092);

  static double getStatusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;
}
