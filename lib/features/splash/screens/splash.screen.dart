import 'package:big_wallet/features/splash/blocs/splash.bloc.dart';
import 'package:big_wallet/features/splash/screens/widgets/splash.background.dart';
import 'package:big_wallet/features/splash/screens/widgets/splash.progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(builder: ((context, state) {
        if (state is SplashInitialState) {
          context.read<SplashBloc>().add(LoadConfigurationEvent());
          return const CircularProgressIndicator();
        }
        return Stack(
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
        );
      })),
    );
  }
}
