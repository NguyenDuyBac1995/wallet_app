import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/screens/signin.screen.dart';
import 'package:big_wallet/features/auth/screens/widgets/auth.background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocBuilder<AuthBloc, AuthState>(builder: ((context, state) {
          return Stack(
            children: [
              const AuthBackground(),
              Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                              AppLocalizations.of(context)!.changeLanguageFlag),
                          const SizedBox(width: 5),
                          Text(
                              AppLocalizations.of(context)!.changeLanguageName),
                        ]),
                  ),
                  const Spacer(
                    flex: 15,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
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
                          text: AppLocalizations.of(context)!.signIn,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.signUp,
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          children: const [
                            Center(
                              child: SignInScreen(),
                            ),
                            Center(
                              child: SignInScreen(),
                            )
                          ]),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              )
            ],
          );
        })),
      ),
    );
  }
}
