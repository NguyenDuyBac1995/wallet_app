import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:big_wallet/features/auth/repositories/requests/signup.request.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final authRepository = AuthRepository();
  late String _uidFirebase;
  late String _phoneNumber;
  late bool _passwordVisible = false;
  late bool _isLoading = false;
  late List<dynamic>? configurations;
  late String _accessSystem;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _accessSystem = 'big-wallet';
    _uidFirebase = context.read<AuthBloc>().state.uid;
    _phoneNumber = context.read<AuthBloc>().state.phoneNumber;
  }

  Currency _currency = Currency(
      code: 'VND',
      name: 'Viet Nam Dong',
      symbol: '₫',
      flag: 'VND',
      number: 704,
      decimalDigits: 0,
      namePlural: 'Vietnamese dong',
      symbolOnLeft: false,
      decimalSeparator: '.',
      thousandsSeparator: '.',
      spaceBetweenAmountAndSymbol: true);
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
          });
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
  void dispose() {
    _controllerPassword.dispose();
    _controllerFullName.dispose();
    super.dispose();
  }

  void _onSignUp(context) async {
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      var response = await authRepository.signupAsync(
          context,
          SignUpRequest(
              displayName: _controllerFullName.text,
              user: _phoneNumber,
              password: _controllerPassword.text,
              firebaseUid: _uidFirebase,
              accessSystem: _accessSystem,
              configurations: [ConfigurationsModel(value: _currency.code)]));
      if (response) {
        Navigator.pushNamed(context, Routes.signInScreen);
      }
      setState(() {
        _isLoading = false;
      });
    }
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
                            hintText: '${context.l10n?.displayName}',
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
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                            }
                            return null;
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
                            hintText: '${context.l10n?.password}',
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
                            RegExp passwordRegExp = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.password}')} ';
                            }
                            if (!passwordRegExp.hasMatch(value)) {
                              return '${context.l10n?.invalidMessage('${context.l10n?.password}')} ';
                            }
                            return null;
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
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      CustomStyle.borderRadiusFormFieldStyle,
                                  borderSide: const BorderSide(
                                    color: Colors.black54,
                                  ),
                                ),
                                hintText: 'Display Name',
                                filled: true,
                                prefixIcon: GestureDetector(
                                  onTap: onHandleShowCurrency,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child:
                                        _buildCupertinoSelectedItem(_country),
                                  ),
                                ),
                                suffixIcon: Icon(Icons.arrow_drop_down),
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
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Expanded(
                            child: Text.rich(TextSpan(
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
                                ])),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  _onSignUp(context);

                                  // Navigator.pushNamed(
                                  //     context, Routes.signInScreen);
                                },
                                style: CustomStyle.primaryButtonStyle,
                                child: _isLoading
                                    ? const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Text('Loading'))
                                    : const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Text('Confirm'))),
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
