import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Text('${context.l10n?.signUp}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text('Nhập số điện thoại của bạn để tạo tài khoản mới'),
                  ),
                  SizedBox(
                    height: height * 0.03,
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
                        prefixIcon:
                            const Icon(Icons.phone_android, color: Colors.grey),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: const UnderlineInputBorder(
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
                  Row(children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: Text(
                          '${context.l10n?.orLabel} ${context.l10n?.signUp.toLowerCase()} ${context.l10n?.withLabel}'),
                    ),
                    const Expanded(child: Divider()),
                  ]),
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
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Row(
                    children: [
                      const Text('Bằng việc tiếp tục bạn đã ok với điều khoản'),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(Icons.navigate_next),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
