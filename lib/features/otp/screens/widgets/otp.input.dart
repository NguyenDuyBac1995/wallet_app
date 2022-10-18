import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final TextEditingController controller;
  final Function(String) onChanged;
  const OtpInputWidget(
      {super.key,
      this.width,
      this.height,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: width,
        width: height,
        child: TextField(
          decoration: const InputDecoration(hintText: '0'),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          controller: controller,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
            onChanged(value);
          },
        ));
  }
}
