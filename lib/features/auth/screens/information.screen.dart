import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:big_wallet/utilities/localization.dart';

class AuthInformationScreen extends StatefulWidget {
  const AuthInformationScreen({super.key});
  @override
  State<AuthInformationScreen> createState() => _AuthInformationScreenState();
}

class _AuthInformationScreenState extends State<AuthInformationScreen>
    with SingleTickerProviderStateMixin {
  late bool _isFormValid;
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;

  @override
  void initState() {
    _isFormValid = false;
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    super.initState();
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${context.l10n?.signUp}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    style: const TextStyle(
                                        color: Color(0xFF4E4B66),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    text:
                                        '${context.l10n?.agreeMessage('${context.l10n?.signUp}')} '),
                                TextSpan(
                                    style: const TextStyle(
                                        color: Color(0xFFF19465),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    text: '${context.l10n?.termsOfUse} '),
                                TextSpan(
                                    style: const TextStyle(
                                        color: Color(0xFF4E4B66),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    text: '${context.l10n?.andLabel} '),
                                TextSpan(
                                    style: const TextStyle(
                                        color: Color(0xFFF19465),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    text: '${context.l10n?.privacyPolicy} '),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline),
                            prefixIconColor: const Color(0xFFD9DBE9),
                            contentPadding: const EdgeInsets.all(0),
                            filled: true,
                            fillColor: const Color(0xFFEFF0F7),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            hintText: '${context.l10n?.displayName}'),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.key),
                            prefixIconColor: const Color(0xFFD9DBE9),
                            suffixIcon: IconButton(
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            suffixIconColor: const Color(0xFFD9DBE9),
                            contentPadding: const EdgeInsets.all(0),
                            filled: true,
                            fillColor: const Color(0xFFEFF0F7),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            hintText: '${context.l10n?.password}'),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                        obscureText: _confirmPasswordVisible,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.key),
                            prefixIconColor: const Color(0xFFD9DBE9),
                            suffixIcon: IconButton(
                              icon: Icon(_confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible =
                                      !_confirmPasswordVisible;
                                });
                              },
                            ),
                            suffixIconColor: const Color(0xFFD9DBE9),
                            contentPadding: const EdgeInsets.all(0),
                            filled: true,
                            fillColor: const Color(0xFFEFF0F7),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            hintText: '${context.l10n?.confirmPassword}'),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  _isFormValid ? Colors.black : Colors.grey),
                              foregroundColor: MaterialStateProperty.all(
                                  _isFormValid ? Colors.white : Colors.black),
                              fixedSize: MaterialStateProperty.all(
                                Size.fromWidth(width),
                              ),
                            ),
                            child: Text('${context.l10n?.signUp}')),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
