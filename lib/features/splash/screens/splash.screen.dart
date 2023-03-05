import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/splash/screens/widgets/splash.progress.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/constants.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  @override
  void initState() {
    context
        .read<AppBloc>()
        .add(LoadConfiguration(context, const <Configuration>[]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocListener<AppBloc, AppState>(
            listenWhen: (previous, current) =>
                previous.loadingPercent != current.loadingPercent,
            listener: ((context, state) {
              // if (state.configurations.isNotEmpty && state.loadingPercent < 1) {
              //   Future.delayed(const Duration(seconds: 1), () {
              //     var loadingPercent = state.loadingPercent + 0.5;
              //     context
              //         .read<AppBloc>()
              //         .add(LoadingPercentChanged(loadingPercent));
              //   });
              // }
              if (state.loadingPercent < 1) {
                Future.delayed(const Duration(seconds: 1), () {
                  var loadingPercent = state.loadingPercent + 0.5;
                  context
                      .read<AppBloc>()
                      .add(LoadingPercentChanged(loadingPercent));
                });
              }
              if (state.loadingPercent >= 1) {
                getUserCredentials().then((token) {
                  if (token != null) {
                    Navigator.pushReplacementNamed(
                        context, Routes.bottomBarScreen);
                  }
                });
                Navigator.pushReplacementNamed(context, Routes.authScreen);
              }
            }),
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Images.splashBackground,
                    ),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.6),
                child: Column(
                  children: [
                    Text(
                      context.l10n?.applicationName ?? 'Big Wallet',
                      style: const TextStyle(
                          color: Color(0xFFA8D930),
                          fontSize: 64,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      context.l10n?.slogan ?? 'Never lose money',
                      style: const TextStyle(
                          color: Color(0xFF262338),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    const SplashLinearProgressIndicator(),
                  ],
                ),
              ),
            )));
  }

  void getAllData() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Constants.BIG_WALLET);
  }
}

Future<String?> getUserCredentials() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(Constants.BIG_WALLET);
  return token;
}
