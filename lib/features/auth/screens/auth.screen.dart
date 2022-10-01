import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/features/auth/screens/widgets/auth.background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(builder: ((context, state) {
        return Stack(
          children: [
            const AuthBackground(),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: const [
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Big Wallet",
                    style: TextStyle(
                        color: Color(0xFFA8D930),
                        fontSize: 64,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Never lose money",
                    style: TextStyle(
                        color: Color(0xFF262338),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}
