import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/common.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class CustomItemAccumulation extends StatelessWidget {
  final String title;
  final String startDate;
  final String endDate;
  final double valueNumber;
  final Function(double) onClickedEdit;

  const CustomItemAccumulation(
      {super.key,
      required this.onClickedEdit,
      required this.valueNumber,
      required this.title,
      required this.startDate,
      required this.endDate});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomContainerWidget(
        colors: CustomColors.backgroundColorItemWallet,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 10),
                leading: const CustomContainerListTitleWidget(
                    urlImage: IconWallet.accumulated),
                title: Text(title, style: TextStyles.textMenuItem),
                subtitle: Text(
                  "${Common().formatData(startDate)} - ${Common().formatData(endDate)}",
                  style: TextStyles.text.copyWith(fontSize: 12),
                ),
                trailing: GestureDetector(
                  child: const Icon(Icons.more_vert),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  height: 2,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${context.l10n?.saving}",
                  style:
                      TextStyles.text.copyWith(color: const Color(0xFF6E7191)),
                ),
              ),
              SliderTheme(
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
                    valueIndicatorColor: CustomColors.colorIconNavBarActive,
                    valueIndicatorTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Colors.white), // màu sắc của bảng hiển thị giá trị
                    activeTrackColor: CustomColors.colorIconNavBarActive,
                    tickMarkShape: RoundSliderTickMarkShape(),
                    inactiveTrackColor: Colors.black12,
                    activeTickMarkColor: Colors.transparent,
                    inactiveTickMarkColor: Colors.transparent),
                child: Slider(
                  value: valueNumber,
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  onChanged: onClickedEdit,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currencyFormat.format(2000000),
                      style: TextStyles.text
                          .copyWith(color: const Color(0xFF6E7191)),
                    ),
                    Text(
                      currencyFormat.format(2000000),
                      style: TextStyles.text,
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
