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
