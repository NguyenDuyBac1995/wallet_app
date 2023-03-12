import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/blocs/primary/primary.bloc.dart';
import 'package:big_wallet/features/auth/model/primary.model.dart';
import 'package:big_wallet/features/settings/blocs/profiles_blocs/profiles.bloc.dart';
import 'package:big_wallet/features/settings/screens/widgets/profile.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/common.dart';
import 'package:big_wallet/utilities/constants.dart';
import 'package:big_wallet/utilities/currency_code.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.idProfile = ''});
  final String idProfile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final TextEditingController _email = TextEditingController();
  late DateTime dateTime;
  @override
  void initState() {
    // context.read<ProfilesBloc>().add(IdProfile(context, widget.idProfile));
    if (widget.idProfile != null) {
      context.read<ProfilesBloc>().add(IdProfile(context, widget.idProfile));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid profile ID'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Invalid profile ID'),
              ),
            ],
          );
        },
      );
    }

    dateController.text = "";
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const user = UserPreferences.myUser;
    List<DropdownMenuItem<String>> dropDownMenuItems =
        CurrencyCodeData.dataCurrencyCode
            .map((currency) => DropdownMenuItem<String>(
                  value: currency.vale,
                  child: Text(currency.description),
                ))
            .toList();
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
                BlocBuilder<ProfilesBloc, ProfilesBlocsState>(
                  builder: (context, state) {
                    if (state is ProfilesInitial) {
                      return _buildLoading();
                    } else if (state is ProfilesLoading) {
                      return _buildLoading();
                    } else if (state is ProfilesLoaded) {
                      dateController.text = DateFormat("yyyy-MM-dd").format(
                          DateTime.parse(state.profileDetail.birthday!));
                      return Column(
                        children: [
                          TextFormField(
                            initialValue: state.profileDetail.displayName,
                            decoration: InputDecoration(
                                labelText:
                                    context.l10n?.labelTextDisplayName ?? '',
                                hintText:
                                    context.l10n?.labelTextDisplayName ?? '',
                                filled: true,
                                fillColor: CustomColors.backgroundTextFormField,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        CustomStyle.borderRadiusFormFieldStyle),
                                labelStyle: TextStyles.labelTextStyle),
                            onSaved: (value) {},
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            enabled: false,
                            initialValue: state.profileDetail.phoneNumber,
                            decoration: InputDecoration(
                                labelText:
                                    context.l10n?.labelTextPhoneNumber ?? '',
                                hintText:
                                    context.l10n?.labelTextPhoneNumber ?? '',
                                filled: true,
                                fillColor: CustomColors.backgroundTextFormField,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        CustomStyle.borderRadiusFormFieldStyle),
                                labelStyle: TextStyles.labelTextStyle),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: state.profileDetail.email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: context.l10n?.labelTextEmail ?? '',
                                hintText: context.l10n?.labelTextEmail ?? '',
                                filled: true,
                                fillColor: CustomColors.backgroundTextFormField,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        CustomStyle.borderRadiusFormFieldStyle),
                                labelStyle: TextStyles.labelTextStyle),
                            onSaved: (value) {},
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: dateController,
                            decoration: InputDecoration(
                                labelText: context.l10n?.labelTextDOB ?? '',
                                hintText: context.l10n?.labelTextDOB ?? '',
                                suffixIcon: const CustomIcon(
                                  IconConstant.calendarIcon,
                                  size: 24,
                                ),
                                filled: true,
                                fillColor: CustomColors.backgroundTextFormField,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        CustomStyle.borderRadiusFormFieldStyle),
                                labelStyle: TextStyles.labelTextStyle),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(0001),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat("yyyy-MM-dd").format(pickedDate);
                                setState(() {
                                  dateController.text =
                                      formattedDate.toString();
                                });
                              } else {
                                print("Not selected");
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  labelText:
                                      context.l10n?.labelTextCurrency ?? '',
                                  hintText:
                                      context.l10n?.labelTextCurrency ?? '',
                                  filled: true,
                                  fillColor:
                                      CustomColors.backgroundTextFormField,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                      borderRadius: CustomStyle
                                          .borderRadiusFormFieldStyle),
                                  labelStyle: TextStyles.labelTextStyle),
                              items: dropDownMenuItems,
                              value:
                                  state.profileDetail.configurations?[0].value,
                              onChanged: (value) {}),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Text(
                                          context.l10n?.btnUpdateProfile ?? ''),
                                    )),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            )),
          )),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
