import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/splash/blocs/splash.bloc.dart';
import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/features/splash/screens/widgets/splash.background.dart';
import 'package:big_wallet/features/splash/screens/widgets/splash.progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashBloc _splashBloc = SplashBloc(ConfigurationRepository());

  @override
  void initState() {
    _splashBloc.add(const LoadConfigurationEvent(10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => _splashBloc,
      child: BlocListener<SplashBloc, SplashState>(
          listenWhen: (previous, current) =>
              previous.loadingPercent < current.loadingPercent,
          listener: ((context, state) {
            if (state.loadingPercent == 100) {
              FocusScope.of(context).unfocus();
              Navigator.pushReplacementNamed(context, Routes.authScreen);
            }
          }),
          child: Stack(
            children: [
              const SplashBackground(),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: const [
                    Spacer(
                      flex: 3,
                    ),
                    Text(
                      "Big Wallet",
                      style: TextStyle(
                          color: Color(0xFFA8D930),
                          fontSize: 64,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Never lose money",
                      style: TextStyle(
                          color: Color(0xFF262338),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    SplashLinearProgressIndicator()
                  ],
                ),
              )
            ],
          )),
    ));
  }
}
