import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class SignupInformationScreen extends StatefulWidget {
  const SignupInformationScreen({super.key});

  @override
  State<SignupInformationScreen> createState() => _SignupInformationScreen();
}

class _SignupInformationScreen extends State<SignupInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerFullName = TextEditingController();
  final TextEditingController _controllerCurrency = TextEditingController();
  late bool _passwordVisible = false;
  Currency _currency = Currency(code: 'VND', name: 'Viet Nam Dong', symbol: '₫', flag: 'VND', number: 704, decimalDigits: 0, namePlural: 'Vietnamese dong', symbolOnLeft: false, decimalSeparator: '.', thousandsSeparator: '.', spaceBetweenAmountAndSymbol: true);
  late Country _country = CountryPickerUtils.getCountryByIsoCode('vn');

  void _togglePasswordStatus() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

   void onHandleShowCurrency() => showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        setState(() {
          _controllerCurrency.text = currency.name;
          _currency = currency;
          // _country = CountryPickerUtils.getCountryByIsoCode(currency.code);
        });

      print('Select currency: ${currency.name}');
      print('Select namePlural: ${currency.namePlural}');
      print('Select symbol: ${currency.symbol}');
      print('Select code: ${currency.code}');
        print('Select flag: ${currency.flag}');
        print('Select number: ${currency.number}');
        print('Select decimalDigits: ${currency.decimalDigits}');
        print('Select decimalSeparator: ${currency.decimalSeparator}');
        print('Select thousandsSeparator: ${currency.thousandsSeparator}');
        print('Select symbolOnLeft: ${currency.symbolOnLeft}');
        print('Select spaceBetweenAmountAndSymbol: ${currency.spaceBetweenAmountAndSymbol}');
    },
  );

  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        // CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8.0),
        Text("${_currency.name} ${_currency.symbol}"),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // setState(() {
    //   _controllerCurrency.text ='asdasdasdasd';
    // });
    super.initState();
  }

  @override
  void dispose() {
    _controllerPassword.dispose();
    _controllerFullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.sigInBackground), fit: BoxFit.fill)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const <Widget>[
                  Text(
                    'Sign Up',
                    style: TextStyles.textHeader,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: CustomStyled.boxShadowDecoration,
                        child: TextFormField(
                          controller: _controllerFullName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // No border
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Display Name',
                            fillColor: CustomColors.gray,
                            filled: true,

                            prefixIcon: const CustomIcon(
                              IconConstant.profileIcon,
                              color: CustomColors.primaryColor,
                              size: 24,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return StringApp.VALIDATE_EMPTY_FIELD;
                            // }
                            // return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: CustomStyled.boxShadowDecoration,
                        child: TextFormField(
                          controller: _controllerPassword,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // No border
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Password',
                            fillColor: CustomColors.gray,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 24,
                              ),
                              onPressed: _togglePasswordStatus,
                              color: CustomColors.primaryColor,
                            ),
                            prefixIcon: const CustomIcon(
                              IconConstant.keyIcon,
                              color: CustomColors.primaryColor,
                              size: 24,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return StringApp.VALIDATE_EMPTY_FIELD;
                            // }
                            // return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: CustomStyled.boxShadowDecoration,
                        child: GestureDetector(
                          onTap: onHandleShowCurrency,
                          child: TextFormField(
                            enabled: false,
                            controller: _controllerCurrency,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none, // No border
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Display Name',

                              filled: true,

                              prefixIcon: GestureDetector(
                                onTap: onHandleShowCurrency,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: _buildCupertinoSelectedItem(_country),

                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return StringApp.VALIDATE_EMPTY_FIELD;
                              // }
                              // return null;
                            },
                          ),
                        )
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Expanded(child:  Text.rich(TextSpan(
                              text: 'By tapping "Sign Up" you agree to our',
                              style: TextStyles.textSubHeader,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ' Terms of Use',
                                  style: TextStyles.textSubHeaderColorPink,
                                ),
                                TextSpan(
                                  text: ' and',
                                  style: TextStyles.textSubHeader,
                                ),
                                TextSpan(
                                  text: ' Privacy Policy',
                                  style: TextStyles.textSubHeaderColorPink,
                                ),
                              ])),)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.signInScreen);
                                },
                                style: CustomStyle.primaryButtonStyle,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text('Confirm'),
                                )),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
