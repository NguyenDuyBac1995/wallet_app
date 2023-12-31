import 'dart:async';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final Function(Object?) callback;
  const OtpScreen({super.key, required this.callback});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  late bool _enableResend;
  late Timer _timer;
  late int _secondsRemaining;
  late String _phoneNumber;
  late String _verificationId;
  final int otpLength = 6;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    _enableResend = false;
    _secondsRemaining = 30;
    _phoneNumber = context.read<AuthBloc>().state.phoneNumber;
    _verificationId = '';
    verifyPhoneNumber(context, _phoneNumber);
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        // timeout: const Duration(seconds: 30),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          Logger().i('verificationCompleted: $phoneAuthCredential');
          await auth.signInWithCredential(phoneAuthCredential);
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
    } on FirebaseAuthException catch (e) {
      Logger().i('codeAutoRetrievalTimeout: ${e.message.toString()}');
    }
  }

  Future<void> signInWithCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    await auth.signInWithCredential(phoneAuthCredential).then((value) {
      Logger().i('signInWithCredential1 -> ${value.user!.uid}');
      context.read<AuthBloc>().add(UidChanged(value.user!.uid));
      widget.callback(value);
    }).catchError((onError) {
      // Handle Errors here.
      switch (onError.code) {
        case 'invalid-verification-code':
          Toast.show(context,
              '${context.l10n?.invalidMessage('${context.l10n?.code}')} ');
          break;
        default:
          Toast.show(
              context, '${context.l10n?.somethingWentWrong} ${onError.code}');
          break;
      }
    });
  }

  void resend() {
    verifyPhoneNumber(context, _phoneNumber);
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
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        Text('${context.l10n?.otpVerification}',
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                          '${context.l10n?.otpSentTo} ${_phoneNumber.substring(0, 5) + hiddenPhoneNumber + _phoneNumber.substring(_phoneNumber.length - 3)}')),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Pinput(
                      length: otpLength,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      onCompleted: (value) async {
                        var credential = PhoneAuthProvider.credential(
                            verificationId: _verificationId, smsCode: value);
                        await signInWithCredential(credential);
                      }),
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
