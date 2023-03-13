import 'dart:async';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/screens/widgets/custom.country.select.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  final Function(Object?) callback;
  const VerifyOtpScreen({super.key, this.verifyCase, required this.callback});
  final String? verifyCase;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreen();
}

class _VerifyOtpScreen extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController(text: "");
  final int otpLength = 6;
  String thisText = "";
  bool hasError = false;
  late String errorMessage;
  late String _phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late int _secondsRemaining;
  late bool _enableResend;
  late Timer _timer;
  late String _verificationId;

  @override
  void initState() {
    _phoneNumber = context.read<AuthBloc>().state.phoneNumber;
    _enableResend = false;
    _secondsRemaining = 30;
    _verificationId = '';
    resetPassword(context, _phoneNumber);
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
    controller.dispose();
    super.dispose();
  }

  void resetPassword(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          Logger().i('verificationCompleted: $credential');
          await _auth.signInWithCredential(credential);
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
    await _auth.signInWithCredential(phoneAuthCredential).then((value) {
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
    resetPassword(context, _phoneNumber);
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
                    'Verify OTP',
                    style: TextStyles.textHeader,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                      '${context.l10n?.verifySendOtp} ${_phoneNumber.substring(0, 5) + hiddenPhoneNumber + _phoneNumber.substring(_phoneNumber.length - 3)}')),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Pinput(
                          length: otpLength,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsRetrieverApi,
                          onCompleted: (value) async {
                            var credential = PhoneAuthProvider.credential(
                                verificationId: _verificationId,
                                smsCode: value);
                            await signInWithCredential(credential);
                          }),
                      const SizedBox(
                        height: 20,
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
