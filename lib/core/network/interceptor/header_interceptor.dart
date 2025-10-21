import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newbug/core/services/app_data_service.dart';
import 'package:newbug/core/stores/app_stores.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    ///版本语言
    options.headers["version-name"] = AppDataService.to.appVersion;

    ///app name
    options.headers["app-name"] = AppDataService.to.appName;
    options.headers["app-channel"] = AppDataService.to.appName;

    ///版本号
    options.headers["version-code"] = AppDataService.to.buildNumber;

    ///固定
    options.headers["X-Encrypted"] = true;
    options.headers["Accept-Encoding"] = "gzip";
    options.headers["platfrom"] = Platform.isAndroid ? "android" : "ios";
    options.headers["Connection"] = "keep-alive";
    options.headers["Content-Type"] = "application/json";

    ///是否开启代理或者VPN（1 打开 0没有打开）
    options.headers["x-proxy-f"] = "0";

    ///系统语言
    options.headers["local"] = AppDataService.to.local;

    ///时区
    options.headers["time-zero"] = AppDataService.to.timeZone;

    ///adjust id
    options.headers["ad-id"] = AppStores.getAdjustID() ?? "";

    ///移动设备品牌
    options.headers["mb-brand"] = AppDataService.to.brand;

    ///移动设备型号
    options.headers["mb-models"] = AppDataService.to.model;

    ///设备系统版本
    options.headers["ob-osversion"] = AppDataService.to.osVersion;

    ///用户id
    // options.headers["UserId"] = "";

    ///设备id
    options.headers["dev-id"] = AppDataService.to.deviceid;

    // options.headers["User-Agen"] = "";
    //options.headers["app-src"] = "";

    ///Authorization
    // options.headers["Authorization"] = "";

    handler.next(options);
  }
}
