import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/cache/image_cache.dart';
import 'package:newbug/core/im/cv_im.dart';
import 'package:newbug/core/push/push_tools.dart';
import 'package:newbug/core/services/app_config_service.dart';
import 'package:newbug/core/services/app_data_service.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/stores/stores_service.dart';

class Global {
  /// init
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    ImageCacheHelper.setImageCache();

    ///adjust
    //AdjustTools.init();

    ///IM 初始化
    CvIM.init();
    //await Get.put<ImService>(ImService()).init();
    /// push 初始化
    PushTools.init();

    //PurchaseTools
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
