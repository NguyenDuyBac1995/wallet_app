import 'package:flutter/material.dart';

class SplashLinearProgressIndicator extends StatelessWidget {
  const SplashLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              value: 0.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          Spacer(
            flex: 4,
          )
        ],
      ),
    );
  }
}
