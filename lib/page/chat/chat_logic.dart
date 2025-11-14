part of 'index.dart';

class ChatLogic extends GetxController with ChatActionMixin, MixinUpload {
  String? targetId;
  UserEntity? userInfo;

  List<LocalWrapperMsg> historyMsg = [];

  List<LocalWrapperMsg> currentMsg = [];

  int sentTime = 0;

  StreamSubscription<ReceiveMsgEvent>? receiveSubs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      targetId = map["targetId"] as String?;
      userInfo = map["userInfo"] as UserEntity?;
    }

    ///接受融云消息监听
    receiveSubs = EventService.to.listen<ReceiveMsgEvent>((event) {
      loadRecentMessage();
    });
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

  ///发送消息
  void toSend({required String value}) {
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
          _updateMsgStatus(status: MsgStatus.loading, message: message);
          EventService.to.post(SendEvent());
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
          _updateMsgStatus(status: MsgStatus.loading, message: message);
          EventService.to.post(SendEvent());
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
}
