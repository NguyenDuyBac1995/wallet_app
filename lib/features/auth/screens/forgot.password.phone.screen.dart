import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/screens/widgets/custom.country.select.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPhoneScreen extends StatefulWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  State<ForgotPasswordPhoneScreen> createState() =>
      _ForgotPasswordPhoneScreen();
}

class _ForgotPasswordPhoneScreen extends State<ForgotPasswordPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final Country _selectedCountry = CountryPickerUtils.getCountryByIsoCode('vn');
  final TextEditingController _controllerUserName = TextEditingController();

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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Forgot password',
                style: TextStyles.textHeader,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '77777777777777776777777777777send OTP to your phone number 1212',
                style: TextStyles.textSubHeader,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: CustomCountrySelect(
                                country: _selectedCountry,
                                onSelectCountry: () {},
                              )),
                          Flexible(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.verifyOtpScreen);
                                },
                                style: CustomStyle.primaryButtonStyle,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text('Submit'),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
