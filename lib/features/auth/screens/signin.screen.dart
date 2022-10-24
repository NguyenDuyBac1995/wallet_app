import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late bool _passwordVisible = false;
  late bool _isFormValid = false;
  late PhoneNumber _phoneNumber;
  late TextEditingController _phoneNumberController;
  late bool _isPhoneNumberValid;
  late TextEditingController _passwordController;
  final RegExp _regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!&@#]).{8,}$');

  @override
  void initState() {
    _passwordVisible = false;
    _isFormValid = false;
    _phoneNumber = PhoneNumber(isoCode: 'VN');
    _phoneNumberController = TextEditingController();
    _isPhoneNumberValid = false;
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onChange() {
    if (!_isPhoneNumberValid || _phoneNumber.phoneNumber!.isEmpty) {
      setState(() {
        _isFormValid = false;
      });
      return;
    }
    // if (_passwordController.text.isEmpty) {
    //   setState(() {
    //     _isFormValid = false;
    //   });
    //   return;
    // }
    // if (!_regexPassword.hasMatch(_passwordController.text)) {
    //   setState(() {
    //     _isFormValid = false;
    //   });
    //   return;
    // }
    setState(() {
      _isFormValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container();
  }
}
