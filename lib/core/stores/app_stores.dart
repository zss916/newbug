import 'dart:convert';

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
      StoresService.to.setString(userKey, jsonEncode(value));
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
  /*static int? getUid() {
    return UserEntity.fromJson(
      jsonDecode(StoresService.to.getString(userKey)),
    ).userId;
  }*/

  ///设置是否完成引导
  static void setGuideStatus({required bool isFinishGuide}) {
    StoresService.to.setBool(finishGuideKey, isFinishGuide);
  }

  ///获取是否完成引导
  static bool getGuideStatus() {
    return StoresService.to.getBool(finishGuideKey);
  }
}
