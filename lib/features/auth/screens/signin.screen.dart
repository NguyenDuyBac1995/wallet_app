import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible = false;
  late bool _isFormValid = false;
  @override
  void initState() {
    _passwordVisible = false;
    _isFormValid = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Spacer(
                flex: 3,
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: AppLocalizations.of(context)!.emailAddress),
              ),
              const Spacer(
                flex: 3,
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: AppLocalizations.of(context)!.password),
              ),
              const Spacer(
                flex: 3,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: const TextStyle(color: Color(0xFFF19465)),
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(_isFormValid
                          ? const Color(0xFF262338)
                          : const Color(0xFFD9DBE9)),
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.8))),
                  child: const Text('Đăng nhập'))
            ],
          )),
    );
  }
}