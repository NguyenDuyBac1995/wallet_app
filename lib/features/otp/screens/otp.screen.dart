import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
import 'package:big_wallet/features/otp/screens/widgets/otp.background.dart';
import 'package:big_wallet/features/otp/screens/widgets/otp.input.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var inputWidth = width / 6 - 20;
    var inputHeight = width / 6 - 20;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
          body: SingleChildScrollView(
              child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Stack(
          children: [
            const OtpBackground(),
            Column(
              children: [
                Expanded(
                  flex: 15,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: BlocSelector<AppBloc, AppState, String>(
                          selector: (state) {
                            return state.locale.languageCode;
                          },
                          builder: (context, languageCode) {
                            return SwitchLanguageWidget(
                              languageCode: languageCode,
                              onChange: (value) {
                                context
                                    .read<AppBloc>()
                                    .add(ChangeLanguage(Locale(value)));
                              },
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 60,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Logger().i('đã ấn nút back');
                                    },
                                    icon: const Icon(Icons.arrow_back)),
                                Text(
                                  context.l10n?.otpVerification ??
                                      'OTP Verification',
                                  style: const TextStyle(
                                      color: Color(0xFF4E4B66),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )),
                      ),
                      Expanded(
                          flex: 40,
                          child: Column(
                            children: [
                              Text(
                                '${context.l10n?.otpSentTo ?? 'A verification code has been sent to'} 094****189',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 30, bottom: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OtpInputWidget(
                                        width: inputWidth, height: inputHeight),
                                    OtpInputWidget(
                                        width: inputWidth, height: inputHeight),
                                    OtpInputWidget(
                                        width: inputWidth, height: inputHeight),
                                    OtpInputWidget(
                                        width: inputWidth, height: inputHeight),
                                    OtpInputWidget(
                                        width: inputWidth, height: inputHeight),
                                    OtpInputWidget(
                                        width: inputWidth, height: inputHeight),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ))),
    );
  }
}
