import 'package:flutter/foundation.dart';
import 'package:newbug/core/network/model/black_item_entity.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/network/model/tag_entity.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/network/path/netPath.dart';
import 'package:newbug/core/stores/app_stores.dart';

abstract class ProfileAPI {
  ///用户信息
  static Future<UserEntity?> getUserInfo() async {
    try {
      final result = await Net.instance.post(ApiPath.getUserInfo);
      if (result["code"] == 0) {
        UserEntity value = await compute(
          (dynamic jsonStr) => UserEntity.fromJson(jsonStr),
          result["data"],
        );
        AppStores.setUserInfo(value: value);
        return value;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///私密相册列表//from PrivacyFromProfile = 0 PrivacyFromList    = 1 PrivacyFromChat    = 2
  static Future<(bool, List<MediaListItem>)> getPrivateAlbumList({
    required int from,
    int? lastId,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data["from"] = from;
      if (lastId != null) {
        data['last_id'] = lastId;
      }
      final result = await Net.instance.post(
        ApiPath.privateAlbumList,
        queryParameters: data,
      );

      if (result["code"] == 0) {
        if (result['data'] == null) {
          return (true, <MediaListItem>[]);
        } else {
          List<MediaListItem> value = await compute(
            (List<dynamic> jsonList) =>
                jsonList.map((e) => MediaListItem.fromJson(e)).toList(),
            (result['data'] as List),
            // result['action'];
          );
          return (true, value);
        }
      } else {
        return (false, <MediaListItem>[]);
      }
    } catch (error) {
      return (false, <MediaListItem>[]);
    }
  }

  ///Visitor访客列表
  static Future<(bool, List<PeopleEntity>)> getVisitorList({
    int? lastId,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.visitorList,
        queryParameters: {"last_id": lastId},
      );

      if (result["code"] == 0) {
        List<PeopleEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => PeopleEntity.fromJson(e)).toList(),
          (result['data']['list'] as List),
        );
        return (true, value);
      } else {
        return (false, <PeopleEntity>[]);
      }
    } catch (error) {
      return (false, <PeopleEntity>[]);
    }
  }

  ///标签列表
  static Future<(bool, List<TagEntity>)> getTagList({required int type}) async {
    try {
      //0公开 1私密
      final result = await Net.instance.post(
        ApiPath.getTagList,
        queryParameters: {"type": type},
      );

      if (result["code"] == 0) {
        List<TagEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => TagEntity.fromJson(e)).toList(),
          (result['data'] as List),
        );
        return (true, value);
      } else {
        return (false, <TagEntity>[]);
      }
    } catch (error) {
      return (false, <TagEntity>[]);
    }
  }

  ///添加私密图片 (type 图片0 视频1)
  static Future<num?> addPrivateImage({
    required int type,
    required String url,
    int? duration,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data["type"] = type;
      data["url"] = url;
      if (duration != null) {
        data["duration"] = duration;
      }
      final result = await Net.instance.post(
        ApiPath.addPrivateImage,
        queryParameters: data,
      );
      if (result["code"] == 0) {
        return result["data"]["id"] as num;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///删除私密图片
  static Future<bool> deletePrivateMedia({required int id}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.deletePrivateMedia,
        queryParameters: {"id": id},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///通知开关设置
  static Future<bool> notifyUpdate({required int config}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.notifyUpdate,
        queryParameters: {"config": config},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///黑名单列表
  static Future<(bool, List<BlackItemEntity>)> getBlackList({
    required String lastId,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.blackList,
        queryParameters: {"last_id": lastId, "page_size": 20},
      );
      if (result["code"] == 0) {
        List<BlackItemEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => BlackItemEntity.fromJson(e)).toList(),
          (result['data']['list'] as List),
        );
        return (true, value);
      } else {
        return (false, <BlackItemEntity>[]);
      }
    } catch (error) {
      return (false, <BlackItemEntity>[]);
    }
  }

  ///解除拉黑
  static Future<bool> unblack({required String uid}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.unblack,
        queryParameters: {"user_id": uid},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }
}
