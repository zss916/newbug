import 'package:get/get.dart';
import 'package:newbug/core/config/form_type.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/core/network/reopsitory/home.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/dialog/block/block_dialog.dart';
import 'package:newbug/page/dialog/report/sheet_report.dart';

class HomeLogic extends GetxController {
  List<HomeCardsMatchList> matchList = [];
  List<String> privacyList = [];

  ///common 0,wrong 1, empty 2，no match 3, loading 4
  int viewState = 0;
  int selected = 0;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() {
    viewState = 4;
    update();
    EventService.to.post(HomeMenuEvent(isShow: viewState == 0));
  }

  @override
  void onReady() {
    super.onReady();
    //CustomToast.loading();
    loadData();
  }

  Future<void> loadData() async {
    HomeCardsEntity? value = await HomeAPI.getHomeSwiperCards(tab: 1);
    if (value != null) {
      matchList = value.matchList ?? [];
      viewState = matchList.isEmpty ? 2 : 0;
      privacyList = value.privacyList ?? [];
    } else {
      viewState = 1;
    }
    update();
    EventService.to.post(HomeMenuEvent(isShow: viewState == 0));
  }

  ///拉黑
  Future<void> toBlock() async {
    showBlockDialog(
      onConfirm: () async {
        if (matchList.isNotEmpty && matchList.length > selected) {
          CustomToast.loading();
          HomeCardsMatchList item = matchList[selected];
          bool isSuccessful = await SystemAPI.block(
            userId: "${item.userId}",
          ).whenComplete(() => CustomToast.dismiss());
          if (isSuccessful) {
            /// 举报和拉黑要去掉数据
            if (matchList.isNotEmpty) {
              matchList.removeAt(selected);
              update();
            }
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
        if (matchList.isNotEmpty && matchList.length > selected) {
          CustomToast.loading();
          HomeCardsMatchList item = matchList[selected];
          bool isSuccessful = await SystemAPI.report(
            userId: "${item.userId}",
            reportId: reportId,
            form: 1,
          ).whenComplete(() => CustomToast.dismiss());
          if (isSuccessful) {
            /// 举报和拉黑要去掉数据
            if (matchList.isNotEmpty) {
              matchList.removeAt(selected);
              update();
            }
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

  ///没有匹配
  void toUnMatchView() {
    if (AppStores.getUserInfo()?.isVip == true) {
      viewState = 2;
    } else {
      viewState = 3;
    }
    update();
    EventService.to.post(HomeMenuEvent(isShow: viewState == 0));
  }

  ///选择用户(1:pass 2:like)
  Future<void> chooseUser({required int type}) async {
    if (matchList.isEmpty) {
      return;
    }
    HomeCardsMatchList matchItem = matchList[selected];
    Right? value = await HomeAPI.chooseCard(
      type: type,
      userId: matchItem.userId ?? 0,
      from: FromType.home,
      cardFlag: matchItem.cardFlag,
    );
    if (value != null) {
      if (matchList.isNotEmpty) {
        matchList.removeAt(selected);
        update();
      }
    }
  }
}
