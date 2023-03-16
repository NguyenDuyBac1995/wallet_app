import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/settings/blocs/profiles_blocs/profiles.bloc.dart';
import 'package:big_wallet/features/settings/repositories/requests/create_profile.request.dart';
import 'package:big_wallet/features/settings/screens/widgets/profile.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:big_wallet/utilities/user_preferences.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
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
  late bool _isLoading;
  TextEditingController dateController = TextEditingController();
  late String? _filePath;
  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _displayName.dispose();
    _note.dispose();
    _phoneNumber.dispose();
    super.dispose();
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
        print(" result.files ->${result.files}");
        setState(() {
          _filePath = result.files.single.path;
        });
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          widget.titleApp == 'new' ? context.l10n?.createProfile ?? '' : "Edit",
          style: TextStyles.h1,
        ),
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 39),
            ProfileWidget(imagePath: user.imagePath, onClicked: _pickImage),
            const SizedBox(height: 50),
            Column(
              children: [
                TextFormField(
                  controller: _displayName,
                  decoration: InputDecoration(
                      labelText: context.l10n?.labelTextDisplayName ?? '',
                      hintText: context.l10n?.labelTextDisplayName ?? '',
                      filled: true,
                      fillColor: CustomColors.backgroundTextFormField,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: CustomStyle.borderRadiusFormFieldStyle),
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: CustomStyle.borderRadiusFormFieldStyle),
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
                        dateController.text = formattedDate.toString();
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
                      labelText: context.l10n?.labelTextPhoneNumber ?? '',
                      hintText: context.l10n?.labelTextPhoneNumber ?? '',
                      filled: true,
                      fillColor: CustomColors.backgroundTextFormField,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: CustomStyle.borderRadiusFormFieldStyle),
                      labelStyle: TextStyles.labelTextStyle),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _note,
                  decoration: InputDecoration(
                      labelText: context.l10n?.labelTextNote ?? '',
                      hintText: context.l10n?.labelTextNote ?? '',
                      filled: true,
                      fillColor: CustomColors.backgroundTextFormField,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: CustomStyle.borderRadiusFormFieldStyle),
                      labelStyle: TextStyles.labelTextStyle),
                  onSaved: (value) {},
                ),
                const SizedBox(height: 20),
                BlocListener<ProfilesBloc, ProfilesBlocsState>(
                  listener: (context, state) {
                    if (state is CreateProfileLoaded) {
                      if (state.isSuccess) {
                        Toast.show(
                            context, '${context.l10n?.messageCreateProfile}',
                            backgroundColor: Colors.green);
                        Navigator.pushNamed(context, Routes.recordsManagement);
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    context.read<ProfilesBloc>().add(
                                        CreateProfile(
                                            context,
                                            CreateProfilesRequest(
                                                displayName: _displayName.text,
                                                phoneNumber: _phoneNumber.text,
                                                birthday:
                                                    dateController.text)));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                            style: CustomStyle.primaryButtonStyle,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(context.l10n?.btnUpdateProfile ?? ''),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
