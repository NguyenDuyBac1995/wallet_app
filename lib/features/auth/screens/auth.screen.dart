import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/screens/signin.screen.dart';
import 'package:big_wallet/features/auth/screens/signup.screen.dart';
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
                  Expanded(
                    flex: 40,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                AppLocalizations.of(context)!
                                    .changeLanguageFlag,
                                height: 15,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                AppLocalizations.of(context)!
                                    .changeLanguageName,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ]),
                      ),
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
                                    child: SignUpScreen(),
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
          );
        })),
      ),
    );
  }
}
