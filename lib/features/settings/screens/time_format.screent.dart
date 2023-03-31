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

class TimeFormatScreen extends StatefulWidget {
  const TimeFormatScreen({super.key});

  @override
  State<TimeFormatScreen> createState() => _TimeFormatScreenState();
}

class _TimeFormatScreenState extends State<TimeFormatScreen> {
  late String valueActive;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.titleTimeFormat ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: BlocSelector<AppBloc, AppState, String>(
        selector: (state) {
          valueActive = state.valueDate;
          return state.valueDate;
        },
        builder: (context, state) {
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 0),
                  title: InkWell(
                    onTap: () {
                      context
                          .read<AppBloc>()
                          .add(const TimeFormatChanged('dd'));
                    },
                    child: Text(
                      'dd/MM/yyyy',
                      style: TextStyles.textMenuItem.copyWith(
                          fontSize: 15, color: CustomColors.colorOceanBlue),
                    ),
                  ),
                  trailing: valueActive == 'dd'
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
                  title: InkWell(
                    onTap: () {
                      context
                          .read<AppBloc>()
                          .add(const TimeFormatChanged('mm'));
                    },
                    child: Text(
                      'MM/dd/yyyy',
                      style: TextStyles.textMenuItem.copyWith(
                          fontSize: 15, color: CustomColors.colorOceanBlue),
                    ),
                  ),
                  trailing: valueActive == 'mm'
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
                  title: InkWell(
                    onTap: () {
                      context
                          .read<AppBloc>()
                          .add(const TimeFormatChanged('yy'));
                    },
                    child: Text(
                      'yyyy/MM/dd',
                      style: TextStyles.textMenuItem.copyWith(
                          fontSize: 15, color: CustomColors.colorOceanBlue),
                    ),
                  ),
                  trailing: valueActive == 'yy'
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
