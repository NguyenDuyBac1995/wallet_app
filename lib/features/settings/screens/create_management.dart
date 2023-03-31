import 'dart:io';

import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/model/upload.model.dart';
import 'package:big_wallet/features/settings/blocs/profiles_blocs/profiles.bloc.dart';
import 'package:big_wallet/features/settings/repositories/profile.repository.dart';
import 'package:big_wallet/features/settings/repositories/requests/create_profile.request.dart';
import 'package:big_wallet/features/settings/screens/widgets/profile.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/loanding_screens.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class CreateManagement extends StatefulWidget {
  const CreateManagement({super.key, this.titleApp = ''});
  final String titleApp;

  @override
  State<CreateManagement> createState() => _CreateManagementState();
}

class _CreateManagementState extends State<CreateManagement> {
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _controllerCurrency = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Currency? _currency;
  late String nameTitle;
  late bool _isLoading;
  late bool _isLoadingUpload;
  TextEditingController dateController = TextEditingController();
  late UploadModel dataImage;
  final uploadRepository = ProfileRepository();

  @override
  void initState() {
    _isLoading = false;
    _isLoadingUpload = false;
    _currency = CurrencyService().findByCode('VND');
    if (widget.titleApp != 'new') {
      context.read<ProfilesBloc>().add(IdProfile(context, widget.titleApp));
    }
    super.initState();
  }

  @override
  void dispose() {
    _displayName.dispose();
    _note.dispose();
    _phoneNumber.dispose();
    _controllerCurrency.dispose();
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
    Future<void> _pickImage() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        setState(() {
          _isLoadingUpload = true;
        });
        PlatformFile file = result.files.first;
        File pickedFile = File(file.path!);
        var response =
            await uploadRepository.uploadFileAsync(context, pickedFile);
        if (response.isEmpty) {
          setState(() {
            _isLoadingUpload = false;
          });
          setState(() {
            dataImage = response[0];
          });
        }
        setState(() {
          _isLoadingUpload = false;
        });
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.titleApp == 'new'
            ? Text(
                context.l10n?.createProfile ?? '',
                style: TextStyles.h1,
              )
            : BlocBuilder<ProfilesBloc, ProfilesBlocsState>(
                builder: (context, state) {
                  if (state is ProfilesLoaded) {
                    return Text(
                      state.profileDetail.displayName != null
                          ? state.profileDetail.displayName!
                          : '',
                      style: TextStyles.h1,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
        routerName: 'recordsManagement',
      ),
      body: _isLoadingUpload
          ? const LoadingScreens()
          : Container(
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 39),
                  ProfileWidget(
                      imagePath: user.imagePath, onClicked: _pickImage),
                  const SizedBox(height: 50),
                  BlocListener<ProfilesBloc, ProfilesBlocsState>(
                    listener: (context, state) {
                      if (state is ProfilesLoaded) {
                        _displayName.text = state.profileDetail.displayName!;
                        nameTitle = state.profileDetail.displayName!;
                        _phoneNumber.text = state.profileDetail.phoneNumber!;
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
                        children: [
                          TextFormField(
                            controller: _displayName,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '${context.l10n?.requiredMessage('${context.l10n?.displayName}')} ';
                              }
                              return null;
                            },
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
                          TextFormField(
                            controller: _phoneNumber,
                            keyboardType: TextInputType.number,
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
                          Container(
                              decoration: CustomStyled.boxShadowDecoration,
                              child: GestureDetector(
                                onTap: onHandleShowCurrency,
                                child: TextFormField(
                                  enabled: false,
                                  controller: _controllerCurrency,
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
                                    labelStyle: TextStyles.labelTextStyle,
                                    suffixIcon: GestureDetector(
                                      onTap: onHandleShowCurrency,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: _buildCupertinoSelectedItem()),
                                    ),
                                  ),
                                  validator: (value) {},
                                ),
                              )),
                          const SizedBox(height: 20),
                          _updateManagement()
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ),
    );
  }

  Widget _updateManagement() {
    return BlocListener<ProfilesBloc, ProfilesBlocsState>(
      listener: (context, state) {
        if (state is CreateProfileLoaded) {
          if (state.isSuccess) {
            Toast.show(context, '${context.l10n?.messageCreateProfile}',
                backgroundColor: Colors.green);
            Navigator.pushNamed(context, Routes.recordsManagement);
          }
        }
        if (state is EditProfileLoaded) {
          if (state.isSuccess) {
            Toast.show(context, '${context.l10n?.messageEditProfile}',
                backgroundColor: Colors.green);
            Navigator.pushNamed(context, Routes.recordsManagement);
          }
        }
      },
      child: widget.titleApp == 'new'
          ? Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                context.read<ProfilesBloc>().add(CreateProfile(
                                    context,
                                    CreateProfilesRequest(
                                        displayName: _displayName.text,
                                        phoneNumber: _phoneNumber.text,
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
                        child: Text(context.l10n?.btnSaveProfile ?? ''),
                      )),
                ),
              ],
            )
          : Row(
              children: [
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
                                        id: widget.titleApp,
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                context.read<ProfilesBloc>().add(CreateProfile(
                                    context,
                                    CreateProfilesRequest(
                                        displayName: _displayName.text,
                                        phoneNumber: _phoneNumber.text,
                                        configurations: [
                                          Configurations(value: _currency?.code)
                                        ],
                                        avatar: dataImage,
                                        birthday: dateController.text)));
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                      style: CustomStyle.deleteButtonStyle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          context.l10n?.btnDeleteProfile ?? '',
                          style: const TextStyle(color: Colors.red),
                        ),
                      )),
                ),
              ],
            ),
    );
  }
}
