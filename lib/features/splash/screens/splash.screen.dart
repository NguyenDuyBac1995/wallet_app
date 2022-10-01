import 'dart:io';

import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/features/splash/screens/widgets/splash.background.dart';
import 'package:big_wallet/features/splash/screens/widgets/splash.progress.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppBloc _appBloc = AppBloc(ConfigurationRepository());
  @override
  void initState() {
    _appBloc.add(const LoadConfiguration(<Configuration>[]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [BlocProvider(create: (_) => _appBloc)],
      child: BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) =>
              previous.loadingPercent != current.loadingPercent,
          listener: ((context, state) {
            if (state.configurations.isNotEmpty && state.loadingPercent < 1) {
              sleep(const Duration(seconds: 1));
              var loadingPercent = state.loadingPercent + 0.1;
              _appBloc.add(ChangeLoadingPercent(loadingPercent));
            }
            /*if (state.loadingPercent > 1) {
              // ignore: use_build_context_synchronously
              FocusScope.of(context).unfocus();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, Routes.authScreen);
            }*/
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
