import 'package:get/get.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/network/reopsitory/likes.dart';

class LikeLogic extends GetxController {
  ///wlm
  List<PeopleEntity> wlmList = [];

  ///you liked
  List<PeopleEntity> youLikedList = [];

  int wlmViewState = 0;

  ///common 0, empty 1, hide 2(隐身模式)
  int youLikedViewState = 0;

  @override
  void onReady() {
    super.onReady();
    loadWlm();
    loadYouLiked();
  }

  ///加载数据
  Future<void> loadWlm() async {
    final (bool isSucceeful, List<PeopleEntity> value) =
        await LikesAPI.getLikesList(tag: 1, lastId: null);
    if (isSucceeful) {
      wlmList = value;
      update();
    }
  }

  Future<void> loadYouLiked() async {
    final (bool isSucceeful, List<PeopleEntity> value) =
        await LikesAPI.getLikesList(tag: 3, lastId: null);
    if (isSucceeful) {
      youLikedList = value;
      youLikedViewState = youLikedList.isEmpty ? 1 : 0;
      update();
    }
  }

  ///选择用户(1:pass 2:like)
  Future<void> chooseUser({required int type}) async {
    /*if(matchList.isEmpty){
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
    }*/
  }
}
