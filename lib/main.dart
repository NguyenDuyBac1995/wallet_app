import 'package:big_wallet/core/routes/generator.route.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/features/splash/screens/splash.screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MainScreen());
  // runApp(
  //   DevicePreview(
  //     enabled: false,
  //     builder: (context) => const MainScreen(), // Wrap your app
  //   ),
  // );
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppBloc(ConfigurationRepository()),
        child: BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) => previous.locale != current.locale,
            builder: ((context, state) {
              return MaterialApp(
                  useInheritedMediaQuery: true,
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
                    Locale('en', ''),
                    Locale('vi', ''),
                  ],
                  locale: state.locale,
                  home: const SplashScreen(),
                  builder: DevicePreview.appBuilder,
                  onGenerateRoute: RouteGenerator.generate);
            })));
  }
}
