import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:country_pickers/country.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({super.key});

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _walletName = TextEditingController();
  final TextEditingController _initialBalance = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _creditLimit = TextEditingController();
  final TextEditingController _controllerCurrency = TextEditingController();
  final List<Country> _countryList = countryList;
  String defaultValue = "";
  String secondDropDown = "";
  late Currency? _currency;
  @override
  void initState() {
    // TODO: implement initState
    _currency = CurrencyService().findByCode('VND');
    super.initState();
  }

  @override
  void dispose() {
    _walletName.dispose();
    _initialBalance.dispose();
    _note.dispose();
    _bank.dispose();
    _creditLimit.dispose();
    super.dispose();
  }

  // list Currency
  void onHandleShowCurrency() => showCurrencyPicker(
        context: context,
        showFlag: true,
        showCurrencyName: true,
        showCurrencyCode: true,
        onSelect: (Currency currency) {
          setState(() {
            _controllerCurrency.text = currency.name;
            _currency = currency;
          });
        },
      );
  Widget _buildCupelationSelectedItem() {
    return Row(
      children: <Widget>[
        Text(
          " ${_currency?.name} ${_currency?.symbol}",
          style: TextStyles.text.copyWith(fontSize: 13),
        ),
      ],
    );
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

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.addNewWallet ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
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
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _walletName,
                        decoration: InputDecoration(
                            hintText: context.l10n?.walletName ?? '',
                            filled: true,
                            fillColor: CustomColors.backgroundTextFormField,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          decoration: CustomStyled.boxShadowDecoration,
                          child: GestureDetector(
                            onTap: onHandleShowCurrency,
                            child: TextFormField(
                              enabled: false,
                              controller: _controllerCurrency,
                              decoration: InputDecoration(
                                hintText: context.l10n?.labelTextCurrency ?? '',
                                filled: true,
                                fillColor: CustomColors.backgroundTextFormField,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      CustomStyle.borderRadiusFormFieldStyle,
                                ),
                                labelStyle: TextStyles.labelTextStyle,
                                suffixIcon: GestureDetector(
                                  onTap: onHandleShowCurrency,
                                  child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: _buildCupelationSelectedItem()),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      CustomStyle.borderRadiusFormFieldStyle,
                                  borderSide: const BorderSide(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              validator: (value) {},
                            ),
                          )),
                      defaultValue == 'bankAccount'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                controller: _bank,
                                decoration: InputDecoration(
                                    hintText: context.l10n?.bank ?? '',
                                    filled: true,
                                    fillColor:
                                        CustomColors.backgroundTextFormField,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                        borderRadius: CustomStyle
                                            .borderRadiusFormFieldStyle),
                                    labelStyle: TextStyles.labelTextStyle),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : Container(),
                      defaultValue == 'creditCard'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(children: [
                                TextFormField(
                                  controller: _initialBalance,
                                  decoration: InputDecoration(
                                      hintText:
                                          context.l10n?.initialBalance ?? '',
                                      filled: true,
                                      fillColor:
                                          CustomColors.backgroundTextFormField,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius: CustomStyle
                                              .borderRadiusFormFieldStyle),
                                      labelStyle: TextStyles.labelTextStyle),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: _creditLimit,
                                  decoration: InputDecoration(
                                      hintText: context.l10n?.creditLimit ?? '',
                                      filled: true,
                                      fillColor:
                                          CustomColors.backgroundTextFormField,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius: CustomStyle
                                              .borderRadiusFormFieldStyle),
                                      labelStyle: TextStyles.labelTextStyle),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                            )
                          : Container(),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _initialBalance,
                        decoration: InputDecoration(
                            hintText: context.l10n?.initialBalance ?? '',
                            suffixIcon: const CustomIcon(
                              IconConstant.calculator,
                              size: 24,
                            ),
                            filled: true,
                            fillColor: CustomColors.backgroundTextFormField,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _note,
                        decoration: InputDecoration(
                            hintText: context.l10n?.noteWallet ?? '',
                            filled: true,
                            fillColor: CustomColors.backgroundTextFormField,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
