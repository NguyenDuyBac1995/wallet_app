import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class FilterWalletScreen extends StatefulWidget {
  const FilterWalletScreen({super.key});

  @override
  State<FilterWalletScreen> createState() => _FilterWalletScreenState();
}

class _FilterWalletScreenState extends State<FilterWalletScreen> {
  late bool _isChecked;
  TextEditingController dateController = TextEditingController();
  RangeValues values = const RangeValues(0, 100);

  @override
  void initState() {
    // TODO: implement initState
    _isChecked = false;
    super.initState();
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'vi_VN');
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
            '${context.l10n?.filter}',
            style: TextStyles.h1,
          ),
          checkIcon: true),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${context.l10n?.status}",
                        style:
                            TextStyles.h2.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: <Widget>[
                          Transform(
                            transform: Matrix4.translationValues(
                              -12,
                              0,
                              0,
                            ),
                            child: Checkbox(
                              value:
                                  _isChecked, // _isChecked là biến bool lưu trữ trạng thái của checkbox
                              onChanged: _onCheckboxChanged,
                              shape: const CircleBorder(),
                              activeColor: CustomColors.colorOceanBlue,
                            ),
                          ),
                          Expanded(
                              child: Text(
                            "${context.l10n?.inProgress}",
                            style: TextStyles.text.copyWith(fontSize: 16),
                          )),
                        ],
                      ),
                      Container(
                        height: 17,
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: <Widget>[
                            Transform(
                              transform: Matrix4.translationValues(
                                -12,
                                0,
                                0,
                              ),
                              child: Checkbox(
                                value:
                                    _isChecked, // _isChecked là biến bool lưu trữ trạng thái của checkbox
                                onChanged: _onCheckboxChanged,
                                shape: const CircleBorder(),
                                activeColor: CustomColors.colorOceanBlue,
                              ),
                            ),
                            Expanded(
                                child: Text(
                              "${context.l10n?.done}",
                              style: TextStyles.text.copyWith(fontSize: 16),
                            )),
                          ],
                        ),
                      ),
                    ]),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n?.byTheTime ?? "",
                      style:
                          TextStyles.h2.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                            labelText: context.l10n?.since ?? '',
                            hintText: context.l10n?.dateStart ?? '',
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
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                            labelText: context.l10n?.toDate ?? '',
                            hintText: context.l10n?.dateEnd ?? '',
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
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n?.priceRange ?? "",
                      style:
                          TextStyles.h2.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: SliderTheme(
                        data: const SliderThemeData(
                            trackHeight: 10,
                            thumbColor: CustomColors.colorIconNavBarActive,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 12,
                              disabledThumbRadius: 12,
                              // borderEnabled: true,
                              // borderColor: Colors.green,
                            ),
                            rangeThumbShape: RoundRangeSliderThumbShape(
                              enabledThumbRadius: 15,
                            ),
                            overlayColor: Color(0xFFF2FED5),
                            // thumbShape:
                            //     RoundSliderThumbShape(enabledThumbRadius: 1.0),
                            valueIndicatorColor:
                                CustomColors.colorIconNavBarActive,
                            valueIndicatorTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white), // màu sắc của bảng hiển thị giá trị
                            activeTrackColor:
                                CustomColors.colorIconNavBarActive,
                            tickMarkShape: RoundSliderTickMarkShape(),
                            inactiveTrackColor: Colors.black12,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent),
                        child: RangeSlider(
                          values: values,
                          min: 0.0,
                          max: 100.0,
                          divisions: 20,
                          labels: RangeLabels(
                            // values.start.round().toString(),
                            // values.end.round().toString(),
                            formatter.format(values.start),
                            formatter.format(values.end),
                          ),
                          onChanged: (value) {
                            setState(() {
                              values = value;
                            });
                          },
                        ),
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
                                child: Text(context.l10n?.apply ?? ''),
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              style: CustomStyle.deleteButtonStyle,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  context.l10n?.clearFilter ?? '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
