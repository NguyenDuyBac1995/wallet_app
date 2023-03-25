import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/settings/screens/widgets/custom_container.widget.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  bool inputNotice = false;
  bool hideMount = false;
  bool notificationNew = false;

  onChangeFunctionInputNotice(bool newValue) {
    setState(() {
      inputNotice = newValue;
    });
  }

  onChangeFunctionHideMount(bool newValue) {
    setState(() {
      hideMount = newValue;
    });
  }

  onChangeFunctionNotificationNew(bool newValue) {
    setState(() {
      notificationNew = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.titleGeneral ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Container(
          width: width,
          height: height,
          color: const Color(0xFFEFF0F6),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${context.l10n?.display}",
                  style: TextStyles.text
                      .copyWith(color: const Color(0xFF6E7191), fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomContainerWidget(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(children: [
                      CustomChildListRow(
                        childLeft: Text(
                          '${context.l10n?.titlelanguage}',
                          style: TextStyles.text,
                        ),
                        childRight: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.languageScreen);
                          },
                          child: Text(
                            "${context.l10n?.valueLanguage}",
                            style: TextStyles.text
                                .copyWith(color: CustomColors.colorOceanBlue),
                          ),
                        ),
                      ),
                      const Divider(),
                      BlocSelector<AppBloc, AppState, String>(
                        selector: (state) {
                          return state.valueDate;
                        },
                        builder: (context, state) {
                          return CustomChildListRow(
                            childLeft: Text(
                              '${context.l10n?.titleTimeFormat}',
                              style: TextStyles.text,
                            ),
                            childRight: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.timeFormatScreen);
                              },
                              child: Text(
                                state == 'dd'
                                    ? 'dd/MM/yyyy'
                                    : state == 'mm'
                                        ? 'MM/dd/yyyy'
                                        : 'yyyy/MM/dd',
                                style: TextStyles.text.copyWith(
                                    color: CustomColors.colorOceanBlue),
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      CustomChildListRow(
                        childLeft: Text(
                          '${context.l10n?.titleCurrencySetting}',
                          style: TextStyles.text,
                        ),
                        childRight: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.currencySettingScreen);
                          },
                          child: Text(
                            "VND",
                            style: TextStyles.text
                                .copyWith(color: CustomColors.colorOceanBlue),
                          ),
                        ),
                      ),
                      const Divider(),
                      CustomChildListRow(
                          childLeft: Text(
                            '${context.l10n?.titleHideAmount}',
                            style: TextStyles.text,
                          ),
                          childRight: customsSwitch(
                              hideMount, onChangeFunctionHideMount)),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "${context.l10n?.titleNotification}",
                  style: TextStyles.text
                      .copyWith(color: const Color(0xFF6E7191), fontSize: 15),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomContainerWidget(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(children: [
                          CustomChildListRow(
                              childLeft: Text(
                                '${context.l10n?.titleInputNotice}',
                                style: TextStyles.text,
                              ),
                              childRight: customsSwitch(
                                  inputNotice, onChangeFunctionInputNotice)),
                          const Divider(),
                          CustomChildListRow(
                              childLeft: Text(
                                '${context.l10n?.titleNotificationVersion}',
                                style: TextStyles.text,
                                overflow: TextOverflow.ellipsis,
                              ),
                              childRight: customsSwitch(notificationNew,
                                  onChangeFunctionNotificationNew)),
                        ])))
              ],
            ),
          )),
    );
  }

  Widget customsSwitch(bool value, Function onChangeMethod) {
    return Transform.scale(
      scale: 0.6,
      child: CupertinoSwitch(
        trackColor: Colors.grey,
        activeColor: CustomColors.colorOceanBlue,
        value: value,
        onChanged: (value) {
          onChangeMethod(value);
        },
      ),
    );
  }
}
