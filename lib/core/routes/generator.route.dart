import 'package:big_wallet/core/routes/page.route.dart';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/screens/auth.screen.dart';
import 'package:big_wallet/features/auth/screens/signin.screen.dart';
import 'package:big_wallet/features/auth/screens/signup.screen.dart';
import 'package:big_wallet/features/otp/models/otp.type.dart';
import 'package:big_wallet/features/otp/screens/otp.screen.dart';
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
      case Routes.signInScreen:
        return GeneratePageRoute(
            widget: const SignInScreen(), routeName: settings.name);
      case Routes.signUpScreen:
        return GeneratePageRoute(
            widget: const SignUpScreen(), routeName: settings.name);
      case Routes.otpScreen:
        final type = settings.arguments as OtpType;
        return GeneratePageRoute(
            widget: OtpScreen(type: type), routeName: settings.name);
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
