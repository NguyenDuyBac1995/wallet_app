import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:flutter/material.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String defaultValue = "";
  final TextEditingController _initialAmount = TextEditingController();
  final TextEditingController _note = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _initialAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    List dropDownListData = [
      {
        "title": "${context.l10n?.cash}",
        "value": "cash",
        "url": IconWallet.cashDrop
      },
      {
        "title": "${context.l10n?.bankAccount}",
        "value": "bankAccount",
        "url": IconWallet.bankAccountDrop
      },
      {
        "title": "${context.l10n?.creditCard}",
        "value": "creditCard",
        "url": IconWallet.creditCardDrop
      },
      {
        "title": "${context.l10n?.eWallet}",
        "value": "eWallet",
        "url": IconWallet.eWalletDrop
      },
      {
        "title": "${context.l10n?.investment}",
        "value": "investment",
        "url": IconWallet.investmentDrop
      },
      {
        "title": "${context.l10n?.other}",
        "value": "other",
        "url": IconWallet.otherDrop
      },
    ];
    List dropDownListDataCategory = [
      {
        "title": "${context.l10n?.salary}",
        "value": "salary",
        "url": IconWallet.salary
      },
      {
        "title": "${context.l10n?.bonus}",
        "value": "bonus",
        "url": IconWallet.golCoins
      },
      {
        "title": "${context.l10n?.sell}",
        "value": "sell",
        "url": IconWallet.coupon
      },
      {
        "title": "${context.l10n?.rent}",
        "value": "rent",
        "url": IconWallet.homeIncome
      },
      {
        "title": "${context.l10n?.affiliateMarketing}",
        "value": "affiliateMarketing",
        "url": IconWallet.payPerClick
      },
      {
        "title": "${context.l10n?.interest}",
        "value": "interest",
        "url": IconWallet.profit
      },
      {
        "title": "${context.l10n?.invest}",
        "value": "invest",
        "url": IconWallet.costAndBenefit
      },
      {
        "title": "${context.l10n?.otherIncome}",
        "value": "salary",
        "url": IconWallet.bankLocker
      },
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.textBottomSheetAddCard ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: const EdgeInsets.all(18),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius:
                                CustomStyle.borderRadiusFormFieldStyle,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              icon: const Icon(Icons.expand_more),
                              isDense: true,
                              value: defaultValue,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                DropdownMenuItem(
                                    value: "",
                                    child: Text(
                                        '${context.l10n?.selectWalletType}')),
                                ...dropDownListData
                                    .map<DropdownMenuItem<String>>((data) {
                                  return DropdownMenuItem(
                                    value: data['value'],
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomContainerListTitleWidget(
                                            width: 30,
                                            height: 30,
                                            urlImage: data['url']),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(data['title']),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                              onChanged: (value) {
                                print("selected Value $value");
                                setState(() {
                                  defaultValue = value!;
                                });
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: _initialAmount,
                          decoration: InputDecoration(
                              hintText: context.l10n?.initialAmount ?? '',
                              suffixIcon: const CustomIcon(
                                IconConstant.calculator,
                                size: 24,
                              ),
                              filled: true,
                              fillColor: CustomColors.backgroundTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      CustomStyle.borderRadiusFormFieldStyle),
                              labelStyle: TextStyles.labelTextStyle),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 18),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Icon(Icons.expand_more),
                                isDense: true,
                                value: defaultValue,
                                isExpanded: true,
                                menuMaxHeight: 350,
                                items: [
                                  DropdownMenuItem(
                                      value: "",
                                      child: Text('${context.l10n?.category}',
                                          style: TextStyles.text.copyWith(
                                              fontSize: 16,
                                              color: Colors.grey))),
                                  ...dropDownListDataCategory
                                      .map<DropdownMenuItem<String>>((data) {
                                    return DropdownMenuItem(
                                      value: data['value'],
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomContainerListTitleWidget(
                                              width: 30,
                                              height: 30,
                                              urlImage: data['url']),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(data['title']),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  print("selected Value $value");
                                  setState(() {
                                    defaultValue = value!;
                                  });
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 18),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Icon(Icons.expand_more),
                                isDense: true,
                                value: defaultValue,
                                isExpanded: true,
                                menuMaxHeight: 350,
                                items: [
                                  DropdownMenuItem(
                                      value: "",
                                      child: Text('${context.l10n?.payee}',
                                          style: TextStyles.text.copyWith(
                                              fontSize: 16,
                                              color: Colors.grey))),
                                ],
                                onChanged: (value) {
                                  print("selected Value $value");
                                  setState(() {
                                    defaultValue = value!;
                                  });
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _note,
                          decoration: InputDecoration(
                              hintText: context.l10n?.noteWallet ?? '',
                              filled: true,
                              fillColor: CustomColors.backgroundTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      CustomStyle.borderRadiusFormFieldStyle),
                              labelStyle: TextStyles.labelTextStyle),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {},
                                style: CustomStyle.primaryButtonStyle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child:
                                      Text(context.l10n?.btnSaveProfile ?? ''),
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: CustomStyle.defaultButtonStyle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    context.l10n?.cancel ?? '',
                                    style: TextStyles.text,
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
