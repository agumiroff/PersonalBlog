import 'package:flutter/material.dart';

class GlobalNavigationService {
  final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName) {
    return globalNavigatorKey.currentState?.pushNamed(routeName);
  }
}
