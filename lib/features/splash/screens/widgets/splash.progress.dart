import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashLinearProgressIndicator extends StatefulWidget {
  const SplashLinearProgressIndicator({super.key});

  @override
  State<SplashLinearProgressIndicator> createState() =>
      _SplashLinearProgressIndicatorState();
}

class _SplashLinearProgressIndicatorState
    extends State<SplashLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: ((context, state) {
        return Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  value: state.loadingPercent,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
              const Spacer(
                flex: 4,
              )
            ],
          ),
        );
      }),
    );
  }
}
