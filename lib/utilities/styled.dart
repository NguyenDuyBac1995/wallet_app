import 'package:big_wallet/utilities/custom_color.dart';
import 'package:flutter/material.dart';


class CustomStyled {
  static BoxDecoration boxShadowDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
  );

  static InputDecoration inputDecorationBorderNone({String placeholder = ''}) {
    return InputDecoration(
      hintText: placeholder,
      fillColor: CustomColors.gray,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none, // No border
        borderRadius:
        BorderRadius.circular(10), // Apply corner radius
      ),
      contentPadding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 10),
    );
  }
}