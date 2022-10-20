import 'dart:async';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
import 'package:big_wallet/features/otp/models/otp.type.dart';
import 'package:big_wallet/features/otp/screens/widgets/otp.background.dart';
import 'package:big_wallet/features/otp/screens/widgets/otp.input.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: SizedBox(
                  height: height * 0.6,
                  width: width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                          const Spacer(),
                          SwitchLanguageWidget(
                            onChange: (value) {
                              context
                                  .read<AppBloc>()
                                  .add(ChangeLanguage(Locale(value)));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  height: height * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * 0.05),
                            topRight: Radius.circular(width * 0.05)),
                        border: Border.all(color: Colors.black, width: 0.0)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('${context.l10n?.signUp}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700))),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OtpInputWidget(
                                controller: _number1,
                                onChanged: (value) {},
                              ),
                              OtpInputWidget(
                                controller: _number2,
                                onChanged: (value) {},
                              ),
                              OtpInputWidget(
                                controller: _number3,
                                onChanged: (value) {},
                              ),
                              OtpInputWidget(
                                controller: _number4,
                                onChanged: (value) {},
                              ),
                              OtpInputWidget(
                                controller: _number5,
                                onChanged: (value) {},
                              ),
                              OtpInputWidget(
                                controller: _number6,
                                onChanged: (value) {},
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      _isOtpEntered
                                          ? Colors.black
                                          : Colors.grey),
                                  foregroundColor: MaterialStateProperty.all(
                                      _isOtpEntered
                                          ? Colors.white
                                          : const Color(0xFF4E4B66)),
                                  fixedSize: MaterialStateProperty.all(
                                    Size.fromWidth(width),
                                  )),
                              child: Text('${context.l10n?.verify}')),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              child: Text(
                                  '${context.l10n?.orLabel} ${context.l10n?.signUp.toLowerCase()} ${context.l10n?.withLabel}'),
                            ),
                            const Expanded(child: Divider()),
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Image.asset(Images.facebookIcon),
                                  iconSize: height * 0.1,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Image.asset(Images.googleIcon),
                                  iconSize: height * 0.1,
                                  onPressed: () {},
                                )
                              ]),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
