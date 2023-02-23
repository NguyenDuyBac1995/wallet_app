import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/settings/screens/widgets/custom_container.widget.dart';
import 'package:big_wallet/features/settings/screens/widgets/profile.widget.dart';
// import 'package:big_wallet/features/settings/screens/widgets/profile_menu.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const user = UserPreferences.myUser;
    print('${context.l10n?.signUp}');
    return Scaffold(
      body: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.sigInBackground), fit: BoxFit.fill)),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 30),
              ProfileWidget(imagePath: user.imagePath, onClicked: () async {}),
              const SizedBox(height: 15),
              Text(
                user.name,
                style: TextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              CustomContainerWidget(
                child: ListTile(
                  leading: const CustomContainerListTitleWidget(
                      urlImage: IconSetting.coffeeCupIcon),
                  title: Text(context.l10n?.titleCoffee ?? '',
                      style: TextStyles.textMenuItem),
                  subtitle: Text(
                    context.l10n?.descCoffee ?? '',
                    style: TextStyles.text.copyWith(fontSize: 11),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomContainerWidget(
                  child: Column(
                children: [
                  ListTile(
                    leading: const CustomContainerListTitleWidget(
                        urlImage: IconSetting.websiteIcon),
                    title: Text(context.l10n?.editPersona ?? '',
                        style: TextStyles.textMenuItem),
                  ),
                  ListTile(
                    leading: const CustomContainerListTitleWidget(
                        urlImage: IconSetting.profileIcon),
                    title: Text(context.l10n?.manageProfile ?? '',
                        style: TextStyles.textMenuItem),
                  ),
                  ListTile(
                    leading: const CustomContainerListTitleWidget(
                        urlImage: IconSetting.passwordIcon),
                    title: Text(context.l10n?.updatePassword ?? '',
                        style: TextStyles.textMenuItem),
                  )
                ],
              )),
              const SizedBox(height: 30),
              CustomContainerWidget(
                  child: Column(
                children: [
                  ListTile(
                    leading: const CustomContainerListTitleWidget(
                        urlImage: IconSetting.deviceIcon),
                    title: Text(context.l10n?.generalSetting ?? '',
                        style: TextStyles.textMenuItem),
                  ),
                  ListTile(
                    leading: const CustomContainerListTitleWidget(
                        urlImage: IconSetting.starsIcon),
                    title: Text(context.l10n?.rateUs ?? '',
                        style: TextStyles.textMenuItem),
                  ),
                  ListTile(
                    leading: const CustomContainerListTitleWidget(
                        urlImage: IconSetting.logoutIcon),
                    title: Text(context.l10n?.logout ?? '',
                        style: TextStyles.textMenuItem),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.splashScreen);
                    },
                  )
                ],
              )),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}
