import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late bool _passwordVisible = false;
  late bool _isFormValid = false;
  late bool? _isPrivacyAccepted = false;
  late PhoneNumber number = PhoneNumber(isoCode: 'VN');
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    _passwordVisible = false;
    _isFormValid = false;
    _isPrivacyAccepted = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Expanded(flex: 5, child: Container()),
              Expanded(
                flex: 15,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (value) {},
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
                      hintText: AppLocalizations.of(context)!.phoneNumber),
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: controller,
                  formatInput: false,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                ),
              ),
              Expanded(
                flex: 15,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.grey),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: AppLocalizations.of(context)!.displayName),
                ),
              ),
              Expanded(
                flex: 15,
                child: TextFormField(
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
                      hintText: AppLocalizations.of(context)!.password),
                ),
              ),
              Expanded(
                flex: 10,
                child: TextFormField(
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
                      hintText: AppLocalizations.of(context)!.confirmPassword),
                ),
              ),
              Expanded(
                flex: 15,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                        Text(AppLocalizations.of(context)!.signUpAcceptLabel),
                        TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              ' ${AppLocalizations.of(context)!.termsOfService}',
                              style: const TextStyle(color: Color(0xFFF19465)),
                            )),
                        Text(' ${AppLocalizations.of(context)!.ofLabel}'),
                        Text(
                            ' ${AppLocalizations.of(context)!.applicationName}'),
                      ],
                    ),
                  )
                ]),
              ),
              Expanded(
                flex: 20,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                _isFormValid
                                    ? const Color(0xFF262338)
                                    : const Color(0xFFD9DBE9)),
                            fixedSize: MaterialStateProperty.all(Size.fromWidth(
                                MediaQuery.of(context).size.width * 0.8))),
                        child: Text(AppLocalizations.of(context)!.signUp)),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(),
              )
            ],
          )),
        ],
      ),
    );
  }
}
