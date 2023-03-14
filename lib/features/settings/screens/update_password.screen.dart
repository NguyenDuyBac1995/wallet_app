import 'dart:convert';

import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/model/ForgotPassword.model.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:big_wallet/features/auth/repositories/requests/revokeToken.request.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/constants.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerCurrentPassword =
      TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  late bool _passwordCurrentVisible = false;
  late bool _passwordVisible = false;
  late bool _confirmPasswordVisible = false;
  late bool _isLoading;
  final authRepository = AuthRepository();

  void _togglePasswordCurrentStatus() {
    setState(() {
      _passwordCurrentVisible = !_passwordCurrentVisible;
    });
  }

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
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _controllerCurrentPassword.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
                    controller: _controllerCurrentPassword,
                    obscureText: !_passwordCurrentVisible,
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
                          _passwordCurrentVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 24,
                        ),
                        onPressed: _togglePasswordCurrentStatus,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                    validator: (value) {
                      RegExp passwordRegExp = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value == null || value.isEmpty) {
                        return '${context.l10n?.requiredMessage('${context.l10n?.password}')} ';
                      }
                      if (!passwordRegExp.hasMatch(value)) {
                        return '${context.l10n?.invalidMessage('${context.l10n?.password}')} ';
                      }
                      return null;
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
                      RegExp passwordRegExp = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value == null || value.isEmpty) {
                        return '${context.l10n?.requiredMessage('${context.l10n?.password}')} ';
                      }
                      if (!passwordRegExp.hasMatch(value)) {
                        return '${context.l10n?.invalidMessage('${context.l10n?.password}')} ';
                      }
                      return null;
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
                      if (value!.isEmpty || value == null) {
                        return '${context.l10n?.requiredMessage('${context.l10n?.password}')} ';
                      }
                      if (value != _controllerPassword.text) {
                        return "${context.l10n?.validatePassWordConfirm}";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  // buildWhen: (previous, current) =>
                  //     previous.changePassWord != current.changePassWord,
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        context.read<AuthBloc>().add(
                                            ChangePassword(
                                                ChangePasswordModal(
                                                    currentPassword:
                                                        _controllerCurrentPassword
                                                            .text,
                                                    newPassword:
                                                        _controllerPassword
                                                            .text),
                                                context));
                                        if (state.changePassWord) {
                                          Toast.show(context,
                                              '${context.l10n?.messagePassWord}',
                                              backgroundColor: Colors.green);
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          pref.remove(Constants.BIG_WALLET);
                                          Navigator.pushNamed(
                                              context, Routes.signInScreen);
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                              style: _isLoading
                                  ? CustomStyle.primaryButtonLoading
                                  : CustomStyle.primaryButtonStyle,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: _isLoading
                                    ? LoadingButton(
                                        text: Text(
                                            context.l10n?.btnUpdateProfile ??
                                                ''),
                                        width: width,
                                      )
                                    : Text(
                                        context.l10n?.btnUpdateProfile ?? ''),
                              )),
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
