import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double height;
  final bool checkIcon;
  final bool checkClickRouter;
  final String routerName;
  final VoidCallback? onClicked;
  final VoidCallback? onClickedRouter;

  // final Function(string) onChange;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.height = 105,
      this.routerName = '/',
      this.checkIcon = false,
      this.checkClickRouter = false,
      this.onClicked,
      this.onClickedRouter});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration:
            const BoxDecoration(gradient: CustomColors.linearGradientAppBar),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: CustomColors.blackText,
                  size: 24,
                ),
                color: Colors.white,
                onPressed: checkClickRouter
                    ? onClickedRouter
                    : () {
                        routerName == '/'
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(context, routerName);
                      },
              ),
              title,
              checkIcon
                  ? GestureDetector(
                      onTap: onClicked,
                      child: const CustomIcon(
                        IconConstant.icRound,
                        size: 24,
                      ),
                    )
                  : Container(padding: const EdgeInsets.only(left: 50)),
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
