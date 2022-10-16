import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static show(BuildContext context, String message,
      {IconData? icon,
      Color backgroundColor = const Color(0xFFC14545),
      Color messageColor = Colors.white,
      ToastGravity? gravity = ToastGravity.TOP,
      Duration duration = const Duration(seconds: 2),
      Widget Function(BuildContext, Widget)? positionedToastBuilder}) {
    var fToast = FToast();
    fToast.init(context);
    fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon),
              if (icon != null)
                const SizedBox(
                  width: 12.0,
                ),
              Text(
                message,
                style: TextStyle(color: messageColor),
              ),
            ],
          ),
        ),
        gravity: gravity,
        toastDuration: duration,
        positionedToastBuilder: positionedToastBuilder);
  }
}
