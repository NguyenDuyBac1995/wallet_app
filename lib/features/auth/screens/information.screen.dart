import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/toast.dart';
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
  late bool _isPasswordLengthValid;
  late bool _isPasswordContainsAlphanumeric;
  late bool _isPasswordSpecialCharacterValid;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _isFormValid = false;
    _passwordVisible = false;
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
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              Toast.show(
                                  context, 'Tên hiển thị là trường bắt buộc');
                              return null;
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
                          validator: (value) {
                            var pattern =
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!&@]).{8,}$';
                            var regExp = RegExp(pattern);
                            if (value == null || value.isEmpty) {
                              Toast.show(
                                  context, 'Mật khẩu là trường bắt buộc');
                              return null;
                            }
                            if (!regExp.hasMatch(value)) {
                              Toast.show(context, 'Mật khẩu không hợp lệ');
                              return null;
                            }
                            return null;
                          },
                          obscureText: _passwordVisible,
                          onChanged: (value) {},
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
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Mật khẩu của bạn phải bao gồm ít nhất:',
                            style: TextStyle(
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
                            const Icon(Icons.check_circle_outline),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            const Text(
                              '8 ký tự (tối đa 20 ký tự)',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            const Text(
                              'Chứa 1 chữ cái và 1 số',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            const Text(
                              'Chứa 1 ký tự đặc biệt (Ví dụ: # ? ! & @)',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
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
                                if (_formKey.currentState!.validate()) {}
                              },
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
                ),
              );
            },
          )),
    );
  }
}
