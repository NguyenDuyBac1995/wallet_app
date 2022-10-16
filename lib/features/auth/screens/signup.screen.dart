import 'package:big_wallet/utilities/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          Expanded(
            flex: 15,
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
            flex: 15,
            child: TextFormField(
              controller: _displayNameController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: context.l10n?.displayName),
              onChanged: ((value) => onChange()),
            ),
          ),
          Expanded(
            flex: 15,
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
              onChanged: ((value) => onChange()),
            ),
          ),
          Expanded(
            flex: 15,
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_confirmPasswordVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.key, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(_confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: context.l10n?.confirmPassword),
              onChanged: ((value) => onChange()),
            ),
          ),
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(context.l10n?.passwordWarning ??
                  'Password must be at least 6 characters including numbers, letters and punctuation (like ! and &)'),
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  child: Checkbox(
                      value: _isPrivacyAccepted,
                      onChanged: (value) {
                        setState(() => _isPrivacyAccepted = value ?? false);
                        onChange();
                      })),
              // You can play with the width to adjust your
              // desired spacing
              Expanded(
                child: Wrap(
                  children: [
                    Text(context.l10n?.signUpAcceptLabel ?? 'Accept'),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          ' ${context.l10n?.termsOfService}',
                          style: const TextStyle(color: Color(0xFFF19465)),
                        )),
                    Text(' ${context.l10n?.ofLabel}'),
                    Text('${context.l10n?.applicationName}'),
                  ],
                ),
              )
            ]),
          ),
          Expanded(
            flex: 15,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_isFormValid) {
                        var auth = FirebaseAuth.instance;
                        auth.verifyPhoneNumber(
                          phoneNumber: _phoneNumber.phoneNumber,
                          timeout: const Duration(seconds: 60),
                          verificationCompleted: (phoneAuthCredential) {
                            auth
                                .signInWithCredential(phoneAuthCredential)
                                .then((dynamic result) {
                              Logger().i(result);
                            }).catchError((e) {
                              Logger().i(e);
                            });
                          },
                          verificationFailed: (error) {
                            Logger().i(error);
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            Logger().i(verificationId);
                          },
                          codeAutoRetrievalTimeout: (verificationId) {},
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(_isFormValid
                            ? const Color(0xFF262338)
                            : const Color(0xFFD9DBE9)),
                        fixedSize: MaterialStateProperty.all(Size.fromWidth(
                            MediaQuery.of(context).size.width * 0.8))),
                    child: Text(context.l10n?.signUp ?? 'Sign up')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
