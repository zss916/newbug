import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/route/observer/routers_observer.dart';

extension GetExtension on GetInterface {
  List<Route<dynamic>> get history => appRoutesObserver.history;

  bool containName(String name) {
    return getRouteByName(name) != null;
  }

  Route? getRouteByName(String name) {
    var index = history.lastIndexWhere(
      (element) => element.settings.name == name,
    );
    if (index != -1) {
      return history[index];
    }
    return null;
  }

  List<Route> getRoutesByName(String name) {
    return history.where((element) => element.settings.name == name).toList();
  }

  void removeName(String name) {
    var route = getRouteByName(name);
    if (route != null) {
      Get.removeRoute(route);
    }
  }

  void removeAllName(String name) {
    var routes = getRoutesByName(name);
    for (var o in routes) {
      Get.removeRoute(o);
    }
  }
}
