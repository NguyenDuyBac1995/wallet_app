import 'package:big_wallet/utilities/assets.dart';
import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          Images.splashBackground,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
