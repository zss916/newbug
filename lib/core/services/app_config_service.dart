import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/network/model/config_entity.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConfigService extends GetxService {
  static AppConfigService get to => Get.find();

  ConfigEntity? config;

  String get terms => config?.terms ?? "";

  String get privacy => config?.privacy ?? "";

  ///客服账号
  String get serviceAccount => config?.sysAccount?.serviceAccount ?? "";

  ///通知账号
  String get noticeAccount => config?.sysAccount?.noticeAccount ?? "";

  ///推送账号
  String get pushAccount => config?.sysAccount?.pushAccount ?? "";

  List<ConfigReportList> get reportList =>
      config?.reportList ?? <ConfigReportList>[];

  ///初始化
  Future<AppConfigService> init() async {
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
    if (value != null) {
      AppStores.setAppConfig(value: value);
    }
    config = value;
    return value;
  }

  void getReportList() {
    ConfigEntity data = AppStores.getAppConfig();
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
