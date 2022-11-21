import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:big_wallet/features/auth/repositories/requests/signup.request.dart';
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
  late bool _passwordVisible;
  late bool _isPasswordLengthValid;
  late bool _isPasswordContainsAlphanumeric;
  late bool _isPasswordContainsSpecialCharacter;
  late bool _isLoading;
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final authRepository = AuthRepository();

  @override
  void initState() {
    _passwordVisible = false;
    _isPasswordLengthValid = false;
    _isPasswordContainsAlphanumeric = false;
    _isPasswordContainsSpecialCharacter = false;
    _isLoading = false;
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
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.05, left: width * 0.05),
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
                              Text('${context.l10n?.signUp}',
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
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
                        TextFormField(
                          controller: _displayNameController,
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                            }
                            return null;
                          }),
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
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            var regExp = RegExp(
                                r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!&@]).{8,}$');
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.password}')} ';
                            }
                            if (!regExp.hasMatch(value)) {
                              return '${context.l10n?.invalidMessage('${context.l10n?.password}')} ';
                            }
                            return null;
                          },
                          obscureText: _passwordVisible,
                          onChanged: (value) {
                            var containsAlphanumericRegExp =
                                RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{1,}$');
                            var containsSpecialCharacterRegExp =
                                RegExp(r'^(?=.*?[#?!&@]).{1,}$');
                            setState(() {
                              if (value.length >= 8 && value.length <= 20) {
                                _isPasswordLengthValid = true;
                              } else {
                                _isPasswordLengthValid = false;
                              }
                              if (value.contains(containsAlphanumericRegExp)) {
                                _isPasswordContainsAlphanumeric = true;
                              } else {
                                _isPasswordContainsAlphanumeric = false;
                              }
                              if (value
                                  .contains(containsSpecialCharacterRegExp)) {
                                _isPasswordContainsSpecialCharacter = true;
                              } else {
                                _isPasswordContainsSpecialCharacter = false;
                              }
                            });
                          },
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${context.l10n?.includeAtLeastMessage('${context.l10n?.password}')} ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: _isPasswordLengthValid
                                  ? Colors.green
                                  : Colors.blueGrey,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              '${context.l10n?.strRangeMessage('8', '20')} ',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: _isPasswordContainsAlphanumeric
                                  ? Colors.green
                                  : Colors.blueGrey,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              '${context.l10n?.containsAlphanumericMessage} ',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: _isPasswordContainsSpecialCharacter
                                  ? Colors.green
                                  : Colors.blueGrey,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              '${context.l10n?.containsSpecialCharacterMessage} ',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  !_isLoading) {
                                setState(() {
                                  _isLoading = true;
                                  var response = authRepository.signupAsync(
                                      context,
                                      SignUpRequest(
                                          displayName:
                                              _displayNameController.text,
                                          user: context
                                              .read<AuthBloc>()
                                              .state
                                              .phoneNumber,
                                          password: _passwordController.text));
                                  _isLoading = false;
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  _isLoading
                                      ? const Color(0xFFD9DBE9)
                                      : Colors.black),
                              foregroundColor: MaterialStateProperty.all(
                                  _isLoading
                                      ? const Color(0xFF4E4B66)
                                      : Colors.white),
                              fixedSize: MaterialStateProperty.all(
                                Size.fromWidth(width),
                              ),
                            ),
                            child: _isLoading
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: width * 0.04,
                                        width: width * 0.04,
                                        child: const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                          backgroundColor: Colors.grey,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.05,
                                      ),
                                      Text('${context.l10n?.signUp}'),
                                    ],
                                  )
                                : Text('${context.l10n?.signUp}'),
                          ),
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
