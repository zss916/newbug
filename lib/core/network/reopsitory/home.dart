import 'package:flutter/foundation.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/model/location_entity.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/network/path/netPath.dart';
import 'package:newbug/core/widget/index.dart';

abstract class HomeAPI {
  ///首页用户卡片
  static Future<HomeCardsEntity?> getHomeSwiperCards({
    required int tab,
    String? lastId,
  }) async {
    try {
      ///feed 0,home 1
      Map<String, dynamic> data = {"size": 10, "tab": tab};
      if (lastId != null) {
        data["last_ids"] = lastId;
      }
      final result = await Net.instance.post(
        ApiPath.homeSwiperCards,
        queryParameters: data,
      );
      if (result["code"] == 0) {
        /*List<HomeCardsMatchList> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => HomeCardsMatchList.fromJson(e)).toList(),
          (result['data']['match_list'] as List),
        );*/

        HomeCardsEntity value = await compute(
          (dynamic jsonStr) => HomeCardsEntity.fromJson(jsonStr),
          result["data"],
        );

        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///选择卡片
  /// @param type 1:pass 2:like
  /// @param userId 用户id
  /// @param from 参考类FromType 来源：1:首页-match列表 2：likes-wholikeme 3：like-cupidchat 4：like-youlike 5：聊天界面 6：个人主页 7：flashchat页面 8：matched页面 9：来自后端推荐模块 10：来自系统通知:
  /// card_flag 0非关系卡片，1关系卡片
  /// @param trace 记录图片加载时间
  static Future<Right?> chooseCard({
    required int type,
    required int userId,
    required int from,
    String? trace,
    int cardFlag = 0,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data["type"] = type;
      data["user_id"] = userId;
      data["from"] = from;
      data["card_flag"] = cardFlag;
      if (trace != null) {
        data["trace"] = trace;
      }
      final result = await Net.instance.post(
        ApiPath.cardChoose,
        queryParameters: data,
      );
      if (result["code"] == 0) {
        Right value = await compute(
          (dynamic jsonStr) => Right.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///flash chat
  /// @param userId 用户id
  /// @param from 参考类FromType 来源：1:首页-match列表 2：likes-wholikeme 3：like-cupidchat 4：like-youlike 5：聊天界面 6：个人主页 7：flashchat页面 8：matched页面 9：来自后端推荐模块 10：来自系统通知:
  /// @param msg 消息内容
  static Future<bool> flashChat({
    required int userId,
    required int from,
    required String msg,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data["user_id"] = userId;
      data["from"] = from;
      data["msg"] = msg;
      final result = await Net.instance.post(
        ApiPath.flashChat,
        queryParameters: data,
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///上报位置、通知权限
  static Future<LocationEntity?> updateSwitch({
    required int locationStatus,
    required int noticeStatus,
    required String timeZero,
    double? latitude,
    double? longitude,
  }) async {
    try {
      Map<String, dynamic> data = {
        'location_status': locationStatus,
        'notice_status': noticeStatus,
        'time_zero': timeZero,
      };
      if (latitude != null && longitude != null) {
        data['latitude'] = latitude;
        data['longitude'] = longitude;
      }

      final result = await Net.instance.post(
        ApiPath.updateSwitch,
        queryParameters: data,
      );
      if (result["code"] == 0) {
        LocationEntity value = await compute(
          (dynamic jsonStr) => LocationEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///其他用户详情
  static Future<UserEntity?> otherProfile({required int userId}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.cardDetails,
        queryParameters: {"user_id": userId},
      );
      if (result["code"] == 0) {
        UserEntity value = await compute(
          (dynamic jsonStr) => UserEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///sayHi
  static Future<bool> toSayHi({
    required int userId,
    required String msg,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.sayHi,
        queryParameters: {"user_id": userId, "msg": msg},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }
}
