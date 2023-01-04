import 'package:big_wallet/utilities/custom_color.dart';
import 'package:flutter/material.dart';
class CustomStyle {

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      backgroundColor: CustomColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // <-- Radius
      ),
  );

  static ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),
      foregroundColor:CustomColors.primaryColor,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side:const  BorderSide(
            color: CustomColors.borderButtonColor,
            width: 1,
            style: BorderStyle.solid
        )// <-- Radius
      ),
  );
}