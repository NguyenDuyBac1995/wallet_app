import 'package:big_wallet/utilities/assets.dart';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: FractionallySizedBox(
        alignment: Alignment.topCenter,
        heightFactor: 1,
        widthFactor: 1,
        child: FittedBox(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          child: Image.asset(
            Images.authBackground,
          ),
        ),
      ),
    );
  }
}
