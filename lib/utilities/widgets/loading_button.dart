import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final double width;
  final Widget text;
  const LoadingButton({super.key, required this.width, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: width * 0.04,
            width: width * 0.04,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.grey,
              strokeWidth: 3,
            ),
          ),
          SizedBox(
            width: width * 0.05,
          ),
          text,
        ]);
  }
}
