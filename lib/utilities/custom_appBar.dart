import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double height;
  final String routerName;
  // final Function(string) onChange;

  const CustomAppBar({
    super.key,
    required this.title,
    this.height = 105,
    this.routerName = '/',
  });

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
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: CustomColors.blackText,
                  size: 24,
                ),
                color: Colors.white,
                onPressed: () {
                  routerName == '/'
                      ? Navigator.pop(context)
                      : Navigator.pushNamed(context, routerName);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              title
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
