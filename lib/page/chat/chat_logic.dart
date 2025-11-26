part of 'index.dart';

class ChatLogic extends GetxController with ChatActionMixin, MixinUpload {
  String? targetId;
  UserEntity? userInfo;

  List<LocalWrapperMsg> historyMsg = [];

  List<LocalWrapperMsg> currentMsg = [];

  int sentTime = 0;

  StreamSubscription<UpdateMsgEvent>? updateSubs;
  StreamSubscription<ReceiveMsgEvent>? receiveSubs;
  StreamSubscription<SendPrivateSingleMsgEvent>? sendPrivateSingleSubs;
  StreamSubscription<SendPrivatePackageMsgEvent>? sendPrivatePackageSubs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      targetId = map["targetId"] as String?;
      userInfo = map["userInfo"] as UserEntity?;
    }

    ///更新消息(拓展信息)
    updateSubs = EventService.to.listen<UpdateMsgEvent>((event) {
      RCIMIWMessage updateMessage = event.message as RCIMIWMessage;
      updateMsgExpansion(historyMsg, updateMessage);
      updateMsgExpansion(currentMsg, updateMessage);
    });

    ///接受融云消息监听
    receiveSubs = EventService.to.listen<ReceiveMsgEvent>((event) {
      loadRecentMessage();
    });

    ///触发单个私有消息发送
    sendPrivateSingleSubs = EventService.to.listen<SendPrivateSingleMsgEvent>((
      event,
    ) {
      sendPrivateSingleMessage(event.content);
    });

    ///触发打包私有消息发送
    sendPrivatePackageSubs = EventService.to.listen<SendPrivatePackageMsgEvent>(
      (event) {
        List<String> list = event.content;
        sendPrivatePackageMessage(list);
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    historyMsg.clear();
    currentMsg.clear();
    loadRecentMessage();
  }

  @override
  void onClose() {
    updateSubs?.cancel();
    sendPrivatePackageSubs?.cancel();
    sendPrivateSingleSubs?.cancel();
    receiveSubs?.cancel();
    scrollCtrl.dispose();
    super.onClose();
  }

  ///拉取最近最新消息
  Future<void> loadRecentMessage() async {
    sentTime = 0;
    await CvIM.getHistoryMessageList(
      targetId: targetId,
      sentTime: sentTime,
      onHistoryMessage: (value) {
        _handRecentMessage(value);
      },
    );
  }

  ///处理拉取的当前消息
  void _handRecentMessage(List<RCIMIWMessage> recentMessage) {
    if (recentMessage.isNotEmpty) {
      List<LocalWrapperMsg> wrapperMsg = handMsgTime(
        recentMessage,
        DateTime.now().millisecondsSinceEpoch,
      );
      currentMsg.assignAll(wrapperMsg.reversed);
      sentTime = currentMsg.first.rCIMIWMessage.sentTime ?? 0;

      /*      PrivateMessage msg = currentMsg.last.rCIMIWMessage as PrivateMessage;
      debugPrint("RongIM lastmsg==>>${msg.toJson()}");*/

      setListScrollToBottom(data: recentMessage);
      update();
    }
  }

  ///拉取历史数据
  Future<void> loadHistoryMessage() async {
    await CvIM.getHistoryMessageList(
      targetId: targetId,
      sentTime: sentTime,
      onHistoryMessage: (value) {
        _handHistoryMessage(value);
      },
    );
  }

  ///处理历史消息
  void _handHistoryMessage(List<RCIMIWMessage> historyMessage) {
    if (historyMessage.isNotEmpty) {
      List<LocalWrapperMsg> wrapperMsg = handMsgTime(historyMessage, sentTime);
      historyMsg.addAll(wrapperMsg);
      // historyMsg.addAll(historyMessage);
      sentTime = historyMsg.last.rCIMIWMessage.sentTime ?? 0;
      setListScrollToTop(data: historyMessage);
      update();
    }
  }

  ///发送文字消息
  void toSendText({required String value}) {
    if ((targetId ?? '').isNotEmpty) {
      CvIM.toSendText(
        targetId: targetId ?? "",
        text: value,
        onSendStart: (RCIMIWMessage? message) {
          _addMsg(message: message);
        },
        onSendResult: (int? code, RCIMIWMessage? message) {
          MsgStatus status = code == 0 ? MsgStatus.successful : MsgStatus.error;
          _updateMsgStatus(status: status, message: message);
          EventService.to.post(SendEvent());
        },
      );
    } else {
      debugPrint("targetId is null");
    }
  }

  ///添加消息
  void _addMsg({RCIMIWMessage? message}) {
    if (message != null) {
      LocalWrapperMsg localWrapperMsg = LocalWrapperMsg(
        rCIMIWMessage: message,
        isSender: true,
        targetId: message.targetId,
        msgStatus: MsgStatus.loading,
      );
      currentMsg.add(localWrapperMsg);
      scrollWhenMsgSaved(true);
      update();
    }
  }

  ///更新消息状态
  void _updateMsgStatus({MsgStatus? status, RCIMIWMessage? message}) {
    for (LocalWrapperMsg value in currentMsg) {
      if (message?.targetId == value.targetId &&
          message?.targetId == value.rCIMIWMessage.targetId &&
          message?.messageId == value.rCIMIWMessage.messageId) {
        value.msgStatus = status;
        //value.msgStatus = code == 0 ? MsgStatus.successful : MsgStatus.error;
        update();
        break;
      }
    }
  }

  ///发送image消息
  void sendImageMessage({required String path}) {
    if ((targetId ?? '').isNotEmpty) {
      CvIM.toSendImage(
        targetId: targetId ?? "",
        path: path,
        onSendMsgSaved: (RCIMIWMessage? message) {
          _addMsg(message: message);
        },
        onSendMsgSending: (RCIMIWMessage? message) {
          // _updateMsgStatus(status: MsgStatus.loading, message: message);
          // EventService.to.post(SendEvent());
        },
        onSendMsgSent: (int? code, RCIMIWMediaMessage? message) {
          MsgStatus status = code == 0 ? MsgStatus.successful : MsgStatus.error;
          _updateMsgStatus(status: status, message: message);
          EventService.to.post(SendEvent());
        },
      );
    } else {
      debugPrint("targetId is null");
    }
  }

  ///发送video消息
  void sendVideoMessage({required String path, int? duration}) {
    if ((targetId ?? '').isNotEmpty) {
      CvIM.toSendVideo(
        targetId: targetId ?? "",
        path: path,
        duration: duration,
        onSendMsgSaved: (RCIMIWMessage? message) {
          _addMsg(message: message);
        },
        onSendMsgSending: (RCIMIWMessage? message) {
          //_updateMsgStatus(status: MsgStatus.loading, message: message);
          //EventService.to.post(SendEvent());
        },
        onSendMsgSent: (int? code, RCIMIWMediaMessage? message) {
          MsgStatus status = code == 0 ? MsgStatus.successful : MsgStatus.error;
          _updateMsgStatus(status: status, message: message);
          EventService.to.post(SendEvent());
        },
      );
    } else {
      debugPrint("targetId is null");
    }
  }

  ///发送单个私密消息
  void sendPrivateSingleMessage(String content) {
    if ((targetId ?? '').isNotEmpty) {
      CvIM.toSendPrivateMsg(
        targetId: targetId ?? "",
        content: content,
        onSendStart: (RCIMIWMessage? message) {
          _addMsg(message: message);
        },
        onSendResult: (int? code, RCIMIWMessage? message) {
          MsgStatus status = code == 0 ? MsgStatus.successful : MsgStatus.error;
          _updateMsgStatus(status: status, message: message);
          EventService.to.post(SendEvent());
        },
      );
    }
  }

  ///私有打包消息
  void sendPrivatePackageMessage(List<String> list) {
    for (String value in list) {
      var data = json.decode(value);
      if (data is List) {
        if (data.length == 1) {
          var element = data.first;
          element.removeWhere((key, value) => value == null);
          sendPrivateSingleMessage(jsonEncode(element));
        } else {
          for (var element in data) {
            element.removeWhere((key, value) => value == null);
          }
          Map<String, dynamic> map = {
            'type': data.first['type'],
            'num': data.length,
            'media_ids': data.map((e) => e['id']).toList().join(','),
            'list': data,
          };
          if ((targetId ?? "").isNotEmpty) {
            CvIM.toSendPrivatePackageMsg(
              targetId: targetId ?? "",
              content: jsonEncode(map),
              onSendStart: (RCIMIWMessage? message) {
                _addMsg(message: message);
              },
              onSendResult: (int? code, RCIMIWMessage? message) {
                MsgStatus status = code == 0
                    ? MsgStatus.successful
                    : MsgStatus.error;
                _updateMsgStatus(status: status, message: message);
                EventService.to.post(SendEvent());
              },
            );
          }
        }
      }
    }
  }

  ///处理公共相册(只能单张图片或视频)
  Future<void> handPublicAlbum(List<AssetEntity> assets) async {
    AssetEntity assetEntity = assets.first;
    if (assetEntity.type == AssetType.image) {
      File? imageFile = await assetEntity.file;
      MediaListItem imageMedia = MediaListItem()
        ..localFile = imageFile
        ..localFilePath = imageFile?.path ?? ""
        ..type = 0;
      File? imageFileCompress = await GalleryTools.compressImageFilePlus(
        imageMedia,
      );
      // String? url = await toUpload(file: imageFileCompress!);
      sendImageMessage(
        path: imageFileCompress?.path ?? (imageFile?.path ?? ""),
      );
    } else if (assetEntity.type == AssetType.video) {
      File? videoFile = await assetEntity.file;
      CustomToast.loading();
      String? thumbUrl = await GalleryTools.getVideoThumbnail(
        videoFile?.path ?? "",
      ).whenComplete(() => CustomToast.dismiss());
      MediaListItem videoMedia = MediaListItem()
        ..localFile = videoFile
        ..localFilePath = videoFile?.path ?? ""
        ..thumbUrl = thumbUrl
        ..type = 1;
      File? videoFileCompress = await GalleryTools.compressVideoFilePlus(
        videoMedia,
      );
      sendVideoMessage(
        path: (videoFileCompress?.path ?? (videoFile?.path ?? "")),
        duration: assetEntity.duration,
      );
    }
  }

  ///处理自定义公有相册转私有发送
  Future<void> handPublicAlbumToPrivate(List<AssetEntity> assets) async {
    AssetEntity assetEntity = assets.first;
    if (assetEntity.type == AssetType.image) {
      File? imageFile = await assetEntity.file;
      MediaListItem imageMedia = MediaListItem()
        ..localFile = imageFile
        ..localFilePath = imageFile?.path ?? ""
        ..type = 0;
      File? imageFileCompress = await GalleryTools.compressImageFilePlus(
        imageMedia,
      );
      CustomToast.loading();
      String? url = await toUpload(file: imageFileCompress!);
      num? id = await addPrivate(type: 0, url: url ?? "");
      CustomToast.dismiss();
      String content = jsonEncode(
        imageMedia
          ..url = url
          ..id = (id ?? 0).toInt(),
      );
      sendPrivateSingleMessage(content);
    } else if (assetEntity.type == AssetType.video) {
      File? videoFile = await assetEntity.file;
      CustomToast.loading();
      String? thumbUrl = await GalleryTools.getVideoThumbnail(
        videoFile?.path ?? "",
      );
      MediaListItem videoMedia = MediaListItem()
        ..localFile = videoFile
        ..localFilePath = videoFile?.path ?? ""
        ..thumbUrl = thumbUrl
        ..type = 1;
      File? videoFileCompress = await GalleryTools.compressVideoFilePlus(
        videoMedia,
      );
      String? url = await toUpload(file: videoFileCompress!);
      num? id = await addPrivate(type: 1, url: url ?? "");
      CustomToast.dismiss();
      String content = jsonEncode(
        videoMedia
          ..url = url
          ..id = (id ?? 0).toInt(),
      );
      sendPrivateSingleMessage(content);
    }
  }

  ///去解锁
  Future<PrivateMsgStatusEntity?> toUnLock({
    required String toMsgid,
    required String fromMsgid,
    required String mediaId,
  }) async {
    PrivateMsgStatusEntity? value = await ChatAPI.unlockPrivate(
      toMsgid: toMsgid,
      fromMsgid: fromMsgid,
      mediaId: mediaId,
    );
    return value;
  }

  ///更新消息的拓展信息
  void updateMsgExpansion(
    List<LocalWrapperMsg> wrapperMsgs,
    RCIMIWMessage updateMessage,
  ) {
    if (wrapperMsgs.isNotEmpty) {
      String conversationId = updateMessage.targetId ?? "";
      List<RCIMIWMessage> msgList = wrapperMsgs
          .map((e) => e.rCIMIWMessage)
          .where((e) => e.targetId == conversationId)
          .toList();
      if (msgList.isNotEmpty) {
        RCIMIWMessage msg = msgList.firstWhere(
          (e) => e.messageId == updateMessage.messageId,
        );
        msg.expansion = updateMessage.expansion;
        update();
      }
    }
  }

  toViewProfile() {
    RouteManager.toOtherProfile(uid: targetId);
  }

  toDelete() {
    showRemoveConversationDialog(
      onConfirm: () async {
        if (targetId != null) {
          /* CvIM.removeConversationItem(
            targetId: targetId??"",
            onRemoveCallback: (value) {

            },
          );*/
          Get.back(closeOverlays: true);

          CustomToast.success(T.successful.tr);
        } else {
          CustomToast.fail(T.failed.tr);
        }
      },
    );
  }

  toReport() async {
    showReportSheet(
      onItemTap: (reportId) async {
        CustomToast.loading();
        bool isSuccessful = await SystemAPI.report(
          userId: targetId ?? "",
          reportId: reportId,
          form: FromType.chat,
        ).whenComplete(() => CustomToast.dismiss());
        if (isSuccessful) {
          /// todo 融云删除conversation
          Get.back(closeOverlays: true);
          CustomToast.success(T.blockSuccessful.tr);
        } else {
          CustomToast.fail(T.blockFail.tr);
        }
      },
    );
  }

  toBlock() {
    showBlockDialog(
      onConfirm: () async {
        bool isSuccessful = await SystemAPI.block(
          userId: targetId ?? "",
        ).whenComplete(() => CustomToast.dismiss());
        if (isSuccessful) {
          /// todo 融云删除conversation
          Get.back(closeOverlays: true);
          CustomToast.success(T.blockSuccessful.tr);
        } else {
          CustomToast.fail(T.blockFail.tr);
        }
      },
    );
  }
}
