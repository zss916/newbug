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

class OpenMenuEvent {
  final bool isOpen;
  OpenMenuEvent({required this.isOpen});
}
