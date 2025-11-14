import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/page/chat/custom_message_widget/message_wrapper_widget.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///本地包裹融云消息类
class LocalWrapperMsg {
  ///融云基础消息
  RCIMIWMessage rCIMIWMessage;

  ///targetId
  String? targetId;

  ///是否是发送端
  bool isSender;

  ///是否显示时间
  bool? showTime;

  ///用户信息
  UserEntity? userInfo;

  ///消息状态
  MsgStatus? msgStatus;

  LocalWrapperMsg({
    required this.rCIMIWMessage,
    required this.isSender,
    this.targetId,
    this.showTime,
    this.userInfo,
    this.msgStatus,
  });
}
