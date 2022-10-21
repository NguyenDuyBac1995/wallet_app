import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
import 'package:big_wallet/features/otp/models/otp.type.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late bool _isFormValid;
  late PhoneNumber _phoneNumber;
  late bool _isPhoneNumberValid;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    _phoneNumber = PhoneNumber(isoCode: 'VN');
    _isPhoneNumberValid = false;
    _isFormValid = false;
    _phoneNumberController = TextEditingController();
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
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Images.authBackground,
                  ),
                  fit: BoxFit.fill),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${context.l10n?.welcome}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  InternationalPhoneNumberInput(
                    textFieldController: _phoneNumberController,
                    onInputChanged: (value) {
                      if (_phoneNumber.phoneNumber != value.phoneNumber) {
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
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        trailingSpace: false),
                    inputDecoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEFF0F7),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintText: context.l10n?.phoneNumber),
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: _phoneNumber,
                    formatInput: false,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.otpScreen,
                              arguments: OtpType.firebase);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                _isFormValid ? Colors.black : Colors.grey),
                            foregroundColor: MaterialStateProperty.all(
                                _isFormValid ? Colors.white : Colors.black),
                            fixedSize: MaterialStateProperty.all(
                              Size.fromWidth(width),
                            )),
                        child: Text('${context.l10n?.signUp}')),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(children: [
                    const Expanded(
                        child: Divider(
                      color: Colors.black,
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: Text(
                          '${context.l10n?.orLabel} ${context.l10n?.signUp.toLowerCase()} ${context.l10n?.withLabel}'),
                    ),
                    const Expanded(
                        child: Divider(
                      color: Colors.black,
                    )),
                  ]),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
