import 'package:big_wallet/features/bottom_bar/screens/widgets/custom_bottom.navigation.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../settings/screens/setting.screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
    const Text("Page 1"),
    const Text("Page 2"),
    const Text("Page 3"),
    const Text("Page 4"),
    const SettingsScreen()
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: const [
          IconMenu.chartPieIcon,
          IconMenu.walletIcon,
          IconMenu.cashMoneyIcon,
          IconMenu.newsIcon,
          IconMenu.profileIcon,
        ],
        onChange: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
        defaultSelectedIndex: 0,
      ),
    );
  }
}
