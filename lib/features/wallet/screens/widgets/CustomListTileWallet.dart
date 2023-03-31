import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class CustomListTitleWallet extends StatelessWidget {
  final VoidCallback onClicked;
  final String isCheckImage;
  final String title;
  final double subtitle;

  const CustomListTitleWallet(
      {super.key,
      required this.onClicked,
      this.isCheckImage = 'other',
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    String urlImage;
    switch (isCheckImage) {
      case 'bank':
        urlImage = IconWallet.bankDefault;
        break;
      case 'cash':
        urlImage = IconWallet.cashDefault;
        break;
      case 'wallet':
        urlImage = IconWallet.eWalletDefault;
        break;
      case 'invest':
        urlImage = IconWallet.investDefault;
        break;
      case 'visa':
        urlImage = IconWallet.visaDefault;
        break;
      default:
        urlImage = IconWallet.otherDefault;
        break;
    }
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        CustomContainerWidget(
          colors: CustomColors.backgroundColorItemWallet,
          child: ListTile(
            leading: CustomContainerListTitleWidget(urlImage: urlImage),
            title: Text(title, style: TextStyles.textMenuItem),
            subtitle: Text(
              currencyFormat.format(subtitle),
              style: TextStyles.text.copyWith(fontSize: 12),
            ),
            trailing: GestureDetector(
              onTap: onClicked,
              child: const Icon(Icons.more_vert),
            ),
          ),
        )
      ],
    );
  }
}
