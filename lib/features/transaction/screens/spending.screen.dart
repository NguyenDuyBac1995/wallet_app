import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/transaction/screens/widgets/itemSpending.widgets.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

int touchedIndex = -1;

class _SpendingScreenState extends State<SpendingScreen> {
  late bool _isActiveFilter = false;

  @override
  void initState() {
    // TODO: implement initState
    // _isActiveFilter = false;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _isActiveFilter = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.spendingTitle ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFD9DBE9), width: 1))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 220,
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: PieChart(PieChartData(
                                    // centerSpaceRadius: 50,
                                    sectionsSpace: 0,
                                    // centerSpaceColor: Colors.yellow,
                                    borderData: FlBorderData(show: false),
                                    sections: [
                                      PieChartSectionData(
                                          title: '',
                                          value: 10,
                                          color: Colors.blue),
                                      PieChartSectionData(
                                          title: '',
                                          value: 10,
                                          color: Colors.orange),
                                      PieChartSectionData(
                                          title: '',
                                          value: 10,
                                          color: Colors.red),
                                      PieChartSectionData(
                                          title: '',
                                          value: 10,
                                          color: Colors.purple),
                                      PieChartSectionData(
                                          title: '',
                                          value: 20,
                                          color: Colors.amber),
                                      PieChartSectionData(
                                          title: '',
                                          value: 30,
                                          color: Colors.green)
                                    ])),
                              ),
                              Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: 20,
                                      children: [
                                        Text(
                                          'Tổng chi tiêu 12/2022',
                                          style: TextStyles.text.copyWith(
                                              height: 1.4,
                                              color: const Color(0xFFA0A3BD)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(currencyFormat.format(5000000)),
                                  )
                                ],
                              ))
                            ],
                          ),
                          Positioned(
                            top: 10,
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   _isActiveFilter = !_isActiveFilter;
                                // });
                                Navigator.pushNamed(
                                    context, Routes.spendingFilterScreen);
                              },
                              child: CustomIcon(
                                IconTransaction.symbolsFilter,
                                color: _isActiveFilter
                                    ? CustomColors.colorIconNavBarActive
                                    : CustomColors.colorIconNavBar,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ItemColor(
                            textColor: 'Thức ăn Thức ăn Thức ăn',
                          ),
                          ItemColor(
                            textColor: 'Thú cưng',
                          ),
                          ItemColor(
                              textColor: 'Tiền nhà', color: Color(0xFFFF6158)),
                          ItemColor(
                              textColor: 'Xăng xe', color: Color(0xFF00C4FF)),
                          ItemColor(
                              textColor: 'Thú cưng', color: Color(0xFFECE5D4)),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
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
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addSpendingScreen);
        },
        backgroundColor: CustomColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemColor extends StatelessWidget {
  static const Color defaultColor = Color(0xFFA8D930);

  final String textColor;
  final Color color;
  const ItemColor(
      {super.key, required this.textColor, this.color = defaultColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color, // replace with your desired color
              shape: BoxShape.rectangle,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                textColor,
                style: TextStyles.text.copyWith(
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
