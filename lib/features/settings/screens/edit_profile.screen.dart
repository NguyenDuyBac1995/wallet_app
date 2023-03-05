import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/settings/screens/widgets/profile.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const user = UserPreferences.myUser;
    TextEditingController _date = TextEditingController();
    return Scaffold(
      body: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.sigInBackground), fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                ProfileWidget(
                    imagePath: user.imagePath, onClicked: () async {}),
                const SizedBox(height: 50),
                Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: context.l10n?.labelTextDisplayName ?? '',
                          hintText: context.l10n?.labelTextDisplayName ?? '',
                          filled: true,
                          fillColor: CustomColors.backgroundTextFormField,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle),
                          labelStyle: TextStyles.labelTextStyle),
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: context.l10n?.labelTextPhoneNumber ?? '',
                          hintText: context.l10n?.labelTextPhoneNumber ?? '',
                          filled: true,
                          fillColor: CustomColors.backgroundTextFormField,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle),
                          labelStyle: TextStyles.labelTextStyle),
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: context.l10n?.labelTextEmail ?? '',
                          hintText: context.l10n?.labelTextEmail ?? '',
                          filled: true,
                          fillColor: CustomColors.backgroundTextFormField,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle),
                          labelStyle: TextStyles.labelTextStyle),
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _date,
                      decoration: InputDecoration(
                          labelText: context.l10n?.labelTextDOB ?? '',
                          hintText: context.l10n?.labelTextDOB ?? '',
                          suffixIcon: const CustomIcon(
                            IconConstant.calendarIcon,
                            size: 24,
                          ),
                          filled: true,
                          fillColor: CustomColors.backgroundTextFormField,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle),
                          labelStyle: TextStyles.labelTextStyle),
                      onSaved: (value) {},
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickeddate != null) {
                          setState(() {
                            _date.text =
                                DateFormat('yyyy-MM-dd').format(pickeddate!);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: context.l10n?.labelTextCurrency ?? '',
                          hintText: context.l10n?.labelTextCurrency ?? '',
                          filled: true,
                          fillColor: CustomColors.backgroundTextFormField,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius:
                                  CustomStyle.borderRadiusFormFieldStyle),
                          labelStyle: TextStyles.labelTextStyle),
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.signInScreen);
                              },
                              style: CustomStyle.primaryButtonStyle,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child:
                                    Text(context.l10n?.btnUpdateProfile ?? ''),
                              )),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )),
          )),
    );
  }
}
