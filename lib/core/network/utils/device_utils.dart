import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  /// 获取设备ID
  static Future<String> getDeviceID({String? adjustId}) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    final data = [
      androidInfo.id, // 核心标识（相同签名应用不变）
      androidInfo.model, // 设备型号
      androidInfo.manufacturer, // 制造商
      androidInfo.board, // 主板名称
      androidInfo.brand, // 品牌
      androidInfo.hardware, // 硬件名称
      androidInfo.device, // 设备代号
      androidInfo.product, // 产品名称
      androidInfo.fingerprint, // 系统指纹
      androidInfo.supportedAbis, // CPU架构
      androidInfo.version.securityPatch,
      adjustId ?? "",
    ].join('|');

    return sha256.convert(utf8.encode(data)).toString();
  }

  /// 获取设备名称
  static Future<String> getDeviceName() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.model;
  }

  /// 获取设备名称
  static Future<String> getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }
}
