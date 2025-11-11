import 'dart:async';

import 'package:get/get.dart';
import 'package:newbug/core/im/custom_message/connected_message.dart';
import 'package:newbug/core/im/cv_im.dart';
import 'package:newbug/core/im/utils/im_event.dart';
import 'package:newbug/core/network/model/unread_data_entity.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/reopsitory/chat.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class MessageLogic extends GetxController {
  ///common 0, empty 1, loading 2
  int viewState = 0;

  ///融云连接失败
  bool isConnectError = false;

  UnreadDataEntity? value;
  String get likesAvatar => value?.likesAvatar ?? "";
  String get visitorAvatar => value?.visitorAvatar ?? "";
  int get wlmNewNum => value?.wlmNewNum ?? 0;
  int get visitorNewNum => value?.visitorNewNum ?? 0;

  ///new match list
  List<RCIMIWConversation> newMatchList = [];

  ///融云会话列表
  List<RCIMIWConversation> conversationsList = [];

  ///用户数据
  Map<String, UserEntity> userInfoMap = {};

  // StreamSubscription<SendEvent>? sendSubs;
  StreamSubscription<ReceiveMsgEvent>? receiveSubs;

  RefreshController loadMoreCtrl = RefreshController(initialRefresh: false);

  ///最后一条消息的发送时间
  int startTime = 0;

  @override
  void onInit() {
    super.onInit();
    /* sendSubs = EventService.to.listen<SendEvent>((event) {
      debugPrint("SendEvent ====>>>>> getConversations");
      // getConversations();
    });*/

    ///接受融云消息监听
    receiveSubs = EventService.to.listen<ReceiveMsgEvent>((event) {
      loadAllConversations();
    });
  }

  @override
  void onReady() {
    super.onReady();
    loadWlmOrVisitorCount();
    loadAllConversations();
  }

  @override
  void onClose() {
    loadMoreCtrl.dispose();
    receiveSubs?.cancel();
    super.onClose();
  }

  Future<void> loadWlmOrVisitorCount() async {
    value = await ChatAPI.queryWlmOrVisitorCount();
    update();
  }

  ///加载全部会话列表
  Future<void> loadAllConversations({Function? onLoadFinish}) async {
    startTime = 0;
    await CvIM.getConversations(
      startTime: startTime,
      onGetConversations: (List<RCIMIWConversation> conversations) async {
        if (conversations.isNotEmpty) {
          conversationsList.assignAll(conversations);
          startTime = conversations.last.lastMessage?.sentTime ?? 0;

          ///获取new match
          newMatchList = conversationsList
              .where(
                (e) =>
                    (e.lastMessage?.messageType ==
                        RCIMIWMessageType.userCustom &&
                    e.lastMessage is ConnectedMessage),
              )
              .toList();

          ///获取所有用户uid
          String uids = conversations
              .where((e) => e.targetId != null)
              .map((e) => e.targetId)
              .toList()
              .join(",");

          _handAllConversations(
            uids: uids,
            onLoadEnd: () {
              onLoadFinish?.call();
              viewState = conversationsList.isEmpty ? 1 : 0;
              update();
            },
          );
        } else {
          CustomToast.dismiss();
          viewState = 1;
          update();
        }
      },
    );
  }

  ///加载更多
  Future<void> loadMoreConversations() async {
    await CvIM.getConversations(
      startTime: startTime,
      onGetConversations: (List<RCIMIWConversation> conversations) async {
        if (conversations.isNotEmpty) {
          conversationsList.addAll(conversations);
          startTime = conversations.last.lastMessage?.sentTime ?? 0;

          ///获取所有用户uid
          String uids = conversations
              .where((e) => e.targetId != null)
              .map((e) => e.targetId)
              .toList()
              .join(",");
          _handAllConversations(
            uids: uids,
            onLoadEnd: () {
              loadMoreCtrl.loadComplete();
            },
          );
        } else {
          CustomToast.dismiss();
          loadMoreCtrl.loadNoData();
        }
      },
    );
  }

  ///获取用户信息
  Future<void> _handAllConversations({
    required String uids,
    Function? onLoadEnd,
  }) async {
    final (bool isSuccessful, List<UserEntity> value) =
        await ChatAPI.getProfileList(ids: uids);
    if (isSuccessful) {
      List<Map<String, dynamic>> userJsonList = value
          .map((user) => user.toJson())
          .toList();
      updateUserInfos(userJsonList);
      update();
      onLoadEnd?.call();
    } else {
      onLoadEnd?.call();
    }
  }

  void updateUserInfos(List<Map<String, dynamic>> data) {
    for (var element in data) {
      final userInfo = UserEntity.fromJson(element);
      userInfoMap[userInfo.userId.toString()] = userInfo;
    }
  }

  ///置顶会话
  void setConversationItemTop({String? targetId, required bool isTop}) {
    if (targetId != null) {
      CustomToast.loading();
      CvIM.setConversationItemTop(
        targetId: targetId,
        top: (!isTop),
        onSetConversationTop: (value) {
          loadAllConversations(
            onLoadFinish: () {
              CustomToast.dismiss();
            },
          );
        },
      );
    }
  }

  ///删除会话
  void removeConversationItem({String? targetId}) {
    if (targetId != null) {
      CustomToast.loading();
      CvIM.removeConversationItem(
        targetId: targetId,
        onRemoveCallback: (value) {
          loadAllConversations(
            onLoadFinish: () {
              CustomToast.dismiss();
            },
          );
        },
      );
    }
  }

  ///去重复
  List<T> removeDuplicates<T>(
    List<T> list,
    bool Function(T first, T second) isEqual,
  ) {
    List<T> output = [];
    for (var i = 0; i < list.length; i++) {
      bool found = false;
      for (var j = 0; j < output.length; j++) {
        if (isEqual(list[i], output[j])) {
          found = true;
        }
      }
      if (!found) {
        output.add(list[i]);
      }
    }

    return output;
  }
}
