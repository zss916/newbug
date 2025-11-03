import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/services/app_config_service.dart';
import 'package:newbug/core/services/app_data_service.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/stores/stores_service.dart';

class Global {
  /// init
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    ///adjust
    //AdjustTools.init();

    await Get.putAsync<AppConfigService>(() => AppConfigService().init());

    await Future.wait([
      Get.put<StoresService>(StoresService()).init(),
      Get.putAsync<AppDataService>(() => AppDataService().init()),
    ]).whenComplete(() async {
      Get.put<EventService>(EventService());
    });
  }
}

/// fonts
class AppFonts {
  static const String font1 = 'font1';
  static const String font2 = 'font2';
}
