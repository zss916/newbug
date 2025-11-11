enum CustomMessageType {
  connected,
  system,
  public,
  private,
  packagePrivate,
  sync,
  systemTips,
  unknown,
}

/// 自定义消息的字符串描述(MessageTag)
extension CustomMessageName on CustomMessageType {
  String get name {
    switch (this) {
      case CustomMessageType.connected:
        return "connectfriends:connected";
      case CustomMessageType.system:
        return "connectfriends:sysaction";
      case CustomMessageType.public:
        return "connectfriends:public";
      case CustomMessageType.private:
        return "connectfriends:privacy";
      case CustomMessageType.packagePrivate:
        return "connectfriends:privacy_multiple";
      case CustomMessageType.sync:
        return "connectfriends:datasyn";
      case CustomMessageType.systemTips:
        return "connectfriends:system_tips";
      case CustomMessageType.unknown:
        return "";
    }
  }
}

extension CustomMessageEnumType on String {
  CustomMessageType get customMessageEnum {
    if (this == "connectfriends:connected") {
      return CustomMessageType.connected;
    } else if (this == "connectfriends:sysaction") {
      return CustomMessageType.system;
    } else if (this == "connectfriends:public") {
      return CustomMessageType.public;
    } else if (this == "connectfriends:privacy") {
      return CustomMessageType.private;
    } else if (this == "connectfriends:privacy_multiple") {
      return CustomMessageType.packagePrivate;
    } else if (this == "connectfriends:datasyn") {
      return CustomMessageType.sync;
    } else if (this == "connectfriends:system_tips") {
      return CustomMessageType.systemTips;
    } else {
      return CustomMessageType.unknown;
    }
  }
}
