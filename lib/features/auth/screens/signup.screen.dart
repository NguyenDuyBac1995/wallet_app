import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late PhoneNumber _phoneNumber;
  late bool _isPhoneNumberValid;
  late TextEditingController _phoneNumberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.authBackground), fit: BoxFit.fill)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.05, left: width * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                              Text('${context.l10n?.welcome}',
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
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
                              return 'Số điện thoại là bắt buộc';
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
                              fillColor: const Color(0xFFEFF0F7),
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
                              const TextStyle(color: Colors.black),
                          initialValue: _phoneNumber,
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                      ChangePhoneNumber(
                                          '${_phoneNumber.phoneNumber}'));
                                  Navigator.pushNamed(context, Routes.otpScreen,
                                      arguments: ((value) {
                                    Navigator.pushNamed(
                                        context, Routes.authInformation);
                                  }));
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  fixedSize: MaterialStateProperty.all(
                                    Size.fromWidth(width),
                                  )),
                              child: Text('${context.l10n?.signUp}')),
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Row(children: [
                          const Expanded(
                              child: Divider(
                            color: Colors.black,
                          )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: Text(
                                '${context.l10n?.orLabel} ${context.l10n?.signUp.toLowerCase()} ${context.l10n?.withLabel}'),
                          ),
                          const Expanded(
                              child: Divider(
                            color: Colors.black,
                          )),
                        ]),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset(Images.facebookIcon),
                              iconSize: height * 0.1,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Image.asset(Images.googleIcon),
                              iconSize: height * 0.1,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
