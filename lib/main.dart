import 'package:big_wallet/core/routes/generator.route.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/features/splash/screens/splash.screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AppBloc(ConfigurationRepository()))
    ],
    child: DevicePreview(
      enabled: true,
      builder: (context) => const MainScreen(),
    ),
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
      title: 'Big Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', ''),
        Locale('en', ''),
      ],
      home: const SplashScreen(),
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
