import 'package:dio/dio.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/services/app_data_service.dart';
import 'package:newbug/core/stores/app_stores.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    super.onRequest(options, handler);
    // options.headers["User-Agen"] = "";
    // options.headers["Accept-Encoding"] = "gzip";
    // options.headers["platfrom"] = Platform.isAndroid ? "android" : "ios";
    // options.headers["app-src"] = Platform.isAndroid ? "googleplay" : "";
    // options.headers["Connection"] = "keep-alive";
    // options.headers["Content-Type"] = "application/json";

    options.headers["X-Encrypted"] = "${App.isHttpEncrypt}";

    ///版本语言
    options.headers["version-name"] = AppDataService.to.appVersion;

    ///app name
    options.headers["app-name"] = AppDataService.to.appName;
    options.headers["app-channel"] = AppDataService.to.appName;

    ///版本号
    options.headers["version-code"] = AppDataService.to.buildNumber;

    ///是否开启代理或者VPN（1 打开 0没有打开）
    options.headers["x-proxy-f"] = "0";

    ///系统语言
    options.headers["local"] = AppDataService.to.local;

    ///时区
    options.headers["time-zero"] = AppDataService.to.timeZone;

    ///adjust id
    options.headers["ad-id"] = AppStores.getAdjustID();

    ///移动设备品牌
    options.headers["mb-brand"] = AppDataService.to.brand;

    ///移动设备型号
    options.headers["mb-models"] = AppDataService.to.model;

    ///设备系统版本
    options.headers["ob-osversion"] = AppDataService.to.osVersion;

    ///设备id
    // options.headers["dev-id"] = AppDataService.to.deviceid;
    options.headers["dev-id"] = "${AppDataService.to.deviceid}123";

    ///todo 1c9a2b6888f94b1cab921a4019e384fc
    ///todo a114e1a8b533fee162b4bb1f43dbc550653ae49dda026d8c509f011d19741a07

    ///用户id
    // options.headers["UserId"] = AppStores.getUid();

    ///Authorization
    options.headers["Authorization"] = AppStores.getAuthorization() ?? "";

    /*options.headers["Authorization"] =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NjM4OTA2ODAsImlhdCI6MTc2MTIxMjI4MCwicGxhdCI6MSwidXNlcklkIjoxMDAxMTAzMX0.HgWQSkk2XHbBkY1CnPo86zuM-To9tYALDmo-m4GFaHU";
*/

    //debugPrint("headers => ${options.headers}");
  }
}
