import 'package:clean_architecture_example_app/app/core/services/routing_service/named_routes.dart';
import 'package:flutter/material.dart';


class AppRouter {
  static void back() {
    if (Navigator.canPop(AppRouterGo.context)) {
      Navigator.pop(AppRouterGo.context);
    }
  }

  static push(page) async {
    await Navigator.push(
      AppRouterGo.context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static pushReplacement(page) async {
    await Navigator.pushReplacement(
      AppRouterGo.context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static pushAndRemoveUntil(page) async {
    await Navigator.pushAndRemoveUntil(
      AppRouterGo.context,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }
}
