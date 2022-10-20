import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.authBackground),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.7,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            SwitchLanguageWidget(
                              onChange: (value) {
                                context
                                    .read<AppBloc>()
                                    .add(ChangeLanguage(Locale(value)));
                              },
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: height * 0.1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signInScreen);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF262338)),
                              fixedSize: MaterialStateProperty.all(
                                  Size.fromWidth(width))),
                          child: Text('${context.l10n?.signIn}')),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signUpScreen);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              fixedSize: MaterialStateProperty.all(
                                Size.fromWidth(width),
                              )),
                          child: Text('${context.l10n?.signUp}')),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
