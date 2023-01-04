import 'package:big_wallet/core/routes/page.route.dart';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/screens/auth.screen.dart';
import 'package:big_wallet/features/auth/screens/forgot.new.password.screen.dart';
import 'package:big_wallet/features/auth/screens/information.screen.dart';
import 'package:big_wallet/features/auth/screens/signin.screen.dart';
import 'package:big_wallet/features/auth/screens/signup.information.screen.dart';
import 'package:big_wallet/features/auth/screens/signup.screen.dart';
import 'package:big_wallet/features/auth/screens/verify.otp.screen.dart';
import 'package:big_wallet/features/otp/screens/otp.screen.dart';
import 'package:big_wallet/features/splash/screens/splash.screen.dart';
import 'package:big_wallet/models/bundle.model.dart';
import 'package:flutter/material.dart';
import 'package:big_wallet/features/auth/screens/forgot.password.phone.screen.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;

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
        final callback = settings.arguments as Function(Object?);
        return GeneratePageRoute(
            widget: OtpScreen(callback: callback), routeName: settings.name);
      case Routes.authInformation:
        return GeneratePageRoute(
            widget: const AuthInformationScreen(), routeName: settings.name);
      case Routes.forgotPasswordPhoneScreen:
        return GeneratePageRoute(
            widget: const ForgotPasswordPhoneScreen(),
            routeName: settings.name);
      case Routes.verifyOtpScreen:
        if (args is BundleData) {
          return GeneratePageRoute(
              widget: VerifyOtpScreen(verifyCase: args.verifyCase),
              routeName: settings.name);
        }
        return GeneratePageRoute(
            widget: const VerifyOtpScreen(), routeName: settings.name);
      case Routes.forgotNewPasswordScreen:
        return GeneratePageRoute(
            widget: const ForgotNewPasswordScreen(), routeName: settings.name);
      case Routes.signupInformationScreen:
        return GeneratePageRoute(
            widget: const SignupInformationScreen(), routeName: settings.name);
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
