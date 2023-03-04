import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/screens/widgets/custom.country.select.dart';
import 'package:big_wallet/models/bundle.model.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_pickers/country_pickers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late bool _passwordVisible = false;
  late bool _isFormValid = false;
  late PhoneNumber _phoneNumber;
  late bool _isPhoneNumberValid;
  late TextEditingController _phoneNumberController;
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final Country _selectedCountry = CountryPickerUtils.getCountryByIsoCode('vn');
  final RegExp _regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!&@#]).{8,}$');
  final _formKey = GlobalKey<FormState>();
  late String _formData;

  @override
  void initState() {
    _passwordVisible = false;
    _isFormValid = false;
    _phoneNumber = PhoneNumber(isoCode: 'VN');
    _isPhoneNumberValid = false;
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Container(
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
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                            'Big Wallet',
                            style: TextStyles.textSize30Bold700,
                          ),
                        ),
                      ),
                      const Text('Fill information to sign up',
                          style: TextStyles.textSubHeader),
                      const SizedBox(
                        height: 20,
                      ),
                      InternationalPhoneNumberInput(
                        textFieldController: _phoneNumberController,
                        onInputChanged: (value) {
                          if (_phoneNumber.phoneNumber != value.phoneNumber) {
                            _phoneNumber = value;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '${context.l10n?.requiredMessage('${context.l10n?.phoneNumber}')} ';
                          }
                          if (!_isPhoneNumberValid) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                        onInputValidated: (value) {
                          _isPhoneNumberValid = value;
                        },
                        selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            trailingSpace: false),
                        inputDecoration: InputDecoration(
                            filled: true,
                            fillColor: CustomColors.gray,
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            hintText: context.l10n?.phoneNumber),
                        selectorTextStyle:
                            const TextStyle(color: Color(0xFF6E7191)),
                        initialValue: _phoneNumber,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  // BundleData data =
                                  //     BundleData(verifyCase: '01023912');
                                  // Navigator.pushNamed(
                                  //     context, Routes.verifyOtpScreen,
                                  //     arguments: data);
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                        PhoneNumberChanged(
                                            '${_phoneNumber.phoneNumber}'));
                                    Navigator.pushNamed(
                                        context, Routes.otpScreen,
                                        arguments: ((value) {
                                      Navigator.pushNamed(context,
                                          Routes.signupInformationScreen);
                                    }));
                                  }
                                },
                                style: CustomStyle.primaryButtonStyle,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text('Send OTP'),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
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
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                Images.facebookImage,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Image(
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              image: AssetImage(Images.googleImage)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ));
    }));
  }
}
