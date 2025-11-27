import 'package:flutter/material.dart';

AppRouteObserver appRoutesObserver = AppRouteObserver();

///记录路由历史
class AppRouteObserver extends RouteObserver<PageRoute> {
  List<Route<dynamic>> history = <Route<dynamic>>[];

  List<String> historyPage = [];

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    history.remove(route);
    historyPage.remove(route.settings.name ?? "");
    debugPrint("historyPage pop:${historyPage.toString()}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    history.add(route);
    historyPage.add(route.settings.name ?? "");
    debugPrint("historyPage push:${historyPage.toString()}");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    history.remove(route);
    historyPage.remove(route.settings.name ?? "");
    debugPrint("historyPage remove:${historyPage.toString()}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      history.remove(oldRoute);
      historyPage.remove(oldRoute.settings.name ?? "");
    }
    if (newRoute != null) {
      history.add(newRoute);
      historyPage.add(newRoute.settings.name ?? "");
    }
    debugPrint("historyPage replace:${historyPage.toString()}");
  }
}
