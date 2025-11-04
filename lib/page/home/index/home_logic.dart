import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/reopsitory/home.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/dialog/block/block_dialog.dart';
import 'package:newbug/page/dialog/report/sheet_report.dart';

class HomeLogic extends GetxController {
  List<HomeCardsMatchList> data = [];

  int selected = 0;

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
      data = value;
      update();
    }
  }

  ///拉黑
  Future<void> toBlock() async {
    showBlockDialog(
      onConfirm: () async {
        if (data.isNotEmpty && data.length > selected) {
          CustomToast.loading();
          HomeCardsMatchList item = data[selected];
          bool isSuccessful = await SystemAPI.block(
            userId: "${item.userId}",
          ).whenComplete(() => CustomToast.dismiss());
          if (isSuccessful) {
            CustomToast.success(T.blockSuccessful.tr);
          } else {
            CustomToast.fail(T.blockFail.tr);
          }
        } else {
          CustomToast.fail(T.blockFail.tr);
        }
      },
    );
  }

  ///举报
  void toReport() async {
    showReportSheet(
      onItemTap: (reportId) async {
        if (data.isNotEmpty && data.length > selected) {
          CustomToast.loading();
          HomeCardsMatchList item = data[selected];
          bool isSuccessful = await SystemAPI.report(
            userId: "${item.userId}",
            reportId: reportId,
            form: 1,
          ).whenComplete(() => CustomToast.dismiss());
          if (isSuccessful) {
            CustomToast.success(T.blockSuccessful.tr);
          } else {
            CustomToast.fail(T.blockFail.tr);
          }
        } else {
          CustomToast.fail(T.blockFail.tr);
        }
      },
    );
  }
}
