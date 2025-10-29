import 'package:flutter/foundation.dart';
import 'package:newbug/core/emums/app_emums.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/model/user_info.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/network/path/netPath.dart';
import 'package:newbug/core/widget/index.dart';

abstract class AccountAPI {
  ///邮箱登录
  static Future<UserEntity?> emailLogin({
    required String email,
    required String pwd,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.emailLogin,
        queryParameters: {"email": email, "pwd": pwd, "auto_reg": "1"},
      );
      if (result["code"] == 0) {
        UserEntity value = await compute(
          (dynamic jsonStr) => UserEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("user is null");
        return null;
      }
    } catch (error) {
      CustomToast.fail(error.toString());
      return null;
    }
  }

  ///google登录
  static Future<UserEntity?> googleLogin({required String idToken}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.googleLogin,
        queryParameters: {"id_token": idToken},
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
      CustomToast.fail(error.toString());
      return null;
    }
  }

  ///刷新 token
  static Future<UserEntity?> refreshToken() async {
    try {
      final result = await Net.instance.post(ApiPath.refreshToken);
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

  ///注册填写用户信息(header add authorization)
  static Future<UserInfo?> editInfo({
    required int step,
    String? nickName,
    String? birthday,
    int? sex,
    int? sexuality,
    String? sign,
    String? mediaList,
    String? desires,
    String? tag,
    String? country,
  }) async {
    //1 用户昵称；2 生日信息；3 性别；4 性向；5 Sign；6 Tag；7 Photo；9 最后提交；10 Desires； 11 国家； 12 desires  tag
    Map<String, dynamic> data = {};
    data["step"] = step;

    if (step == 1) {
      data["nick_name"] = nickName;
    } else if (step == 2) {
      data["brithday"] = birthday;
    } else if (step == 3) {
      ///1男 2女 3非二元
      data["sex"] = sex;
    } else if (step == 4) {
      ///性取向
      data["sexuality"] = sexuality;
    } else if (step == 5) {
      data["sign"] = sign;
    } else if (step == 7) {
      data["media_list"] = mediaList;
    } else if (step == 9) {
      if (sign != null) {
        data["sign"] = sign;
      }
      if (desires != null) {
        data["desires"] = desires;
      }
      if (tag != null) {
        data["tag"] = tag;
      }
    } else if (step == 10) {
      data["desires"] = desires;
    } else if (step == 11) {
      data["country"] = country;
    } else if (step == 12) {
      if (desires != null) {
        data["desires"] = desires;
      }
      if (tag != null) {
        data["tag"] = tag;
      }
    }

    try {
      final result = await Net.instance.post(ApiPath.editUserInfo, data: data);
      if (result["code"] == 0) {
        UserInfo value = await compute(
          (dynamic jsonStr) => UserInfo.fromJson(jsonStr),
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

  ///退出登录
  static Future<bool> exitLogin() async {
    try {
      final result = await Net.instance.post(
        ApiPath.exitLogin,
        queryParameters: {"status": UserStatusEmu.exit.value},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///注销账号
  static Future<bool> deleteAccount() async {
    try {
      final result = await Net.instance.post(ApiPath.deleteAccount);
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///用户状态上报
  static Future<bool> updateUserStatus({required int status}) async {
    //UserStatusEmu.exit.value
    try {
      final result = await Net.instance.post(
        ApiPath.updateUserStatus,
        queryParameters: {"status": status},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }
}
