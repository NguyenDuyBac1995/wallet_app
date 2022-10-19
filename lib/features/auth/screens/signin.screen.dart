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
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('${context.l10n?.signIn}',
                style: const TextStyle(fontSize: 24))),
        const SizedBox(
          height: 10,
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
          ),
          inputDecoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone_android, color: Colors.grey),
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
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _passwordController,
          obscureText: !_passwordVisible,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key, color: Colors.grey),
              suffixIcon: IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
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
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Text(
              '${context.l10n?.forgotPassword}',
              style: const TextStyle(color: Color(0xFFF19465)),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
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
                  codeSent: (verificationId, forceResendingToken) {
                    Logger().i('codeSent');
                  },
                  codeAutoRetrievalTimeout: (verificationId) {
                    Logger().i('codeAutoRetrievalTimeout');
                  },
                );
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(_isFormValid
                    ? const Color(0xFF262338)
                    : const Color(0xFFD9DBE9)),
                fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(MediaQuery.of(context).size.width))),
            child: Text('${context.l10n?.signIn}')),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Chưa có tài khoản?'),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Đăng ký',
                style: TextStyle(color: Color(0xFFF19465)),
              ),
            )
          ],
        )
      ],
    );
  }
}
