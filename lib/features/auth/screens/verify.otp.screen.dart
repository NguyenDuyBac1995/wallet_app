import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/screens/widgets/custom.country.select.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, this.verifyCase});
  final String? verifyCase;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreen();
}

class _VerifyOtpScreen extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  late String errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    print(' verifyCase: ${widget.verifyCase}');
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
              const Text(
                'OTP code was sent 09*****91',
                style: TextStyles.textSubHeader,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          PinCodeTextField(
                              autofocus: true,
                              maxLength: pinLength,
                              pinBoxWidth: 46,
                              pinBoxHeight: 46,
                              controller: controller,
                              pinTextStyle: const TextStyle(fontSize: 22.0),
                              pinBoxBorderWidth: 1,
                              pinBoxRadius: 8,
                              defaultBorderColor: const Color(0xFF008889),
                              hasTextBorderColor: const Color(0xFF008889),
                              keyboardType: TextInputType.number,
                              onTextChanged: (text) {
                                setState(() {
                                  hasError = false;
                                });
                              },
                              hasError: hasError,
                              maskCharacter: "😎",
                              onDone: (text) {
                                print("DONE $text");
                                print("DONE CONTROLLER ${controller.text}");
                              },
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  if(widget.verifyCase == 'register') {
                                    Navigator.pushNamed(
                                        context, Routes.signupInformationScreen);
                                  }else {
                                    Navigator.pushNamed(
                                        context, Routes.forgotNewPasswordScreen);
                                  }

                                },
                                style: CustomStyle.primaryButtonStyle,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text('Submit'),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Text.rich(TextSpan(
                              text: 'Resend OTP after',
                              style: TextStyles.textSubHeader,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ' 60 seconds',
                                  style: TextStyles.textSubHeaderColorRed,
                                )
                              ])),
                        ],
                      )
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
