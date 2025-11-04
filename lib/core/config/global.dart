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



/*"https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
          "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
          "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
          "https://img1.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
          "https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666",
          "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",*/
