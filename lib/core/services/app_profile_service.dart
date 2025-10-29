import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/network/model/config_entity.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:url_launcher/url_launcher.dart';

class AppProfileService extends GetxService {
  static AppProfileService get to => Get.find();

  ConfigEntity? config;

  ///初始化
  Future<AppProfileService> init() async {
    return this;
  }

  @override
  void onReady() {
    super.onReady();
    getConfig();
  }

  ///获取配置
  Future<ConfigEntity?> getConfig() async {
    ConfigEntity? value = await SystemAPI.config();
    config = value;
    return value;
  }

  void toTerms() => openWeb(url: config?.html?.terms ?? '');

  void toPrivacy() => openWeb(url: config?.html?.privacy ?? '');

  Future<void> openWeb({required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    } else {
      debugPrint("error url:$url");
    }
  }
}
