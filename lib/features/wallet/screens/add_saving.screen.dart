import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:big_wallet/utilities/widgets/customsSwitch.dart';
import 'package:country_pickers/countries.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:intl/intl.dart';

class AddSavingScreen extends StatefulWidget {
  const AddSavingScreen({super.key});

  @override
  State<AddSavingScreen> createState() => _AddSavingScreenState();
}

class _AddSavingScreenState extends State<AddSavingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _walletName = TextEditingController();
  final TextEditingController _initialTargetSaving = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _creditLimit = TextEditingController();
  final TextEditingController _goalSaving = TextEditingController();
  final TextEditingController _initialAmount = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _controllerCurrency = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool _isActiveSwitch = false;

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
    _initialTargetSaving.dispose();
    _note.dispose();
    _bank.dispose();
    _initialAmount.dispose();
    _goalSaving.dispose();
    _amount.dispose();
    dateController.dispose();
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

  onChangeFunctionActive(bool newValue) {
    setState(() {
      _isActiveSwitch = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    List dropDownListData = [];

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.addSaving ?? '',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _goalSaving,
                          decoration: InputDecoration(
                              hintText: context.l10n?.goalSaving ?? '',
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
                                      '${context.l10n?.ownerSaving}',
                                      style: TextStyles.text.copyWith(
                                          color: const Color.fromARGB(
                                              195, 0, 0, 0)),
                                    )),
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
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _initialTargetSaving,
                        decoration: InputDecoration(
                            hintText: context.l10n?.targetSaving ?? '',
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
                        controller: _initialAmount,
                        decoration: InputDecoration(
                            hintText: context.l10n?.initialAmount ?? '',
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
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                              hintText: context.l10n?.startDate ?? '',
                              suffixIcon: const CustomIcon(
                                IconConstant.calendarIcon,
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
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(0001),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat("yyyy-MM-dd").format(pickedDate);
                              setState(() {
                                dateController.text = formattedDate.toString();
                              });
                            } else {
                              print("Not selected");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                              hintText: context.l10n?.endDate ?? '',
                              suffixIcon: const CustomIcon(
                                IconConstant.calendarIcon,
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
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(0001),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat("yyyy-MM-dd").format(pickedDate);
                              setState(() {
                                dateController.text = formattedDate.toString();
                              });
                            } else {
                              print("Not selected");
                            }
                          },
                        ),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 5),
                        child: Divider(
                          height: 2,
                        ),
                      ),
                      Row(
                        children: [
                          CustomsSwitch(
                              value: _isActiveSwitch,
                              onChangeMethod: onChangeFunctionActive),
                          Text('${context.l10n?.periodicallySaving}')
                        ],
                      ),
                      _isActiveSwitch
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    controller: _note,
                                    decoration: InputDecoration(
                                        hintText:
                                            context.l10n?.noteWallet ?? '',
                                        filled: true,
                                        fillColor: CustomColors
                                            .backgroundTextFormField,
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, top: 15),
                                  child: TextFormField(
                                    controller: _amount,
                                    decoration: InputDecoration(
                                        hintText: context.l10n?.amount ?? '',
                                        suffixIcon: const CustomIcon(
                                          IconConstant.calculator,
                                          size: 24,
                                        ),
                                        filled: true,
                                        fillColor: CustomColors
                                            .backgroundTextFormField,
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: TextFormField(
                                    controller: _amount,
                                    decoration: InputDecoration(
                                        hintText:
                                            context.l10n?.fromAccount ?? '',
                                        suffixIcon: const CustomIcon(
                                          IconConstant.calculator,
                                          size: 24,
                                        ),
                                        filled: true,
                                        fillColor: CustomColors
                                            .backgroundTextFormField,
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
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 5,
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
                        ],
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
