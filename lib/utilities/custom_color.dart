import 'package:flutter/material.dart';

class CustomColors {
  static const Color primaryColor = Color(0xFF008889);
  static const Color borderButtonColor = Color(0xFF262338);
  static const Color gray = Color(0xFFEFF0F7);
  static const Color orange = Color(0xFFF19465);
  static const Color blackTitle = Color(0xFF1a202c);
  static const Color blackText = Color(0xFF1A202C);
  static const Color backgroundNavBar = Color(0xFFFFFFFF);
  static const Color colorIconNavBar = Color(0xFFA9AD9B);
  static const Color colorIconNavBarActive = Color(0xFFA8D930);
  static const Color colorBoxShadowBottomBar = Color.fromRGBO(9, 0, 93, 0.06);
  static const Color colorBoxShadowMenuItem = Color(0xFFF8FFF8);
  static const Color colorGreen = Color(0xFFF3FFF3);
  static const LinearGradient linearGradientAppBar = LinearGradient(
    colors: [
      Color(0xFFA8D930),
      Color.fromRGBO(168, 217, 48, 0.4),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1],
  );
  static const Color backgroundTextFormField = Color(0xFFFCFCFC);
  static const Color backgroundBtnLoading = Color(0xFFD9DBE9);
  static const Color colorOceanBlue = Color(0xFF008889);
  static const Color backgroundColorItemWallet = Color(0xFFF3FFF3);
}
