import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.titleUpdatePassWord ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
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
                      hintText: context.l10n?.hintTextCurrentPassword ?? '',
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
                    controller: _controllerPassword,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: context.l10n?.hintTextNewPassword ?? '',
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
                      fillColor: CustomColors.gray,
                      filled: true,
                      hintText: context.l10n?.hintTextConfirmPassword ?? '',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 24,
                        ),
                        onPressed: _toggleConfirmPasswordStatus,
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
                            Navigator.pushNamed(context, Routes.signInScreen);
                          },
                          style: CustomStyle.primaryButtonStyle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(context.l10n?.btnUpdateProfile ?? ''),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
