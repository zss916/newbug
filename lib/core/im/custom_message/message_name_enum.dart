enum MyCustomMessageName {
  connected,
  system,
  public,
  private,
  packagePrivate,
  sync,
  systemTips,

  unknown,
}

/// 自定义消息的字符串描述
extension MyCustomMessageName_description on MyCustomMessageName {
  String get value {
    switch (this) {
      case MyCustomMessageName.connected:
        return "connectfriends:connected";
      case MyCustomMessageName.system:
        return "connectfriends:sysaction";
      case MyCustomMessageName.public:
        return "connectfriends:public";
      case MyCustomMessageName.private:
        return "connectfriends:privacy";
      case MyCustomMessageName.packagePrivate:
        return "connectfriends:privacy_multiple";
      case MyCustomMessageName.sync:
        return "connectfriends:datasyn";
      case MyCustomMessageName.systemTips:
        return "connectfriends:system_tips";
      case MyCustomMessageName.unknown:
        return "";
    }
  }
}

extension MyCustomMessageName_getNum on String {
  MyCustomMessageName get customMessageEnum {
    if (this == "connectfriends:connected") {
      return MyCustomMessageName.connected;
    } else if (this == "connectfriends:sysaction") {
      return MyCustomMessageName.system;
    } else if (this == "connectfriends:public") {
      return MyCustomMessageName.public;
    } else if (this == "connectfriends:privacy") {
      return MyCustomMessageName.private;
    } else if (this == "connectfriends:privacy_multiple") {
      return MyCustomMessageName.packagePrivate;
    } else if (this == "connectfriends:datasyn") {
      return MyCustomMessageName.sync;
    } else if (this == "connectfriends:system_tips") {
      return MyCustomMessageName.systemTips;
    } else {
      return MyCustomMessageName.unknown;
    }
  }
}
