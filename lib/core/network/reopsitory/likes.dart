import 'package:flutter/foundation.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/network/path/netPath.dart';

abstract class LikesAPI {
  /// 获取likes列表
  static Future<(bool, List<PeopleEntity>)> getLikesList() async {
    try {
      final result = await Net.instance.post(
        ApiPath.likeList,
        queryParameters: {"tag": 3},
      );
      if (result["code"] == 0) {
        List<PeopleEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => PeopleEntity.fromJson(e)).toList(),
          (result['data']["list"] as List),
        );
        return (true, value);
      } else {
        return (false, <PeopleEntity>[]);
      }
    } catch (error) {
      return (false, <PeopleEntity>[]);
    }
  }

  /// 获取WLM列表
  static Future<(bool, List<PeopleEntity>)> getWLMList() async {
    try {
      final result = await Net.instance.post(
        ApiPath.getWLMList,
        queryParameters: {"tag": 1},
      );
      if (result["code"] == 0) {
        List<PeopleEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => PeopleEntity.fromJson(e)).toList(),
          (result['data']["list"] as List),
        );
        return (true, value);
      } else {
        return (false, <PeopleEntity>[]);
      }
    } catch (error) {
      return (false, <PeopleEntity>[]);
    }
  }

  ///标记已读
  static Future<bool> toRead({required int from}) async {
    try {
      /// wlm:1001 visitior:1002 ilike:1003
      final result = await Net.instance.post(
        ApiPath.readLike,
        queryParameters: {"from": from},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }
}
