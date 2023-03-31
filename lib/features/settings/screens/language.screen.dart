import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/widgets/custom_container.widget.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String valueActive;

  onChangeActive(String value) {
    setState(() {
      valueActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.titlelanguage ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: BlocSelector<AppBloc, AppState, String>(
        selector: (state) {
          valueActive = state.locale.languageCode;
          return state.locale.languageCode;
        },
        builder: (context, state) {
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 0),
                  leading: const CustomContainerListTitleWidget(
                      width: 42, height: 30, urlImage: IconSetting.flagsVi),
                  title: InkWell(
                    onTap: () {
                      context
                          .read<AppBloc>()
                          .add(const LanguageChanged(Locale('vi')));
                    },
                    child: Text(
                      'Tiếng việt',
                      style: TextStyles.textMenuItem.copyWith(
                          fontSize: 15, color: CustomColors.colorOceanBlue),
                    ),
                  ),
                  trailing: valueActive == 'vi'
                      ? const CustomContainerListTitleWidget(
                          width: 30,
                          height: 30,
                          urlImage: IconSetting.flagsActive)
                      : null,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFD9DBE9),
                ),
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 0),
                  leading: const CustomContainerListTitleWidget(
                      width: 42, height: 30, urlImage: IconSetting.flagsEn),
                  title: InkWell(
                    onTap: () {
                      context
                          .read<AppBloc>()
                          .add(const LanguageChanged(Locale('en')));
                      // onChangeActive(state);
                    },
                    child: Text(
                      'English',
                      style: TextStyles.textMenuItem.copyWith(
                          fontSize: 15, color: CustomColors.colorOceanBlue),
                    ),
                  ),
                  trailing: valueActive == 'en'
                      ? const CustomContainerListTitleWidget(
                          width: 30,
                          height: 30,
                          urlImage: IconSetting.flagsActive)
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
