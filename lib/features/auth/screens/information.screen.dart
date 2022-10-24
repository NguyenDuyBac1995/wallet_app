import 'package:big_wallet/features/auth/blocs/auth.bloc.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:big_wallet/utilities/localization.dart';

class AuthInformationScreen extends StatefulWidget {
  const AuthInformationScreen({super.key});
  @override
  State<AuthInformationScreen> createState() => _AuthInformationScreenState();
}

class _AuthInformationScreenState extends State<AuthInformationScreen>
    with SingleTickerProviderStateMixin {
  late bool _isFormValid;

  @override
  void initState() {
    _isFormValid = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.authBackground), fit: BoxFit.fill)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.05, left: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${context.l10n?.signUp}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      const TextField(),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    _isFormValid ? Colors.black : Colors.grey),
                                foregroundColor: MaterialStateProperty.all(
                                    _isFormValid ? Colors.white : Colors.black),
                                fixedSize: MaterialStateProperty.all(
                                  Size.fromWidth(width),
                                )),
                            child: Text('${context.l10n?.signUp}')),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
