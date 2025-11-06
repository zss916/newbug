import 'dart:async';

import 'package:get/get.dart';

class EventService extends GetxService {
  static EventService get to => Get.find();

  final StreamController _streamController = StreamController.broadcast();

  void post(dynamic event) => _streamController.add(event);

  StreamSubscription<T> listen<T>(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final result = _streamController.stream
        .where((event) => event is T)
        .cast<T>();
    return result.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

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

class HomeTab {
  HomeTab();
}

/*class HomeViewState {
  final int viewState;
  HomeViewState({required this.viewState});
}*/
