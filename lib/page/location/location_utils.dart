import 'package:geolocator/geolocator.dart';
import 'package:newbug/core/network/model/location_entity.dart';
import 'package:newbug/core/network/reopsitory/home.dart';
import 'package:newbug/core/services/app_data_service.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/page/location/location_manager.dart';

class LocationUtils {
  static final LocationManager locationManager = LocationManager();

  ///获取定位
  static Future<void> toLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      AppStores.setNeedShowLocationDialog(needShow: true);
    } else {
      AppStores.setNeedShowLocationDialog(needShow: false);
    }

    locationManager
        .determinePosition()
        .then((value) {
          //上报位置信息
          updateLocation(
            1,
            latitude: value.latitude,
            longitude: value.longitude,
          );
        })
        .catchError((error) {
          updateLocation(0);
          //   _checkIfNeedShowLocationAlert();
        });
  }

  static updateLocation(
    int locationSwitch, {
    double? latitude,
    double? longitude,
  }) async {
    LocationEntity? value = await HomeAPI.updateSwitch(
      locationStatus: locationSwitch,
      noticeStatus: -1,
      timeZero: AppDataService.to.timeZone,
      latitude: latitude,
      longitude: longitude,
    );
    if (value != null && locationSwitch == 1) {
      AppStores.setLocationInfo(locationInfo: value);
    }
  }

  ///获取本地缓存登录信息
  static LocationEntity? getCacheLocationInfo() {
    return AppStores.getLocationInfo();
  }

  ///同步获取是否显示定位信息
  static bool isShowLocationSync(int location) {
    int statesId = getCacheLocationInfo()?.statesId ?? 0;
    String address = getCacheLocationInfo()?.address ?? "";
    if (statesId > 0 &&
        (statesId & location) == statesId &&
        address.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///异步获取是否显示定位信息
  static Future<bool> isShowLocationDelay(int location) async {
    bool value = await Geolocator.isLocationServiceEnabled();
    if (value == true) {
      int statesId = getCacheLocationInfo()?.statesId ?? 0;
      String address = getCacheLocationInfo()?.address ?? "";
      if (statesId > 0 &&
          (statesId & location) == statesId &&
          address.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
