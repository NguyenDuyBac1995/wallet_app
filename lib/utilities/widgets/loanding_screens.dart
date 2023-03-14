import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreens extends StatelessWidget {
  const LoadingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 500,
        child: SpinKitCircle(
          color: Color(0xFFA8D930),
          size: 80.0,
        ),
      ),
    );
  }
}
