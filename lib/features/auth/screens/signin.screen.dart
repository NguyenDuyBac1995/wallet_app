import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/screens/widgets/custom.country.select.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_pickers/country_pickers.dart';

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
  late bool _isPhoneNumberValid;
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final  Country _selectedCountry = CountryPickerUtils.getCountryByIsoCode('vn');
  final RegExp _regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!&@#]).{8,}$');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
    _isFormValid = false;
    _phoneNumber = PhoneNumber(isoCode: 'VN');
    _isPhoneNumberValid = false;
    super.initState();
  }

  void _togglePasswordStatus() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 85,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: CustomIcon(
                          IconConstant.pigIcon,
                          size: 82,
                        ),
                      ),
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 30),
                          child: Text(
                            'Big Wallet',
                            style: TextStyles.textSize30Bold700,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: CustomCountrySelect(
                                country: _selectedCountry,
                                onSelectCountry: () {

                                },
                              )),
                          Flexible(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                              decoration: CustomStyled.boxShadowDecoration,
                              child: TextFormField(
                                controller: _controllerUserName,
                                keyboardType: TextInputType.phone,
                                decoration:
                                    CustomStyled.inputDecorationBorderNone(
                                        placeholder: "Phone Number"),
                                validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return StringApp.VALIDATE_EMPTY_FIELD;
                                  // } else {
                                  //   RegExp regex =
                                  //   RegExp(Common.regexPhoneNumber);
                                  //   if (!regex.hasMatch(value)) {
                                  //     return StringApp.VALIDATE_PHONE_FIELD;
                                  //   }
                                  //   return null;
                                  // }
                                },
                              ),
                            ),
                          )
                        ],
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
                            hintText: 'Mật khẩu',
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
                            // if (value == null || value.isEmpty) {
                            //   return StringApp.VALIDATE_EMPTY_FIELD;
                            // }
                            // return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.signInScreen);
                                },
                                style: CustomStyle.primaryButtonStyle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text('${context.l10n?.signIn}'),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.forgotPasswordPhoneScreen);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyles.textSize14ColorOrange,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Row(children: const <Widget>[
                        Expanded(
                            child: Divider(
                          color: Colors.black12,
                          height: 2,
                        )),
                        Text("Or Sign In with"),
                        Expanded(
                            child: Divider(
                          color: Colors.black12,
                          height: 2,
                        )),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Image(
                              image: AssetImage(
                            Images.facebookImage,
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Image(image: AssetImage(Images.googleImage)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text('Don’t have an account ? '),
                        Text(
                          'Sign Up',
                          style: TextStyles.textSize14ColorOrange,
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
