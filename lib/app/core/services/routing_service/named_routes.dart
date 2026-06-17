// import 'package:flutter/material.dart';
import 'package:clean_architecture_example_app/app/core/services/routing_service/app_routes.dart';
// import 'package:clean_architecture_example_app/app/modules/authantication/presentation/screens/login_screen.dart';
import 'package:clean_architecture_example_app/app/modules/countries/presentation/screen/country_currency_screen.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/screens/home_screen.dart';
import 'package:clean_architecture_example_app/app/modules/popular_animes/presentation/screen/popular_anime_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import 'package:pakistan_cables_mobile/src/core/services/routing_service/app_routes.dart';

class AppRouterGo {
  static BuildContext get context =>
      appRouter.routerDelegate.navigatorKey.currentContext!;

  static final appRouter = GoRouter(
    routes: [
      GoRoute(
        path: loginScreen,
        builder: (context, state) {
          return const PopularAnimeScreen();
        },
      ),

      GoRoute(
        path: homeScreen,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    ],
  );

  static void back() {
    if (context.canPop()) {
      context.pop();
    }
  }

  static void push(
    location, {
    Map<String, dynamic>? extra,
    Future<void> Function()? onThen,
  }) {
    context.push(location, extra: extra).then((value) {
      onThen?.call();
    });
  }

  static void pushRemoveUntil(location) {
    context.go(location);
  }

  static void pushReplacement(location) {
    context.replace(location);
  }
}
