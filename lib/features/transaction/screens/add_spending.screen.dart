import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSpendingScreen extends StatefulWidget {
  const AddSpendingScreen({super.key});

  @override
  State<AddSpendingScreen> createState() => _AddSpendingScreenState();
}

class _AddSpendingScreenState extends State<AddSpendingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameExpense = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String defaultValue = "";
  String secondDropDown = "";
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.titleCurrencySetting ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 18),
                      child: TextFormField(
                        controller: _nameExpense,
                        decoration: InputDecoration(
                            hintText: context.l10n?.walletName ?? '',
                            filled: true,
                            fillColor: CustomColors.backgroundTextFormField,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius:
                                CustomStyle.borderRadiusFormFieldStyle,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              icon: const Icon(Icons.expand_more),
                              isDense: true,
                              value: defaultValue,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                DropdownMenuItem(
                                    value: "",
                                    child: Text('${context.l10n?.category}',
                                        style: TextStyles.text.copyWith(
                                            fontSize: 16, color: Colors.grey))),
                              ],
                              onChanged: (value) {
                                print("selected Value $value");
                                setState(() {
                                  defaultValue = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: TextFormField(
                        controller: _nameExpense,
                        decoration: InputDecoration(
                            suffixIcon: const CustomIcon(
                              IconConstant.calculator,
                              size: 24,
                            ),
                            hintText: context.l10n?.amount ?? '',
                            filled: true,
                            fillColor: CustomColors.backgroundTextFormField,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                            hintText: context.l10n?.dateSpending ?? '',
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius:
                                CustomStyle.borderRadiusFormFieldStyle,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              icon: const Icon(Icons.expand_more),
                              isDense: true,
                              value: defaultValue,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                DropdownMenuItem(
                                    value: "",
                                    child: Text(
                                      '${context.l10n?.fromWallet}',
                                      style: TextStyles.text.copyWith(
                                          fontSize: 16, color: Colors.grey),
                                    )),
                              ],
                              onChanged: (value) {
                                print(
                                  "selected Value $value",
                                );
                                setState(() {
                                  defaultValue = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius:
                                CustomStyle.borderRadiusFormFieldStyle,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              icon: const Icon(Icons.expand_more),
                              isDense: true,
                              value: defaultValue,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                DropdownMenuItem(
                                    value: "",
                                    child: Text('${context.l10n?.payee}',
                                        style: TextStyles.text.copyWith(
                                            fontSize: 16, color: Colors.grey))),
                              ],
                              onChanged: (value) {
                                print("selected Value $value");
                                setState(() {
                                  defaultValue = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: TextFormField(
                        controller: _nameExpense,
                        decoration: InputDecoration(
                            hintText: context.l10n?.noteWallet ?? '',
                            filled: true,
                            fillColor: CustomColors.backgroundTextFormField,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              style: CustomStyle.primaryButtonStyle,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(context.l10n?.btnSaveProfile ?? ''),
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          )),
    );
  }
}
