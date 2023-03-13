import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:big_wallet/features/auth/repositories/requests/revokeToken.request.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ForgotPasswordPhoneScreen extends StatefulWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  State<ForgotPasswordPhoneScreen> createState() =>
      _ForgotPasswordPhoneScreen();
}

class _ForgotPasswordPhoneScreen extends State<ForgotPasswordPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  late PhoneNumber _phoneNumber;
  late bool _isPhoneNumberValid;
  late TextEditingController _phoneNumberController;
  late bool _isLoading = false;
  final authRepository = AuthRepository();

  @override
  void initState() {
    _phoneNumber = PhoneNumber(isoCode: 'VN');
    _isPhoneNumberValid = false;
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  void _onSignIn(BuildContext context, phoneNumber) async {
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      var response = await authRepository.postForgotPassword(
          context, ForgotPasswordRequest(user: phoneNumber));
      if (response) {
        final authBloc = context.read<AuthBloc>();
        authBloc.add(PhoneNumberChanged('${_phoneNumber.phoneNumber}'));
        Navigator.pushNamed(context, Routes.verifyOtpScreen,
            arguments: ((value) {
          Navigator.pushNamed(context, Routes.forgotNewPasswordScreen);
        }));
      }
      setState(() {
        _isLoading = false;
      });
    }
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
              Text(
                '${context.l10n?.forgotPasswordTitle}',
                style: TextStyles.textHeader,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${context.l10n?.forgotPasswordDesc}',
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            filled: true,
                            fillColor: CustomColors.gray,
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  _onSignIn(context, _phoneNumber.phoneNumber);
                                  // resetPassword('0857615759');
                                },
                                style: CustomStyle.primaryButtonStyle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text('${context.l10n?.submit}'),
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
