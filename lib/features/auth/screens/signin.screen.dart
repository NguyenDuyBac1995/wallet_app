import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible = false;
  late bool _isFormValid = false;
  late PhoneNumber number = PhoneNumber(isoCode: 'VN');
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    _passwordVisible = false;
    _isFormValid = false;
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
            flex: 55,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(flex: 10, child: Container()),
                    Expanded(
                      flex: 30,
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (value) {},
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        inputDecoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone_android,
                                color: Colors.grey),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.phoneNumber),
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.key, color: Colors.grey),
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
                      flex: 20,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.forgotPassword,
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
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      _isFormValid
                                          ? const Color(0xFF262338)
                                          : const Color(0xFFD9DBE9)),
                                  fixedSize: MaterialStateProperty.all(
                                      Size.fromWidth(
                                          MediaQuery.of(context).size.width *
                                              0.8))),
                              child:
                                  Text(AppLocalizations.of(context)!.signIn)),
                        ],
                      ),
                    ),
                  ],
                )),
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
          Expanded(flex: 40, child: Container())
        ],
      ),
    );
  }
}
