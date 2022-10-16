import 'package:big_wallet/core/routes/page.route.dart';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/screens/auth.screen.dart';
import 'package:big_wallet/features/splash/screens/splash.screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return GeneratePageRoute(
            widget: const SplashScreen(), routeName: settings.name);
      case Routes.authScreen:
        return GeneratePageRoute(
            widget: const AuthScreen(), routeName: settings.name);
      default:
        return GeneratePageRoute(
            widget: Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
            routeName: settings.name);
    }
  }
}
