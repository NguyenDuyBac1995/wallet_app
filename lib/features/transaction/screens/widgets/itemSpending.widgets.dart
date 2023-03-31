import 'package:big_wallet/utilities/common.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemSpending extends StatelessWidget {
  final String urlImage;
  final String title;
  final String subTitle;
  final String payment;
  const ItemSpending(
      {super.key,
      required this.urlImage,
      required this.title,
      required this.subTitle,
      required this.payment});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: ClipRRect(
              child: Image.network(
                urlImage,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.h1.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  Common().formatData(subTitle),
                  style: TextStyles.text
                      .copyWith(fontSize: 8, color: const Color(0xFF6E7191)),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              '-${currencyFormat.format(int.parse(payment))}',
              textAlign: TextAlign.end,
              style: TextStyles.text
                  .copyWith(color: const Color(0xFFBA1A1A), fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
