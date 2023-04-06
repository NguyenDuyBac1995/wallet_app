import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/wallet/blocs/wallet_bloc/wallet_bloc.dart';
import 'package:big_wallet/features/wallet/repositories/requests/wallets_requests.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/common.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:big_wallet/utilities/widgets/customsSwitch.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddWallet extends StatefulWidget {
  final String titleApp;

  const AddWallet({super.key, this.titleApp = 'new'});

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
  late bool _isLoading;
  final List<Country> _countryList = countryList;
  bool _isActiveSwitch = false;
  String defaultValue = "";
  String secondDropDown = "";
  late Currency? _currency;
  @override
  void initState() {
    // TODO: implement initState
    _currency = CurrencyService().findByNumber(704);
    _isLoading = false;
    if (widget.titleApp != 'new') {
      context
          .read<WalletBloc>()
          .add(GetByIdWalletEvent(context, widget.titleApp));
    }
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

  onChangeFunctionActive(bool newValue) {
    setState(() {
      _isActiveSwitch = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    List dropDownListData = [
      {
        "title": "${context.l10n?.cash}",
        "value": "2",
        "url": IconWallet.cashDrop
      },
      {
        "title": "${context.l10n?.bankAccount}",
        "value": "1",
        "url": IconWallet.bankAccountDrop
      },
      {
        "title": "${context.l10n?.creditCard}",
        "value": "3",
        "url": IconWallet.creditCardDrop
      },
      {
        "title": "${context.l10n?.eWallet}",
        "value": "5",
        "url": IconWallet.eWalletDrop
      },
      {
        "title": "${context.l10n?.investment}",
        "value": "4",
        "url": IconWallet.investmentDrop
      },
      {
        "title": "${context.l10n?.other}",
        "value": "0",
        "url": IconWallet.otherDrop
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.titleApp == 'new'
            ? Text(
                context.l10n?.addNewWallet ?? '',
                style: TextStyles.h1,
              )
            : BlocBuilder<WalletBloc, WalletState>(
                buildWhen: (previous, current) {
                  return current is WalletByIdLoaded;
                },
                builder: (context, state) {
                  if (state is WalletByIdLoaded) {
                    return Text(
                      '${context.l10n?.textBottomSheetEdit}',
                      style: TextStyles.h1,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
        checkClickRouter: true,
        onClickedRouter: () {
          Navigator.pop(context);
          context.read<WalletBloc>().add(GetListWalletEvent(context, ''));
        },
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: SingleChildScrollView(
          child: SafeArea(
              child: BlocListener<WalletBloc, WalletState>(
            listenWhen: (previous, current) {
              return current is WalletByIdLoaded;
            },
            listener: (context, state) {
              // TODO: implement listener
              if (state is WalletByIdLoaded) {
                _walletName.text = state.responseWalletById.name != null
                    ? state.responseWalletById.name!
                    : '';

                _creditLimit.text =
                    state.responseWalletById.extraProperties!.isEmpty
                        ? Common().getValueByKey(
                            state.responseWalletById.extraProperties!,
                            "CreditLimit")
                        : '';
                _bank.text = state.responseWalletById.extraProperties!.isEmpty
                    ? Common().getValueByKey(
                        state.responseWalletById.extraProperties!, "BankName")
                    : '';

                _initialBalance.text =
                    state.responseWalletById.balance!.toString();
                _note.text = state.responseWalletById.note!;
                setState(() {
                  _currency = CurrencyService()
                      .findByNumber(state.responseWalletById.currency!);
                  defaultValue = state.responseWalletById.type!.toString();
                  _isActiveSwitch =
                      state.responseWalletById.extraProperties!.isEmpty
                          ? Common()
                                  .getValueByKey(
                                      state.responseWalletById.extraProperties!,
                                      "CreditLimit")
                                  .toLowerCase() ==
                              'true'
                          : false;
                });
              }
            },
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormField(
                        initialValue: defaultValue,
                        validator: (value) {
                          if (value == null || value == '') {
                            return '${context.l10n?.requiredMessage('${context.l10n?.selectWalletType}')} ';
                          }
                          return null;
                        },
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              contentPadding: const EdgeInsets.all(18),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius:
                                    CustomStyle.borderRadiusFormFieldStyle,
                              ),
                              errorText:
                                  state.hasError ? state.errorText : null,
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
                                    state.didChange(value);
                                    setState(() {
                                      defaultValue = value!;
                                    });
                                  }),
                            ),
                          );
                        }),
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
                          return '${context.l10n?.requiredMessage('${context.l10n?.walletName}')} ';
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
                    defaultValue == '1' || defaultValue == '3'
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
                                  return '${context.l10n?.requiredMessage('${context.l10n?.bank}')} ';
                                }
                                return null;
                              },
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _initialBalance,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        // _NumberInputFormatter(),
                      ],
                      keyboardType: TextInputType.number,
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
                          return '${context.l10n?.requiredMessage('${context.l10n?.initialBalance}')} ';
                        }
                        return null;
                      },
                    ),
                    defaultValue == '3'
                        ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(children: [
                              // TextFormField(
                              //   keyboardType: TextInputType
                              //       .number, // Chỉ cho phép nhập số
                              //   controller: _initialBalance,
                              //   decoration: InputDecoration(
                              //       hintText:
                              //           context.l10n?.initialBalance ?? '',
                              //       filled: true,
                              //       fillColor:
                              //           CustomColors.backgroundTextFormField,
                              //       floatingLabelBehavior:
                              //           FloatingLabelBehavior.always,
                              //       border: OutlineInputBorder(
                              //           borderRadius: CustomStyle
                              //               .borderRadiusFormFieldStyle),
                              //       labelStyle: TextStyles.labelTextStyle),
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return '${context.l10n?.requiredMessage('${context.l10n?.initialBalance}')} ';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              TextFormField(
                                controller: _creditLimit,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                    hintText: context.l10n?.creditLimit ?? '',
                                    suffixIcon: const CustomIcon(
                                      IconConstant.calculator,
                                      size: 24,
                                    ),
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
                                    return '${context.l10n?.requiredMessage('${context.l10n?.creditLimit}')} ';
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
                        validator: (value) {}),
                    defaultValue == '3'
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                CustomsSwitch(
                                    value: _isActiveSwitch,
                                    onChangeMethod: onChangeFunctionActive),
                                Text('${context.l10n?.alertExceeded}')
                              ],
                            ),
                          )
                        : Container(),
                    _btnSubmitDetail()
                  ],
                )),
          )),
        ),
      ),
    );
  }

  Widget _btnSubmitDetail() {
    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is CreateWalletLoaded) {
          if (state.isSuccess) {
            Toast.show(context, '${context.l10n?.successWalletCreate}',
                backgroundColor: Colors.green);
            Navigator.pop(context);
            context.read<WalletBloc>().add(GetListWalletEvent(context, ''));
          }
        }
        if (state is UpdateWalletLoaded) {
          if (state.isSuccess) {
            Toast.show(context, '${context.l10n?.updateWalletCreate}',
                backgroundColor: Colors.green);
            Navigator.pop(context);
            context.read<WalletBloc>().add(GetListWalletEvent(context, ''));
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: widget.titleApp == 'new'
            ? Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (defaultValue == '1') {
                                    context.read<WalletBloc>().add(
                                        CreateWalletEvent(
                                            context,
                                            RequestCreateWallet(
                                                name: _walletName.text,
                                                initialBalance:
                                                    int.tryParse(
                                                        _initialBalance.text),
                                                note: _note.text,
                                                type:
                                                    int.tryParse(defaultValue),
                                                currency: _currency?.number,
                                                extraProperties: [
                                                  ExtraProperties(
                                                      context: 'Wallet',
                                                      key: 'BankName',
                                                      value: _bank.text)
                                                ])));
                                  } else if (defaultValue == '3') {
                                    context.read<WalletBloc>().add(
                                        CreateWalletEvent(
                                            context,
                                            RequestCreateWallet(
                                                name: _walletName.text,
                                                initialBalance: int.tryParse(
                                                    _initialBalance.text),
                                                note: _note.text,
                                                type:
                                                    int.tryParse(defaultValue),
                                                currency: _currency?.number,
                                                extraProperties: [
                                                  ExtraProperties(
                                                    context: 'Wallet',
                                                    key: 'BankName',
                                                    value: _bank.text,
                                                  ),
                                                  ExtraProperties(
                                                    context: 'Wallet',
                                                    key: 'CreditLimit',
                                                    value: _creditLimit.text,
                                                  ),
                                                  ExtraProperties(
                                                    context: 'Wallet',
                                                    key: 'NotifyWhenItsDue',
                                                    value: _isActiveSwitch
                                                        ? 'True'
                                                        : 'False',
                                                  )
                                                ])));
                                  } else {
                                    context.read<WalletBloc>().add(
                                        CreateWalletEvent(
                                            context,
                                            RequestCreateWallet(
                                                name: _walletName.text,
                                                initialBalance: int.tryParse(
                                                    _initialBalance.text),
                                                note: _note.text,
                                                type:
                                                    int.tryParse(defaultValue),
                                                currency: _currency?.number)));
                                  }

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                        style: CustomStyle.primaryButtonStyle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(context.l10n?.btnSaveProfile ?? ''),
                        )),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (defaultValue == '1') {
                                    context.read<WalletBloc>().add(
                                        UpdateWalletEvent(
                                            context,
                                            RequestUpdateWallet(
                                                id: widget.titleApp,
                                                requestUpdateWallet:
                                                    RequestCreateWallet(
                                                        extraProperties: [
                                                      ExtraProperties(
                                                        context: 'Wallet',
                                                        key: 'BankName',
                                                        value: _bank.text,
                                                      ),
                                                    ],
                                                        name: _walletName.text,
                                                        initialBalance:
                                                            int.tryParse(
                                                                _initialBalance
                                                                    .text),
                                                        note: _note.text,
                                                        type: int.tryParse(
                                                            defaultValue),
                                                        currency: _currency
                                                            ?.number))));
                                  } else if (defaultValue == '3') {
                                    context.read<WalletBloc>().add(
                                        UpdateWalletEvent(
                                            context,
                                            RequestUpdateWallet(
                                                id: widget.titleApp,
                                                requestUpdateWallet:
                                                    RequestCreateWallet(
                                                        extraProperties: [
                                                      ExtraProperties(
                                                        context: 'Wallet',
                                                        key: 'BankName',
                                                        value: _bank.text,
                                                      ),
                                                      ExtraProperties(
                                                        context: 'Wallet',
                                                        key: 'CreditLimit',
                                                        value:
                                                            _creditLimit.text,
                                                      ),
                                                      ExtraProperties(
                                                        context: 'Wallet',
                                                        key: 'NotifyWhenItsDue',
                                                        value: _isActiveSwitch
                                                            ? 'True'
                                                            : 'False',
                                                      )
                                                    ],
                                                        name: _walletName.text,
                                                        initialBalance:
                                                            int.tryParse(
                                                                _initialBalance
                                                                    .text),
                                                        note: _note.text,
                                                        type: int.tryParse(
                                                            defaultValue),
                                                        currency: _currency
                                                            ?.number))));
                                  } else {
                                    context.read<WalletBloc>().add(
                                        UpdateWalletEvent(
                                            context,
                                            RequestUpdateWallet(
                                                id: widget.titleApp,
                                                requestUpdateWallet:
                                                    RequestCreateWallet(
                                                        name: _walletName.text,
                                                        initialBalance:
                                                            int.tryParse(
                                                                _initialBalance
                                                                    .text),
                                                        note: _note.text,
                                                        type: int.tryParse(
                                                            defaultValue),
                                                        currency: _currency
                                                            ?.number))));
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                        style: CustomStyle.primaryButtonStyle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(context.l10n?.btnUpdateProfile ?? ''),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: CustomStyle.deleteButtonStyle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            context.l10n?.deleteWallet ?? '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                  ),
                ],
              ),
      ),
    );
  }
}

// class _NumberInputFormatter extends TextInputFormatter {
//   final NumberFormat _numberFormat = NumberFormat('#,##0', 'en_US');
//   final formatter = NumberFormat('#,##0', 'en_US');

//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final oldText = oldValue.text;
//     final newText = newValue.text;

//     // Allow backspace.
//     if (oldText.length >= newText.length) {
//       return newValue;
//     }

//     // Format the input text with number separators.
//     final unformattedValue = int.tryParse(newText.replaceAll(',', ''));
//     if (unformattedValue != null) {
//       final formattedValue = _numberFormat.format(unformattedValue);
//       return newValue.copyWith(text: formattedValue);
//     } else {
//       return oldValue;
//     }
//   }
// }
