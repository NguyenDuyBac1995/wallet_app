import 'package:big_wallet/core/routes/app.route.dart';
import 'package:big_wallet/core/routes/generator.route.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/blocs/finance/finance.bloc.dart';
import 'package:big_wallet/features/auth/blocs/primary/primary.bloc.dart';
import 'package:big_wallet/features/settings/blocs/profiles_blocs/profiles.bloc.dart';
import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/features/splash/screens/splash.screen.dart';
import 'package:big_wallet/features/transaction/blocs/category_blocs/category_blocs_bloc.dart';
import 'package:big_wallet/features/wallet/blocs/wallet_bloc/wallet_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp();
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(ConfigurationRepository()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => PrimaryBloc(),
          ),
          BlocProvider(
            create: (context) => ProfilesBloc(),
          ),
          BlocProvider(
            create: (context) => WalletBloc(),
          ),
          BlocProvider(
            create: (context) => CategoriesBlocsBloc(),
          ),
          BlocProvider(create: (context) => FinanceBloc())
        ],
        child: BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) => previous.locale != current.locale,
            builder: ((context, state) {
              return MaterialApp(
                  navigatorKey: AppRoute.navigatorKey,
                  useInheritedMediaQuery: true,
                  title: 'Big Wallet',
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
