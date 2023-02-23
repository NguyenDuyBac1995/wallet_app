import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      // required this.onPress,
      this.endIcon = true,
      this.textColor,
      required this.l10n});

  final String title;
  final String icon;
  // final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage(icon))),
      ),
      title: Text(title),
    );
  }
}
