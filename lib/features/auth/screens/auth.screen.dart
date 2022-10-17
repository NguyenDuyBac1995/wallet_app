import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/screens/signin.screen.dart';
import 'package:big_wallet/features/auth/screens/signup.screen.dart';
import 'package:big_wallet/features/auth/screens/widgets/auth.background.dart';
import 'package:big_wallet/features/localization/widgets/switch.language.dart';
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
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
          body: SingleChildScrollView(
              child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Stack(
          children: [
            const AuthBackground(),
            Column(
              children: [
                Expanded(
                  flex: 40,
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
                  flex: 60,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding:
                              const EdgeInsets.only(left: 50, right: 50),
                          indicatorColor: const Color(0xffA8D930),
                          tabs: [
                            Tab(
                              text: context.l10n?.signIn,
                            ),
                            Tab(
                              text: context.l10n?.signUp,
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                Center(
                                  child: SignInScreen(
                                    key: UniqueKey(),
                                  ),
                                ),
                                Center(
                                  child: SignUpScreen(
                                    key: UniqueKey(),
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
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
