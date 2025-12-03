import 'package:get/get.dart';
import 'package:newbug/core/helper/custom_annotation.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/core/network/model/unread_data_entity.dart';
import 'package:newbug/core/network/reopsitory/chat.dart';
import 'package:newbug/core/network/reopsitory/home.dart';
import 'package:newbug/core/network/reopsitory/likes.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/like/like_service.dart';
import 'package:newbug/page/main/main_logic.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

class LikeLogic extends GetxController implements ILoadService {
  ///wlm
  List<PeopleEntity> wlmList = [];

  int? wlmLastId;
  int wlmPage = 1;

  ///you liked
  List<PeopleEntity> youLikedList = [];

  int? youLikeLastId;
  int youLikePage = 1;

  ///common 0, match 1, wrong 2
  int wlmViewState = 0;

  ///common 0, empty 1, hide 2(隐身模式)
  int youLikedViewState = 0;

  late RefreshController wlmRefreshCtrl = RefreshController(
    initialRefresh: false,
    initialLoadStatus: LoadStatus.canLoading,
  );

  late RefreshController youLikeRefreshCtrl = RefreshController(
    initialRefresh: false,
    initialLoadStatus: LoadStatus.canLoading,
  );

  ///是否显示红点
  int wlmNewNum = 0;

  @override
  void onReady() {
    super.onReady();
    refreshData();
    refreshList();
    loadWlmOrVisitorCount();
  }

  @override
  void onClose() {
    wlmRefreshCtrl.dispose();
    youLikeRefreshCtrl.dispose();
    super.onClose();
  }

  ///标记已读(清除like 的小红点)
  Future<void> toMarkRead() async {
    bool isSuccessful = await LikesAPI.toRead(from: 1001);
    if (isSuccessful) {
      wlmNewNum = 0;
      update();
      safeFind<MainLogic>()?.wlmNewNum = 0;
      safeFind<MainLogic>()?.update();
    }
  }

  ///获取红点
  Future<void> loadWlmOrVisitorCount() async {
    UnreadDataEntity? value = await ChatAPI.queryWlmOrVisitorCount();
    wlmNewNum = (value?.wlmNewNum ?? 0);
    update();
  }

  bool isFinished = false;

  ///加载数据
  Future<void> loadWlm({int page = 1}) async {
    if (page == 1) {
      wlmLastId = null;
    }
    final (bool isSucceeful, List<PeopleEntity> value) =
        await LikesAPI.getLikesList(tag: 1, lastId: wlmLastId);
    if (isSucceeful) {
      toMarkRead();
      if (page == 1) {
        wlmList.assignAll(value);
      } else {
        wlmList.addAll(value);
        isFinished = value.isEmpty;
      }
      if (wlmList.isNotEmpty) {
        wlmLastId = wlmList.last.id;
      }
      wlmViewState = wlmList.isEmpty ? 1 : 0;
    } else {
      wlmViewState = 2;
    }
    //todo
    //wlmViewState = 0;
    update();
    refreshAndLoadCtl(page == 1, value.length);
  }

  Future<void> loadYouLiked({int page = 1}) async {
    if (page == 1) {
      youLikeLastId = null;
    }

    final (bool isSucceeful, List<PeopleEntity> value) =
        await LikesAPI.getLikesList(tag: 3, lastId: youLikeLastId);
    if (isSucceeful) {
      if (page == 1) {
        youLikedList.clear();
        youLikedList.addAll(value);
      } else {
        youLikedList.addAll(value);
      }
      if (youLikedList.isNotEmpty) {
        youLikeLastId = youLikedList.last.id;
      }
      refreshAndLoadCtl(page == 1, value.length);
      youLikedViewState = youLikedList.isEmpty ? 1 : 0;
      update();
    } else {
      refreshAndLoadCtl(page == 1, value.length);
      youLikedViewState = 1;
      update();
    }
  }

  ///选择用户(1:pass 2:like)
  ///index (wlm = 1, youLiked = 3 )
  Future<void> chooseUser({
    required int from,
    required int userId,
    required int type,
  }) async {
    CustomToast.loading();
    Right? value = await HomeAPI.chooseCard(
      type: type,
      userId: userId,
      from: from,
      cardFlag: 0,
    ).whenComplete(() => CustomToast.dismiss());
    if (value != null) {
      _removeItem(userId);
    }
  }

  void _removeItem(int userId) {
    wlmList.removeWhere((e) => e.userId == userId);
    wlmViewState = wlmList.isEmpty ? 1 : 0;
    update();
  }

  @override
  void refreshData() {
    wlmPage = 1;
    loadWlm(page: wlmPage);
  }

  @override
  void loadMoreData() {
    wlmPage += 1;
    loadWlm(page: wlmPage);
  }

  @override
  void refreshAndLoadCtl(bool isRefresh, int size) {
    if (isRefresh) {
      wlmRefreshCtrl.refreshCompleted();
    } else {
      if (size == 0) {
        wlmRefreshCtrl.loadNoData();
      } else {
        wlmRefreshCtrl.loadComplete();
      }
    }
  }

  @override
  void refreshList() {
    youLikePage = 1;
    loadYouLiked(page: youLikePage);
  }

  @override
  void loadMoreList() {
    youLikePage += 1;
    loadYouLiked(page: youLikePage);
  }

  @override
  void refreshAndLoadListCtl(bool isRefresh, int size) {
    if (isRefresh) {
      youLikeRefreshCtrl.refreshCompleted();
    } else {
      if (size == 0) {
        youLikeRefreshCtrl.loadNoData();
      } else {
        youLikeRefreshCtrl.loadComplete();
      }
    }
  }
}
