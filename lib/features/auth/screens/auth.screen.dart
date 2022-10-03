import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/screens/widgets/auth.background.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Stack(children: [
                        Image.asset(
                            AppLocalizations.of(context)!.changeLanguageFlag),
                        Text(AppLocalizations.of(context)!.changeLanguageName),
                      ]),
                    ),
                    const Spacer(
                      flex: 15,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
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
                    const Spacer(
                      flex: 4,
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
