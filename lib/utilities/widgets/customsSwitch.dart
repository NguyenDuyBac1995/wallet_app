import 'package:big_wallet/utilities/custom_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomsSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChangeMethod;
  const CustomsSwitch(
      {super.key, required this.value, required this.onChangeMethod});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
        -10,
        0,
        0,
      ),
      child: Transform.scale(
        scale: 0.6,
        child: CupertinoSwitch(
          trackColor: Colors.grey,
          activeColor: CustomColors.colorOceanBlue,
          value: value,
          onChanged: (value) {
            onChangeMethod(value);
          },
        ),
      ),
    );
  }
}
