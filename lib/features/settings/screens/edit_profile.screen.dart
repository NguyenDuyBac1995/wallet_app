import 'package:big_wallet/features/settings/blocs/profiles_blocs/profiles.bloc.dart';
import 'package:big_wallet/features/settings/repositories/requests/create_profile.request.dart';
import 'package:big_wallet/features/settings/screens/widgets/profile.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/currency_code.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
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
  late bool _isLoading;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerCurrency = TextEditingController();
  late Currency? _currency;
  late String dataDrop;

  late DateTime dateTime;
  @override
  void initState() {
    _isLoading = false;
    // context.read<ProfilesBloc>().add(IdProfile(context, widget.idProfile));
    _currency = CurrencyService().findByCode('VND');
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
  void dispose() {
    _displayName.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    dateController.dispose();
    super.dispose();
  }

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

  Widget _buildCupertinoSelectedItem() {
    return Row(
      children: <Widget>[
        Text(
          " ${_currency?.name} ${_currency?.symbol}",
          style: TextStyles.text.copyWith(fontSize: 13),
        ),
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
                        setState(() {
                          if (state.profileDetail.configurations!.isNotEmpty) {
                            _currency = CurrencyService().findByCode(
                                state.profileDetail.configurations![0].value);
                          }
                        });
                      }
                    },
                    child: Form(
                      key: _formKey,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                                    }
                                    return null;
                                  },
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
                                      fillColor: CustomColors.gray,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius: CustomStyle
                                              .borderRadiusFormFieldStyle),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: CustomStyle
                                            .borderRadiusFormFieldStyle,
                                        borderSide: const BorderSide(
                                          color: Colors.black54,
                                        ),
                                      ),
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
                                      labelText:
                                          context.l10n?.labelTextDOB ?? '',
                                      hintText:
                                          context.l10n?.labelTextDOB ?? '',
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
                                    decoration:
                                        CustomStyled.boxShadowDecoration,
                                    child: GestureDetector(
                                      onTap: onHandleShowCurrency,
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _controllerCurrency,
                                        decoration: InputDecoration(
                                          labelText:
                                              context.l10n?.labelTextCurrency ??
                                                  '',
                                          hintText:
                                              context.l10n?.labelTextCurrency ??
                                                  '',
                                          filled: true,
                                          fillColor: CustomColors
                                              .backgroundTextFormField,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          border: OutlineInputBorder(
                                              borderRadius: CustomStyle
                                                  .borderRadiusFormFieldStyle),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: CustomStyle
                                                .borderRadiusFormFieldStyle,
                                            borderSide: const BorderSide(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          labelStyle: TextStyles.labelTextStyle,
                                          suffixIcon: GestureDetector(
                                            onTap: onHandleShowCurrency,
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child:
                                                    _buildCupertinoSelectedItem()),
                                          ),
                                        ),
                                        validator: (value) {},
                                      ),
                                    )),
                                const SizedBox(height: 20),
                                _updateProfile()
                              ],
                            )
                          ]),
                    ))),
          )),
    );
  }

  Widget _updateProfile() {
    return BlocListener<ProfilesBloc, ProfilesBlocsState>(
        listener: (context, state) {
          if (state is EditProfileLoaded) {
            if (state.isSuccess) {
              Toast.show(context, '${context.l10n?.messageEditProfile}',
                  backgroundColor: Colors.green);
              // Navigator.pushNamed(context, Routes.messageEditProfile);
            }
          }
        },
        child: Row(children: [
          Expanded(
            child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          context.read<ProfilesBloc>().add(EditProfile(
                              context,
                              CreateProfilesRequest(
                                  displayName: _displayName.text,
                                  phoneNumber: _phoneNumber.text,
                                  email: _email.text,
                                  id: widget.idProfile,
                                  configurations: [
                                    Configurations(value: _currency?.code)
                                  ],
                                  birthday: dateController.text)));
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                style: CustomStyle.primaryButtonStyle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(context.l10n?.btnUpdateProfile ?? ''),
                )),
          ),
        ]));
  }
}
