import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/stores/stores_service.dart';

class Global {
  /// init
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.wait([
      Get.put<StoresService>(StoresService()).init(),
    ]).whenComplete(() {
      Get.put<EventService>(EventService());
    });
  }
}

/// fonts
class AppFonts {
  static const String font1 = 'font1';
  static const String font2 = 'font2';
}
