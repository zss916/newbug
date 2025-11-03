import 'package:get/get.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/reopsitory/home.dart';

class HomeLogic extends GetxController {
  List<HomeCardsMatchList> cards = [];

  @override
  void onReady() {
    super.onReady();
    //CustomToast.loading();
    loadData();
  }

  Future<void> loadData() async {
    final (bool isSucceeful, List<HomeCardsMatchList> value) =
        await HomeAPI.getHomeSwiperCards(tab: 1);
    if (isSucceeful) {
      cards = value;
      update();
    }
  }
}
