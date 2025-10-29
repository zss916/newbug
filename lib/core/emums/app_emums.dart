///1男 2女 3非二元
enum SexEmu {
  male(value: 1),
  female(value: 2),
  intersex(value: 3);

  final int value;

  const SexEmu({required this.value});

  static int getValue(int value) =>
      SexEmu.values.firstWhere((e) => e.value == value).value;
}

///用户状态上报 status：0 切到后台，1 切到前台 2活跃，3 不活跃 4退出登录
enum UserStatusEmu {
  background(value: 0),
  foreground(value: 1),
  active(value: 2),
  inactive(value: 3),
  exit(value: 4);

  final int value;

  const UserStatusEmu({required this.value});

  static int getValue(int value) =>
      UserStatusEmu.values.firstWhere((e) => e.value == value).value;
}

///   //0，请求订阅商品信息 1请求flashchat商品信息 2、请求privatevideo商品信息 3、请求private photo商品信息
enum PayEmu { vip, flashChat, privateVideo, privatePhoto }
