import 'package:get/get.dart';
import 'package:newbug/page/location/location_utils.dart';

class MainLogic extends GetxController {
  int tabIndex = 0;

  @override
  void onReady() {
    super.onReady();
    LocationUtils.toLocation();
  }
}
