import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:newbug/core/network/utils/device_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:time_zone_plus/time_zone_plus.dart';

class AppDataService extends GetxService {
  static AppDataService get to => Get.find();
  late String appVersion;
  late String appName;
  late String buildNumber;
  late String model;
  late String brand;
  late String deviceid;
  late String osVersion;
  late String local;
  late String timeZone;

  Future<AppDataService> init() async {
    local =
        "${Get.deviceLocale?.languageCode}_${Get.deviceLocale?.countryCode}";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    appName = packageInfo.appName;
    buildNumber = packageInfo.buildNumber;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    brand = deviceInfo.brand;
    model = deviceInfo.model;
    osVersion = deviceInfo.version.release;
    timeZone = TimeZonePlus.getCurrentTimeZone() ?? "";
    deviceid = await DeviceUtils.getDeviceID();
    return this;
  }
}
