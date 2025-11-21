import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///发送消息事件
class SendEvent {
  SendEvent();
}

///接受消息事件
class ReceiveMsgEvent {
  RCIMIWMessage? message;
  ReceiveMsgEvent(this.message);
}

///触发发送单个私有消息
class SendPrivateSingleMsgEvent {
  String content;
  SendPrivateSingleMsgEvent({required this.content});
}

///触发发送打包私有消息
class SendPrivatePackageMsgEvent {
  List<String> content;
  SendPrivatePackageMsgEvent({required this.content});
}
