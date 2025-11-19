import 'dart:convert';

import 'package:newbug/core/network/model/auth_entity.dart';
import 'package:newbug/core/network/model/config_entity.dart';
import 'package:newbug/core/network/model/location_entity.dart';
import 'package:newbug/core/network/model/tag_entity.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/stores/stores_service.dart';

class AppStores {
  static const String cvAdjustAdjustId = "cv_adjust_adjust_id";
  static const String authorizationKey = "cvAuthorizationKey";
  //static const String uidKey = "cvUserIdKey";
  static const String userKey = "cvUserInfoKey";
  static const String finishGuideKey = "cvFinishGuideKey";
  static const String tagsListKey = "cvTagsListKey";
  static const String authKey = "cvAuthKey";
  static const String appConfigKey = "cvAppConfigKey";
  static const String appLocationKey = "appLocationKey";

  ///保存是否显示定位弹窗
  static void setNeedShowLocationDialog({required bool needShow}) {
    StoresService.to.setBool(appLocationKey, needShow);
  }

  ///获取是否显示
  static bool getNeedShowLocationDialog() {
    return StoresService.to.getBool(appLocationKey);
  }

  ///设置config
  static void setAppConfig({required ConfigEntity value}) {
    StoresService.to.setString(appConfigKey, jsonEncode(value.toJson()));
  }

  ///获取config
  static ConfigEntity getAppConfig() {
    return ConfigEntity.fromJson(
      jsonDecode(StoresService.to.getString(appConfigKey)),
    );
  }

  /// 设置adjustID
  static void setAdjustID({required String adjustID}) {
    StoresService.to.setString(cvAdjustAdjustId, adjustID);
  }

  /// 获取adjustID
  static String getAdjustID() {
    return StoresService.to.getString(cvAdjustAdjustId);
  }

  ///设置 user info
  static void setUserInfo({UserEntity? value}) {
    if (value != null) {
      StoresService.to.setString(userKey, jsonEncode(value.toJson()));
    }
  }

  ///获取 user info
  static UserEntity? getUserInfo() {
    String value = StoresService.to.getString(userKey);
    if (value.isNotEmpty) {
      return UserEntity.fromJson(jsonDecode(value));
    } else {
      return null;
    }
  }

  ///保存定位地址
  static bool setLocationInfo({LocationEntity? locationInfo}) {
    UserEntity? value = getUserInfo();
    if (value != null) {
      setUserInfo(value: value..locationInfo = locationInfo);
      return true;
    } else {
      return false;
    }
  }

  ///获取定位地址
  static LocationEntity? getLocationInfo() {
    UserEntity? value = getUserInfo();
    if (value != null) {
      return value.locationInfo;
    } else {
      return null;
    }
  }

  ///设置 auth
  static void setAuthData({AuthEntity? value}) {
    if (value != null) {
      StoresService.to.setString(authKey, jsonEncode(value));
    }
  }

  ///设置 tag list
  static void setTagsList({required List<TagEntity> data}) {
    List<String> list = data.map((e) => e.toString()).toList();
    StoresService.to.setList(tagsListKey, list);
  }

  ///获取 tag list
  static List<TagEntity> getTagsList() {
    List<String> list = StoresService.to.getList(tagsListKey);
    return list.map((e) => TagEntity.fromJson(jsonDecode(e))).toList();
  }

  ///删除user info
  static void removeUserInfo() {
    StoresService.to.remove(userKey);
  }

  ///删除所有数据
  static void removeAllData() {
    StoresService.to.clear();
  }

  /// 获取Authorization
  static String? getAuthorization() {
    String value = StoresService.to.getString(authKey);
    if (value.isNotEmpty) {
      return AuthEntity.fromJson(jsonDecode(value)).authToken;
    } else {
      return null;
    }
  }

  ///获取IM token
  static String? getIMToken() {
    String value = StoresService.to.getString(authKey);
    if (value.isNotEmpty) {
      return AuthEntity.fromJson(jsonDecode(value)).imToken;
    } else {
      return null;
    }
  }

  ///获取user id
  static int? getUid() {
    String value = StoresService.to.getString(userKey);
    if (value.isNotEmpty) {
      return UserEntity.fromJson(jsonDecode(value)).userId;
    } else {
      return null;
    }
  }

  ///设置是否完成引导
  static void setGuideStatus({required bool isFinishGuide}) {
    StoresService.to.setBool(finishGuideKey, isFinishGuide);
  }

  ///获取是否完成引导
  static bool getGuideStatus() {
    return StoresService.to.getBool(finishGuideKey);
  }

  ///保存缩略图
  static void setThumb({required String key, required String value}) {
    StoresService.to.setString("$key-cv-thumb", value);
  }

  ///获取缩略图
  static String getThumb({required String key}) {
    return StoresService.to.getString("$key-cv-thumb");
  }
}
