import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<String> iconList;
  const CustomBottomNavigationBar(
      {super.key,
      this.defaultSelectedIndex = 0,
      required this.iconList,
      required this.onChange});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<String> _iconList = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];
    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(String icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / _iconList.length,
        decoration: const BoxDecoration(
          color: CustomColors.backgroundNavBar,
        ),
        child: CustomIcon(
          icon,
          color: index == _selectedIndex
              ? CustomColors.colorIconNavBarActive
              : CustomColors.colorIconNavBar,
          size: 24,
        ),
      ),
    );
  }
}
