import 'package:big_wallet/utilities/localization.dart';
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
  late bool? _isPrivacyAccepted;
  late PhoneNumber number;
  late TextEditingController _phoneNumberController;
  late TextEditingController _displayNameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  @override
  void initState() {
    number = PhoneNumber(isoCode: 'VN');
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
    Logger().i('number $number');
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
                if (number.phoneNumber != value.phoneNumber) number = value;
              },
              onInputValidated: (value) {
                if (value) onChange();
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
              initialValue: number,
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
                        setState(() => _isPrivacyAccepted = value);
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
                    onPressed: () {},
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
