import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:flutter/material.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/stores/app_stores.dart';

class AdjustTools {
  ///todo 测试版本
  static bool isRelease = false;

  ///todo 测试版本
  static String adjustAppTokenDebug = 'zv6xxvhg8d1c';

  static void init() {
    AdjustConfig config = AdjustConfig(
      adjustAppTokenDebug,
      isRelease ? AdjustEnvironment.production : AdjustEnvironment.sandbox,
    );
    config.logLevel = AdjustLogLevel.verbose;
    Adjust.initSdk(config);
  }

  static void getAdjustId() {
    String? adjustId = AppStores.getAdjustID();
    if ((adjustId ?? '').isNotEmpty) {
      Net.instance.addHeaders(adjustID: adjustId ?? "");

      ///todo 上报adjustId
    } else {
      Adjust.getAdid().then((value) {
        debugPrint('adjustId: $value');
        if (value != null && value.isNotEmpty) {
          AppStores.setAdjustID(adjustID: value);
          Net.instance.addHeaders(adjustID: value);

          ///todo 上报adjustId
        } else {
          Future.delayed(Duration(seconds: 2), () {
            getAdjustId();
          });
        }
      });
    }
  }

  ///获取adjust信息
  static Future<void> updateAdjustInfo() async {
    final attribution = await Adjust.getAttribution();
    final map = {
      "tracker_name": attribution.trackerName ?? "",
      "network": attribution.network ?? "",
      "adgroup": attribution.adgroup ?? "",
      "click_label": attribution.clickLabel ?? "",
      "creative": attribution.creative ?? "",
    };
  }
}
