import 'dart:convert';

import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/stores/stores_service.dart';

class AppStores {
  static const String cvAdjustAdjustId = "cv_adjust_adjust_id";
  static const String authorizationKey = "cvAuthorizationKey";
  static const String uidKey = "cvUserIdKey";
  static const String userKey = "cvUserInfoKey";

  /// 设置adjustID
  static void setAdjustID({required String adjustID}) {
    StoresService.to.setString(cvAdjustAdjustId, adjustID);
  }

  /// 获取adjustID
  static String getAdjustID() {
    return StoresService.to.getString(cvAdjustAdjustId);
  }

  ///设置 user info
  static void setUserInfo({required UserEntity value}) {
    StoresService.to.setString(userKey, jsonEncode(value));
  }

  ///设置 user nickName
  static void setUserNickName({required String value}) {
    // String value = StoresService.to.getString(userKey);

    StoresService.to.setString(userKey, jsonEncode(value));
  }

  ///获取 user info
  static UserEntity getUserInfo() {
    return UserEntity.fromJson(jsonDecode(StoresService.to.getString(userKey)));
  }

  /// 获取Authorization
  static String? getAuthorization() {
    String value = StoresService.to.getString(userKey);
    if (value.isNotEmpty) {
      return UserEntity.fromJson(jsonDecode(value)).authToken;
    } else {
      return null;
    }
  }

  ///获取user id
  static int? getUid() {
    return UserEntity.fromJson(
      jsonDecode(StoresService.to.getString(userKey)),
    ).userId;
  }
}
