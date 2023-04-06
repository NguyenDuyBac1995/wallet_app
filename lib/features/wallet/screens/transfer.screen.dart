import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  String defaultValue = "";
  final TextEditingController _walletName = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  final List<Country> _countryList = countryList;
  final TextEditingController _initialAmount = TextEditingController();
  late Currency? _currency;
  final TextEditingController _controllerCurrency = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _currency = CurrencyService().findByCode('VND');
    super.initState();
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
          context.l10n?.textBottomSheetExchange ?? '',
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: const EdgeInsets.all(18),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: CustomStyle.borderRadiusFormFieldStyle,
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
                                child: Text('${context.l10n?.from}')),
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
                  Text(
                    currencyFormat.format(10000000),
                    style: TextStyles.text,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: const EdgeInsets.all(18),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: CustomStyle.borderRadiusFormFieldStyle,
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
                                value: "", child: Text('${context.l10n?.to}')),
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
                  Text(
                    currencyFormat.format(10000000),
                    style: TextStyles.text,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle,
                            ),
                            labelStyle: TextStyles.labelTextStyle,
                            suffixIcon: GestureDetector(
                              onTap: onHandleShowCurrency,
                              child: Container(
                                  padding: const EdgeInsets.only(left: 12.0),
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
                  TextFormField(
                    controller: _initialAmount,
                    decoration: InputDecoration(
                        hintText: context.l10n?.amount ?? '',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      controller: _initialAmount,
                      decoration: InputDecoration(
                          hintText: context.l10n?.fee ?? '',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                      controller: _note,
                      decoration: InputDecoration(
                          suffixIcon: const CustomIcon(
                            IconConstant.attachFile,
                            size: 24,
                          ),
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
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: CustomStyle.primaryButtonStyle,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(context.l10n?.btnSaveProfile ?? ''),
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
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                context.l10n?.cancel ?? '',
                                style: TextStyles.text,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              )),
        )),
      ),
    );
  }
}
