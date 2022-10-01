import 'package:big_wallet/core/routes/generator.route.dart';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/splash/blocs/splash.bloc.dart';
import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/features/splash/screens/splash.screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MainScreen(),
  ));
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
