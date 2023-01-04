import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  final String path;
  final Color? color;
  final double? size;

  const CustomIcon(
      this.path, {
        Key? key,
        this.color,
        this.size = 24,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path,
        height: size, width: size, color: color, fit: BoxFit.scaleDown);
  }
}