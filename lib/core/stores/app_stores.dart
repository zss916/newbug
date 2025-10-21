import 'package:newbug/core/stores/stores_service.dart';

class AppStores {
  static const String cvAdjustAdjustId = "cv_adjust_adjust_id";

  /// 设置adjustID
  static void setAdjustID({required String adjustID}) {
    StoresService.to.setString(cvAdjustAdjustId, adjustID);
  }

  /// 获取adjustID
  static String? getAdjustID() {
    return StoresService.to.getString(cvAdjustAdjustId);
  }
}
