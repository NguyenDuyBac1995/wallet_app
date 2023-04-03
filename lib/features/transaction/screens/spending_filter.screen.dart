import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpendingFilterScreen extends StatefulWidget {
  const SpendingFilterScreen({super.key});

  @override
  State<SpendingFilterScreen> createState() => _SpendingFilterScreenState();
}

class _SpendingFilterScreenState extends State<SpendingFilterScreen> {
  TextEditingController dateController = TextEditingController();
  RangeValues values = const RangeValues(0, 100);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'vi_VN');
    List listDataCategory = [
      {
        "title": "${context.l10n?.entertainment}",
        "value": "entertainment",
        "url": IconTransaction.streamingApp
      },
      {
        "title": "${context.l10n?.study}",
        "value": "study",
        "url": IconTransaction.book
      },
      {
        "title": "${context.l10n?.pet}",
        "value": "pet",
        "url": IconTransaction.petFood
      },
      {
        "title": "${context.l10n?.go}",
        "value": "go",
        "url": IconTransaction.busStop
      },
      {
        "title": "${context.l10n?.eatAndDrink}",
        "value": "eatAndDrink",
        "url": IconTransaction.fastFood
      },
      {
        "title": "${context.l10n?.clothes}",
        "value": "clothes",
        "url": IconTransaction.clothesRack
      },
      {
        "title": "${context.l10n?.chopping}",
        "value": "chopping",
        "url": IconTransaction.groceryCart
      },
      {
        "title": "${context.l10n?.home}",
        "value": "home",
        "url": IconTransaction.home
      },
      {
        "title": "${context.l10n?.preventive}",
        "value": "preventive",
        "url": IconTransaction.contingency
      },
      {
        "title": "${context.l10n?.present}",
        "value": "present",
        "url": IconTransaction.gift
      },
      {
        "title": "${context.l10n?.health}",
        "value": "health",
        "url": IconTransaction.healthinsurance
      },
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.filter ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n?.byTheTime ?? "",
                      style: TextStyles.h2,
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
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n?.byTheTime ?? "",
                      style: TextStyles.h2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
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
                  ],
                ),
              ),
              const Divider(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n?.byCategory ?? "",
                          style: TextStyles.h2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ...listDataCategory.map((item) {
                              return ItemCategory(
                                text: item['title'],
                                urlImage: item['url'],
                              );
                            }).toList()
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: CustomStyle.primaryButtonStyle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      context.l10n?.clearFilter ?? '',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCategory extends StatelessWidget {
  final String text;
  final String urlImage;

  const ItemCategory({
    super.key,
    required this.text,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
      width: 80,
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyles.text.copyWith(
              fontSize: 10,
              color: const Color(0xFF6E7191),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: CustomContainerListTitleWidget(
              height: 16,
              width: 16,
              urlImage: urlImage,
            ),
          ),
        ],
      ),
    );
  }
}
