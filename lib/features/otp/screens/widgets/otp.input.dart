import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const OtpInputWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: width,
        width: height,
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ));
  }
}
