import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/transaction/screens/widgets/itemSpending.widgets.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

int touchedIndex = -1;

class _SpendingScreenState extends State<SpendingScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFD9DBE9), width: 1))),
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                    Center(child: Text('Tổng chi tiêu 12/2022'))
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
              ))
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

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Color(0xFFA8D930),
          title: '',
          value: 80,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          value: 80,
          title: '',
          color: Color(0xFFFF6158),
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            shadows: shadows,
          ),
        );
      case 2:
        return PieChartSectionData(
          value: 35,
          title: '',
          color: Color(0xFF00C4FF),
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            shadows: shadows,
          ),
        );
      case 3:
        return PieChartSectionData(
          value: 15,
          title: '',
          color: Color(0xFFECE5D4),
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
