import 'package:flutter/material.dart';
import 'package:newbug/core/im/utils/base64.dart';
import 'package:provider/provider.dart';
import 'package:rongcloud_im_kit/rongcloud_im_kit.dart';

class RCKit {
  ///step1
  static Widget setRCRoot(Widget child) {
    return RongCloudAppProviders.of(
      child, // 你的根组件
      additionalProviders: [
        // 可以添加额外的Provider
        // ...
      ],
    );
  }

  static RCKEngineProvider? engineProvider;

  ///step 2
  static getRCEngineProvider(BuildContext context) {
    debugPrint("RCKit Provider start");
    // 在需要初始化的页面中获取Provider
    engineProvider = Provider.of<RCKEngineProvider>(context, listen: false);
    debugPrint("RCKit Provider");
    String appKey = Base64.decode("Y3BqMnhhcmx+jOGFobg==".replaceAll("+", ""));
    setRCEngineCreate(appKey);
  }

  ///step3
  static setRCEngineCreate(String appKey) async {
    // 初始化并连接到融云服务器
    RCIMIWEngineOptions options = RCIMIWEngineOptions.create(
      logLevel: RCIMIWLogLevel.verbose,
    );
    options.naviServer = 'nav.us-light-edge.com';
    options.statisticServer = 'stats.us-light-edge.com';
    final engine = await engineProvider?.engineCreate(appKey, options);
    debugPrint("RCKit create engine");
  }

  static connect(String token) async {
    await engineProvider?.engineConnect(
      token,
      100,
      onResult: (code) {
        if (code == 0) {
          //连接成功
          debugPrint("RCKit connect ok");
        } else {
          //错误提示
          debugPrint("RCKit connect error");
        }
      },
    );
  }
}
