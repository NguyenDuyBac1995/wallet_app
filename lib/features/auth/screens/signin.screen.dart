import 'package:big_wallet/utilities/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late bool _passwordVisible = false;
  late bool _isFormValid = false;
  late PhoneNumber _phoneNumber;
  late TextEditingController _phoneNumberController;
  late bool _isPhoneNumberValid;
  late TextEditingController _passwordController;
  final RegExp _regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!&@#]).{8,}$');

  @override
  void initState() {
    _passwordVisible = false;
    _isFormValid = false;
    _phoneNumber = PhoneNumber(isoCode: 'VN');
    _phoneNumberController = TextEditingController();
    _isPhoneNumberValid = false;
    _passwordController = TextEditingController();
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
    // if (_passwordController.text.isEmpty) {
    //   setState(() {
    //     _isFormValid = false;
    //   });
    //   return;
    // }
    // if (!_regexPassword.hasMatch(_passwordController.text)) {
    //   setState(() {
    //     _isFormValid = false;
    //   });
    //   return;
    // }
    setState(() {
      _isFormValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  flex: 20,
                  child: InternationalPhoneNumberInput(
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
                    ),
                    inputDecoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.phone_android, color: Colors.grey),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: context.l10n?.phoneNumber),
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: _phoneNumber,
                    formatInput: false,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Colors.grey,
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: context.l10n?.password),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '${context.l10n?.forgotPassword}',
                        style: const TextStyle(color: Color(0xFFF19465)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (_isFormValid) {
                              var auth = FirebaseAuth.instance;
                              auth.verifyPhoneNumber(
                                phoneNumber: _phoneNumber.phoneNumber,
                                timeout: const Duration(seconds: 30),
                                verificationCompleted: (phoneAuthCredential) {
                                  Logger().i('verificationCompleted');
                                },
                                verificationFailed: (error) {
                                  Logger().i('verificationFailed');
                                },
                                codeSent:
                                    (verificationId, forceResendingToken) {
                                  Logger().i('codeSent');
                                },
                                codeAutoRetrievalTimeout: (verificationId) {
                                  Logger().i('codeAutoRetrievalTimeout');
                                },
                              );
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  _isFormValid
                                      ? const Color(0xFF262338)
                                      : const Color(0xFFD9DBE9)),
                              fixedSize: MaterialStateProperty.all(
                                  Size.fromWidth(
                                      MediaQuery.of(context).size.width *
                                          0.8))),
                          child: Text('${context.l10n?.signIn}')),
                    ],
                  ),
                ),
                Expanded(flex: 25, child: Container()),
              ],
            ),
          ),
          // Expanded(
          //     flex: 10,
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: Container(
          //               margin: const EdgeInsets.only(left: 10.0, right: 20.0),
          //               child: const Divider(
          //                 color: Colors.grey,
          //               )),
          //         ),
          //         Text(AppLocalizations.of(context)!.or),
          //         Expanded(
          //           child: Container(
          //               margin: const EdgeInsets.only(left: 20.0, right: 10.0),
          //               child: const Divider(
          //                 color: Colors.grey,
          //               )),
          //         ),
          //       ],
          //     )),
          Expanded(flex: 2, child: Container())
        ],
      ),
    );
  }
}
