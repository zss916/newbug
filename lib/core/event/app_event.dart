import 'package:newbug/core/network/model/user_entity.dart';

/// event
class HomeMenuEvent {
  final bool isShow;
  HomeMenuEvent({required this.isShow});
}

///action
class HomeMenuAction {
  final MenuActionEmu action;
  HomeMenuAction({required this.action});
}

enum MenuActionEmu { like, flashChat, next, other }

extension MenuActionExtension on int {
  MenuActionEmu get toAction {
    switch (this) {
      case 0:
        return MenuActionEmu.like;
      case 1:
        return MenuActionEmu.flashChat;
      case 2:
        return MenuActionEmu.next;
      default:
        return MenuActionEmu.other;
    }
  }
}

class OpenMenuEvent {
  final bool isOpen;
  OpenMenuEvent({required this.isOpen});
}

class ShowMatchCountTipEvent {
  final bool isShow;
  final int count;
  ShowMatchCountTipEvent({required this.isShow, required this.count});
}

class MainTab {
  final int tab;
  MainTab({required this.tab});
}

///刷新用户 (Me,Profile)
class RefreshUserEvent {
  UserEntity? user;
  RefreshUserEvent({this.user});
}
