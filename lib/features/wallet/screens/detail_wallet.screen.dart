import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:big_wallet/utilities/widgets/itemSpending.widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailWalletScreen extends StatefulWidget {
  const DetailWalletScreen({super.key});

  @override
  State<DetailWalletScreen> createState() => _DetailWalletScreenState();
}

class _DetailWalletScreenState extends State<DetailWalletScreen> {
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

  List dataSpending = [
    {
      "title": "Tiêm thuốc cho mèo",
      "createdTime": "2023-03-30T02:35:00+00:00",
      "payment": "500000",
      "url":
          'https://ucarecdn.com/43baa4a2-ca67-4bd8-8e34-415192978ce2/Petfood.png'
    },
    {
      "title": "Tiêm thuốc cho mèo 1",
      "createdTime": "2023-03-30T02:35:00+00:00",
      "payment": "500000",
      "url":
          'https://ucarecdn.com/43baa4a2-ca67-4bd8-8e34-415192978ce2/Petfood.png'
    },
    {
      "title": "Tiêm thuốc cho mèo 2",
      "createdTime": "2023-03-30T02:35:00+00:00",
      "payment": "500000",
      "url":
          'https://ucarecdn.com/43baa4a2-ca67-4bd8-8e34-415192978ce2/Petfood.png'
    },
    {
      "title": "Tiêm thuốc cho mèo 3",
      "createdTime": "2023-03-30T02:35:00+00:00",
      "payment": "500000",
      "url":
          'https://ucarecdn.com/43baa4a2-ca67-4bd8-8e34-415192978ce2/Petfood.png'
    },
    {
      "title": "Tiêm thuốc cho mèo 4",
      "createdTime": "2023-03-30T02:35:00+00:00",
      "payment": "500000",
      "url":
          'https://ucarecdn.com/43baa4a2-ca67-4bd8-8e34-415192978ce2/Petfood.png'
    },
    {
      "title": "Tiêm thuốc cho mèo 5",
      "createdTime": "2023-03-30T02:35:00+00:00",
      "payment": "500000",
      "url":
          'https://ucarecdn.com/43baa4a2-ca67-4bd8-8e34-415192978ce2/Petfood.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
            'Ví tiền mặt',
            style: TextStyles.h1,
          ),
          onClicked: showBottomSheet,
          checkIcon: true),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: CustomContainerWidget(
                    colors: CustomColors.backgroundColorItemWallet,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${context.l10n?.totalRevenue}",
                                  style: TextStyles.text,
                                ),
                                Text(
                                  currencyFormat.format(60000),
                                  style: TextStyles.text.copyWith(
                                      color: const Color(0xFFA8D930),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${context.l10n?.totalRxpenditure}",
                                  style: TextStyles.text,
                                ),
                                Text(
                                  currencyFormat.format(60000),
                                  style: TextStyles.text.copyWith(
                                      color: const Color(0xFFBA1A1A),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${context.l10n?.currentBalance}",
                                style: TextStyles.text,
                              ),
                              Text(
                                currencyFormat.format(60000),
                                style: TextStyles.text
                                    .copyWith(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 1),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: const Color.fromRGBO(73, 195, 97, 0.1),
                      child: Text(
                        'Tháng 12/2022',
                        style: TextStyles.h1.copyWith(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ListView(
                          children: [
                            ...dataSpending.map((data) {
                              return ItemSpending(
                                urlImage: data['url'],
                                title: data['title'],
                                subTitle: data['createdTime'],
                                payment: data['payment'],
                              );
                            }).toList()
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void showBottomSheet() => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) => Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const CustomContainerListTitleWidget(
                      height: 24, width: 24, urlImage: IconWallet.iconEdit),
                  title: Text('${context.l10n?.textBottomSheetEdit}',
                      style: TextStyles.text.copyWith(
                          color: const Color(0xFF008889), fontSize: 18)),
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  dense: true,
                  shape: const Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const CustomContainerListTitleWidget(
                      height: 24, width: 24, urlImage: IconWallet.iconExchange),
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  title: Text('${context.l10n?.textBottomSheetExchange}',
                      style: TextStyles.text.copyWith(
                          color: const Color(0xFF008889), fontSize: 18)),
                  dense: true,
                  shape: const Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey)),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.transferScreen);
                  },
                ),
                ListTile(
                  leading: const CustomContainerListTitleWidget(
                      height: 24, width: 24, urlImage: IconWallet.iconAddCard),
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  title: Text('${context.l10n?.textBottomSheetAddCard}',
                      style: TextStyles.text.copyWith(
                          color: const Color(0xFF008889), fontSize: 18)),
                  dense: true,
                  shape: const Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey)),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.incomeScreen);
                  },
                ),
                ListTile(
                  leading: const CustomContainerListTitleWidget(
                      height: 24,
                      width: 24,
                      urlImage: IconWallet.symbolsFilterAlt),
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  title: Text('${context.l10n?.filter}',
                      style: TextStyles.text.copyWith(
                          color: const Color(0xFF008889), fontSize: 18)),
                  dense: true,
                  shape: const Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey)),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.filterWalletScreen);
                  },
                ),
                ListTile(
                  leading: const CustomContainerListTitleWidget(
                      height: 24, width: 24, urlImage: IconWallet.iconDelete),
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: 0),
                  title: Text('${context.l10n?.textBottomSheetDelete}',
                      style: TextStyles.text.copyWith(
                          color: const Color(0xFFBA1A1A), fontSize: 18)),
                  dense: true,
                  onTap: () {},
                ),
              ],
            ),
          ));
}
