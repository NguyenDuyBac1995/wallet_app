import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomContainerWidget extends StatelessWidget {
  final Widget child;
  const CustomContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
            bottom: Radius.circular(10),
          ),
          color: CustomColors.colorBoxShadowMenuItem,
          boxShadow: [CustomStyle.boxShadowMenuStyle],
        ),
        child: child);
  }
}

class CustomContainerListTitleWidget extends StatelessWidget {
  static const double width = 40;
  static const double height = 40;
  final String urlImage;
  const CustomContainerListTitleWidget({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(urlImage), fit: BoxFit.fill),
      ),
    );
  }
}
