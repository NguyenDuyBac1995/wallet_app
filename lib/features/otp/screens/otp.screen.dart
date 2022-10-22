import 'dart:async';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/otp/models/otp.type.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:logger/logger.dart';

class OtpScreen extends StatefulWidget {
  final OtpType type;
  const OtpScreen({super.key, required this.type});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  late bool _isOtpEntered;
  late bool _enableResend;
  late Timer _timer;
  late int _secondsRemaining;
  late String _phoneNumber;
  late String _verificationId;
  late String _verificationCode;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    _isOtpEntered = false;
    _enableResend = false;
    _secondsRemaining = 30;
    _phoneNumber = context.read<AuthBloc>().state.phoneNumber;
    _verificationId = '';
    _verificationCode = '';
    auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 30),
      phoneNumber: _phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        Logger().i('verificationCompleted: $phoneAuthCredential');
      },
      verificationFailed: (FirebaseAuthException e) {
        Logger().i('verificationFailed: $e');
        setState(() {
          _secondsRemaining = 0;
          _enableResend = true;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        Logger().i('codeSent: $verificationId');
        setState(() {
          _verificationId = verificationId;
        });
        _timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (_secondsRemaining > 1) {
            setState(() {
              _secondsRemaining--;
            });
          } else {
            setState(() {
              _enableResend = true;
            });
          }
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Logger().i('codeAutoRetrievalTimeout: $verificationId');
        setState(() {
          _verificationId = verificationId;
        });
        setState(() {
          _secondsRemaining = 0;
          _enableResend = true;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void resend() {
    auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 30),
      phoneNumber: _phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        Logger().i('verificationCompleted: $phoneAuthCredential');
      },
      verificationFailed: (FirebaseAuthException e) {
        Logger().i('verificationFailed: $e');
        setState(() {
          _secondsRemaining = 0;
          _enableResend = true;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        Logger().i('codeSent: $verificationId');
        setState(() {
          _secondsRemaining = 30;
          _enableResend = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Logger().i('codeAutoRetrievalTimeout: $verificationId');
        setState(() {
          _secondsRemaining = 0;
          _enableResend = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    var prefixPhoneNumber = _phoneNumber.substring(0, 5);
    var suffixPhoneNumber = _phoneNumber.substring(_phoneNumber.length - 3);
    var hiddenPhoneNumberCount = _phoneNumber.length -
        prefixPhoneNumber.length -
        suffixPhoneNumber.length;
    var hiddenPhoneNumber =
        List.generate(hiddenPhoneNumberCount, (index) => '*').join();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.authBackground), fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
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
                    child: Text('${context.l10n?.otpVerification}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                          '${context.l10n?.otpSentTo} ${_phoneNumber.substring(0, 5) + hiddenPhoneNumber + _phoneNumber.substring(_phoneNumber.length - 3)}')),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    showFieldAsBox: false,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    onSubmit: (String verificationCode) {
                      setState(() {
                        _isOtpEntered = true;
                        _verificationCode = verificationCode;
                      });
                    },
                    onCodeChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _isOtpEntered = false;
                          _verificationCode = '';
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                        onPressed: () async {
                          var credential = PhoneAuthProvider.credential(
                              verificationId: _verificationId,
                              smsCode: _verificationCode);
                          await auth
                              .signInWithCredential(credential)
                              .then((value) {
                            Logger().i('signInWithCredential $value');
                          }).catchError((onError) {
                            // Handle Errors here.
                            var errorCode = onError.code;
                            var errorMessage = onError.message;
                            var credential = onError.credential;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                _isOtpEntered ? Colors.black : Colors.grey),
                            foregroundColor: MaterialStateProperty.all(
                                _isOtpEntered ? Colors.white : Colors.black),
                            fixedSize: MaterialStateProperty.all(
                              Size.fromWidth(width),
                            )),
                        child: Text('${context.l10n?.verify}')),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  if (_enableResend)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          resend();
                        },
                        child: Text(
                          '${context.l10n?.resendOtp}',
                          style: const TextStyle(
                              color: Color(0xFFF19465),
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${context.l10n?.resendOtp} ${context.l10n?.afterLabel} ',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '$_secondsRemaining ${context.l10n?.seconds(_secondsRemaining)}',
                              style: const TextStyle(
                                  color: Color(0xFFF19465),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
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
      },
    );
  }
}
