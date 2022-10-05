import 'package:big_wallet/features/app/blocs/app.bloc.dart';
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
  @override
  void initState() {
    context.read<AppBloc>().add(const LoadConfiguration(<Configuration>[]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AppBloc, AppState>(
            listenWhen: (previous, current) =>
                previous.loadingPercent != current.loadingPercent,
            listener: ((context, state) {
              if (state.configurations.isNotEmpty && state.loadingPercent < 1) {
                Future.delayed(const Duration(seconds: 1), () {
                  var loadingPercent = state.loadingPercent + 0.5;
                  context
                      .read<AppBloc>()
                      .add(ChangeLoadingPercent(loadingPercent));
                });
              }
              if (state.loadingPercent >= 1) {
                //Navigator.pushReplacementNamed(context, Routes.authScreen);
              }
            }),
            child: Stack(
              children: [
                const SplashBackground(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                      ),
                      const Text(
                        "Big Wallet",
                        style: TextStyle(
                            color: Color(0xFFA8D930),
                            fontSize: 64,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Never lose money",
                        style: TextStyle(
                            color: Color(0xFF262338),
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SplashLinearProgressIndicator(),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
