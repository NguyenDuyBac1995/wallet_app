import 'dart:async';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
import 'package:big_wallet/features/otp/models/otp.type.dart';
import 'package:big_wallet/features/otp/screens/widgets/otp.background.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
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
  late final TabController _tabController;
  late bool _isOtpEntered;
  late bool _enableResend;
  late Timer _timer;
  late int _secondsRemaining;
  late String _otpValue;
  final TextEditingController _number1 = TextEditingController();
  final TextEditingController _number2 = TextEditingController();
  final TextEditingController _number3 = TextEditingController();
  final TextEditingController _number4 = TextEditingController();
  final TextEditingController _number5 = TextEditingController();
  final TextEditingController _number6 = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _isOtpEntered = false;
    _enableResend = false;
    _secondsRemaining = 30;
    _otpValue = '';
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
    _tabController.dispose();
    _timer.cancel();
  }

  void resend() {
    setState(() {
      _secondsRemaining = 30;
      _enableResend = false;
    });
  }

  void onChange() {
    _otpValue =
        '${_number1.text}${_number2.text}${_number3.text}${_number4.text}${_number5.text}${_number6.text}';
    if (_otpValue.length == 6) {
      setState(() {
        _isOtpEntered = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.authBackground), fit: BoxFit.fill)),
          child: Padding(
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
                        Navigator.of(context, rootNavigator: true).pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
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
                  height: height * 0.1,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: false,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    setState(() {
                      _isOtpEntered = true;
                    });
                  }, // end onSubmit
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ElevatedButton(
                      onPressed: () {},
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
      ),
    );
  }
}
