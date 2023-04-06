import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final List<ListItem> listData = [
      ListItem(IconTransaction.hand, "${context.l10n?.spendingTitle}",
          "${context.l10n?.spendingTitleSubTitle}", Routes.spendingScreen),
      // ListItem(IconTransaction.budget, "${context.l10n?.budgetTitle}",
      //     "${context.l10n?.budgetTitleSubTitle}", "/ad"),
      ListItem(IconTransaction.checked, "${context.l10n?.periodicNotesTitle}",
          "${context.l10n?.periodicNotesTitleSubTitle}", "/ad"),
      ListItem(IconTransaction.debt, "${context.l10n?.debtTitle}",
          "${context.l10n?.debtTitleSubTitle}", "/ad"),
      ListItem(IconTransaction.balance, "${context.l10n?.listExpensesTitle}",
          "${context.l10n?.listExpensesSubTitle}", Routes.categoriesScreen),
    ];
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.sigInBackground), fit: BoxFit.fill)),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 50),
                child: Align(
                    child: Text("${context.l10n?.transaction}",
                        style: TextStyles.h1))),
            ...listData.map((data) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomContainerWidget(
                  child: ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: 0),
                    dense: true,
                    leading: CustomContainerListTitleWidget(
                      height: 30,
                      width: 30,
                      urlImage: data.image,
                    ),
                    title: Text(data.title, style: TextStyles.textMenuItem),
                    subtitle: Text(
                      data.subtitle,
                      style: TextStyles.text.copyWith(fontSize: 12),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, data.routeName);
                    },
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ListItem {
  final String image;
  final String title;
  final String subtitle;
  final String routeName;

  ListItem(
    this.image,
    this.title,
    this.subtitle,
    this.routeName,
  );
}
