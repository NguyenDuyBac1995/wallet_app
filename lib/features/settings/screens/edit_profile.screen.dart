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
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/loanding_screens.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:currency_picker/currency_picker.dart';
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
  final TextEditingController _controllerCurrency = TextEditingController();
  late Country _country = CountryPickerUtils.getCountryByIsoCode('vn');
  late String dataDrop;

  late DateTime dateTime;
  @override
  void initState() {
    // context.read<ProfilesBloc>().add(IdProfile(context, widget.idProfile));
    dataDrop = 'VND';
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

  Currency _currency = Currency(
      code: 'VND',
      name: 'Viet Nam Dong',
      symbol: '₫',
      flag: 'VND',
      number: 704,
      decimalDigits: 0,
      namePlural: 'Vietnamese dong',
      symbolOnLeft: false,
      decimalSeparator: '.',
      thousandsSeparator: '.',
      spaceBetweenAmountAndSymbol: true);
  void onHandleShowCurrency() => showCurrencyPicker(
        context: context,
        showFlag: true,
        showCurrencyName: true,
        showCurrencyCode: true,
        onSelect: (Currency currency) {
          setState(() {
            _controllerCurrency.text = currency.name;
            _currency = currency;
          });
        },
      );

  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        // CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8.0),
        Text("${_currency.name} ${_currency.symbol}"),
      ],
    );
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
                child: BlocListener<ProfilesBloc, ProfilesBlocsState>(
                    listener: (context, state) {
                      if (state is ProfilesLoaded) {
                        _displayName.text = state.profileDetail.displayName!;
                        _phoneNumber.text = state.profileDetail.phoneNumber!;
                        _email.text = state.profileDetail.email!;
                        dateController.text = DateFormat("yyyy-MM-dd").format(
                            DateTime.parse(state.profileDetail.birthday!));

                        dataDrop =
                            state.profileDetail.configurations![0].value!;
                      }
                    },
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
                              imagePath: user.imagePath,
                              onClicked: () async {}),
                          const SizedBox(height: 50),
                          Column(
                            children: [
                              TextFormField(
                                controller: _displayName,
                                decoration: InputDecoration(
                                    labelText:
                                        context.l10n?.labelTextDisplayName ??
                                            '',
                                    hintText:
                                        context.l10n?.labelTextDisplayName ??
                                            '',
                                    filled: true,
                                    fillColor:
                                        CustomColors.backgroundTextFormField,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                        borderRadius: CustomStyle
                                            .borderRadiusFormFieldStyle),
                                    labelStyle: TextStyles.labelTextStyle),
                                onSaved: (value) {},
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                enabled: false,
                                controller: _phoneNumber,
                                decoration: InputDecoration(
                                    labelText:
                                        context.l10n?.labelTextPhoneNumber ??
                                            '',
                                    hintText:
                                        context.l10n?.labelTextPhoneNumber ??
                                            '',
                                    filled: true,
                                    fillColor:
                                        CustomColors.backgroundTextFormField,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                        borderRadius: CustomStyle
                                            .borderRadiusFormFieldStyle),
                                    labelStyle: TextStyles.labelTextStyle),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                    labelText:
                                        context.l10n?.labelTextEmail ?? '',
                                    hintText:
                                        context.l10n?.labelTextEmail ?? '',
                                    filled: true,
                                    fillColor:
                                        CustomColors.backgroundTextFormField,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                        borderRadius: CustomStyle
                                            .borderRadiusFormFieldStyle),
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
                                    fillColor:
                                        CustomColors.backgroundTextFormField,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                        borderRadius: CustomStyle
                                            .borderRadiusFormFieldStyle),
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
                                        DateFormat("yyyy-MM-dd")
                                            .format(pickedDate);
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
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: CustomStyled.boxShadowDecoration,
                                  child: GestureDetector(
                                    onTap: onHandleShowCurrency,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _controllerCurrency,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: CustomColors
                                            .backgroundTextFormField,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                            borderRadius: CustomStyle
                                                .borderRadiusFormFieldStyle),
                                        labelText:
                                            context.l10n?.labelTextCurrency ??
                                                '',
                                        hintText:
                                            context.l10n?.labelTextCurrency ??
                                                '',
                                        prefixIcon: GestureDetector(
                                          onTap: onHandleShowCurrency,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: _buildCupertinoSelectedItem(
                                                _country),
                                          ),
                                        ),
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                      ),
                                      validator: (value) {
                                        // if (value == null || value.isEmpty) {
                                        //   return StringApp.VALIDATE_EMPTY_FIELD;
                                        // }
                                        // return null;
                                      },
                                    ),
                                  )),
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
                                  value: dataDrop,
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
                                              context.l10n?.btnUpdateProfile ??
                                                  ''),
                                        )),
                                  )
                                ],
                              ),
                            ],
                          )
                        ]))),
          )),
    );
  }
}
