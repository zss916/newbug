import 'package:flutter/foundation.dart';
import 'package:newbug/core/network/model/online_user_entity.dart';
import 'package:newbug/core/network/model/private_msg_status_entity.dart';
import 'package:newbug/core/network/model/unread_data_entity.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/network/path/netPath.dart';
import 'package:newbug/core/widget/index.dart';

abstract class ChatAPI {
  ///批量获取用户信息
  static Future<(bool, List<UserEntity>)> getProfileList({
    required String ids,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.getProfileList,
        queryParameters: {"user_ids": ids},
      );
      if (result["code"] == 0) {
        List<UserEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => UserEntity.fromJson(e)).toList(),
          (result['data'] as List),
        );
        return (true, value);
      } else {
        CustomToast.fail("Failed");
        return (false, <UserEntity>[]);
      }
    } catch (error) {
      return (false, <UserEntity>[]);
    }
  }

  ///查询在线用户列表
  static Future<(bool, List<OnlineUserEntity>)> getOnlineList() async {
    try {
      final result = await Net.instance.post(ApiPath.getOnlineList);
      if (result["code"] == 0) {
        List<OnlineUserEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => OnlineUserEntity.fromJson(e)).toList(),
          (result['data'] as List),
        );
        return (true, value);
      } else {
        CustomToast.fail("Failed");
        return (false, <OnlineUserEntity>[]);
      }
    } catch (error) {
      return (false, <OnlineUserEntity>[]);
    }
  }

  ///根据id获取在线列表
  static Future<(bool, List<String>)> queryOnlineUser({
    required String userIds,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.queryOnlineUser,
        queryParameters: {"user_ids": userIds},
      );
      if (result["code"] == 0) {
        return (true, result['data'] as List<String>);
      } else {
        CustomToast.fail("Failed");
        return (false, <String>[]);
      }
    } catch (error) {
      return (false, <String>[]);
    }
  }

  ///查询WLM、Visitor新增数量和总数量
  static Future<UnreadDataEntity?> queryWlmOrVisitorCount() async {
    try {
      final result = await Net.instance.post(ApiPath.queryWlmOrVisitorCount);
      if (result["code"] == 0) {
        UnreadDataEntity value = await compute(
          (dynamic jsonStr) => UnreadDataEntity.fromJson(jsonStr),
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

  ///match标记已读
  static Future<bool> toMatchRead() async {
    try {
      final result = await Net.instance.post(ApiPath.matchRead);
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///获取服务消息
  @Deprecated("deprecated")
  static Future<bool> getServiceMessage({required String targetId}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.getServiceMessage,
        queryParameters: {"target_id": targetId},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///解锁私密
  static Future<PrivateMsgStatusEntity?> unlockPrivate({
    required String toMsgid,
    required String fromMsgid,
    required String mediaId,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.unlockPrivate,
        queryParameters: {
          "to_msgid": toMsgid,
          "from_msgid": fromMsgid,
          "media_id": mediaId,
        },
      );

      if (result["code"] == 0) {
        if (result["data"] != null) {
          PrivateMsgStatusEntity value = await compute(
            (dynamic jsonStr) => PrivateMsgStatusEntity.fromJson(jsonStr),
            result["data"],
          );
          return value;
        } else {
          // result["action"]
          return null;
        }
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///消息撤回
  static Future<bool> recallMessage({
    required String msgId,
    required String senderId,
    required String targetId,
    required int sentTime,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.recallMessage,
        queryParameters: {
          "msg_id": msgId,
          "sender_id": senderId,
          "target_id": targetId,
          "sent_time": sentTime,
        },
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }
}
