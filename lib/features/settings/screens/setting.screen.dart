import 'dart:convert';

import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/finance/finance.bloc.dart';
import 'package:big_wallet/features/auth/blocs/primary/primary.bloc.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:big_wallet/features/auth/repositories/requests/revokeToken.request.dart';
import 'package:big_wallet/features/settings/screens/widgets/custom_container.widget.dart';
import 'package:big_wallet/features/settings/screens/widgets/profile.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/constants.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final authRepository = AuthRepository();
  late double _uidFirebase;

  void _onLogout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? dataUser = pref.getString(Constants.BIG_WALLET);
    if (dataUser != null) {
      Map<String, dynamic> revokeToken = json.decode(dataUser);
      await authRepository.revokeTokenAsync(context,
          RevokeTokenRequest(refreshToken: revokeToken['RefreshToken']));
    }
    pref.remove(Constants.BIG_WALLET);
    Navigator.pushNamed(context, Routes.splashScreen);
  }

  @override
  void initState() {
    _uidFirebase = context.read<AppBloc>().state.loadingPercent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const user = UserPreferences.myUser;
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
              BlocBuilder<PrimaryBloc, PrimaryState>(builder: (context, state) {
                return Text(
                  '${state.primaryData.displayName}',
                  style: TextStyles.h2,
                  textAlign: TextAlign.center,
                );
              }),
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
                      onTap: () {
                        Navigator.pushNamed(context, Routes.editProfileScreen);
                      }),
                  ListTile(
                      leading: const CustomContainerListTitleWidget(
                          urlImage: IconSetting.profileIcon),
                      title: Text(context.l10n?.manageProfile ?? '',
                          style: TextStyles.textMenuItem),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.recordsManagement);
                      }),
                  ListTile(
                      leading: const CustomContainerListTitleWidget(
                          urlImage: IconSetting.passwordIcon),
                      title: Text(context.l10n?.updatePassword ?? '',
                          style: TextStyles.textMenuItem),
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.updatePassWordScreen);
                      })
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
                    onTap: () async {
                      _onLogout(context);
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
