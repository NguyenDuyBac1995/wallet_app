import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';

import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ForgotNewPasswordScreen extends StatefulWidget {
  const ForgotNewPasswordScreen({super.key});

  @override
  State<ForgotNewPasswordScreen> createState() => _ForgotNewPasswordScreen();
}

class _ForgotNewPasswordScreen extends State<ForgotNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();
  late bool _passwordVisible = false;
  late bool _confirmPasswordVisible = false;

  void _togglePasswordStatus() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  void _toggleConfirmPasswordStatus() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  @override
  void dispose() {
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
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
            // crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                children: const <Widget>[
                  Text(
                    'New Password',
                    style: TextStyles.textHeader,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
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
                            hintText: 'New Password',
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
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: CustomStyled.boxShadowDecoration,
                        child: TextFormField(
                          controller: _controllerConfirmPassword,
                          obscureText: !_confirmPasswordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // No border
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Confirm Password',
                            fillColor: CustomColors.gray,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 24,
                              ),
                              onPressed: _toggleConfirmPasswordStatus,
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
                        height: 20,
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
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text('Confirm'),
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
