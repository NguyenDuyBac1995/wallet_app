import 'package:flutter/material.dart';

import 'custom_color.dart';

class TextStyles {
  static const TextStyle  textSize30Bold700 = TextStyle(
    fontSize: 30,
    color: CustomColors.primaryColor,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle textSize14ColorOrange = TextStyle(
    fontSize: 14,
    color: CustomColors.orange,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle textHeader = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1E232C),
  );
  static const TextStyle textSubHeader = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1E232C),
  );
  static const TextStyle textSubHeaderColorRed = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFFBA1A1A),
  );

  static const TextStyle textSubHeaderColorPink = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFFF19465),
  );
}