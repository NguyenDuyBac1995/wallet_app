import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;
  late bool _isFormValid;
  late bool _isPrivacyAccepted;
  late PhoneNumber _phoneNumber;
  late bool _isPhoneNumberValid;
  late TextEditingController _phoneNumberController;
  late TextEditingController _displayNameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final RegExp _regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!&@#]).{8,}$');

  @override
  void initState() {
    _phoneNumber = PhoneNumber(isoCode: 'VN');
    _isPhoneNumberValid = false;
    _isPrivacyAccepted = false;
    _isFormValid = false;
    _confirmPasswordVisible = false;
    _passwordVisible = false;
    _phoneNumberController = TextEditingController();
    _displayNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onChange() {
    if (!_isPhoneNumberValid || _phoneNumber.phoneNumber!.isEmpty) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    if (_displayNameController.text.isEmpty) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    if (!_isPrivacyAccepted) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    if (!_regexPassword.hasMatch(_passwordController.text)) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    setState(() {
      _isFormValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.authBackground), fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: SizedBox(
                  height: height * 0.6,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          SwitchLanguageWidget(
                            onChange: (value) {
                              context
                                  .read<AppBloc>()
                                  .add(ChangeLanguage(Locale(value)));
                            },
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                  height: height * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.05),
                            topRight: Radius.circular(width * 0.05)),
                        border: Border.all(color: Colors.black, width: 0.0)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('${context.l10n?.signUp}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700))),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          InternationalPhoneNumberInput(
                            textFieldController: _phoneNumberController,
                            onInputChanged: (value) {
                              if (_phoneNumber.phoneNumber !=
                                  value.phoneNumber) {
                                _phoneNumber = value;
                              }
                            },
                            onInputValidated: (value) {
                              if (value) {
                                _isPhoneNumberValid = value;
                                onChange();
                              }
                            },
                            selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                                trailingSpace: false),
                            inputDecoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone_android,
                                    color: Colors.grey),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                hintText: context.l10n?.phoneNumber),
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
                            initialValue: _phoneNumber,
                            formatInput: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          SizedBox(
                            height: height * 0.08,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      fixedSize: MaterialStateProperty.all(
                                        Size.fromWidth(width),
                                      )),
                                  child: Text('${context.l10n?.sendOtp}')),
                            ),
                          ),
                          SizedBox(
                              height: height * 0.03,
                              child: Row(children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: Text(
                                      '${context.l10n?.orLabel} ${context.l10n?.signUp.toLowerCase()} ${context.l10n?.withLabel}'),
                                ),
                                const Expanded(child: Divider()),
                              ])),
                          SizedBox(
                              height: height * 0.1,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(Images.facebookIcon),
                                      iconSize: height * 0.1,
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Image.asset(Images.googleIcon),
                                      iconSize: height * 0.1,
                                      onPressed: () {},
                                    )
                                  ])),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
