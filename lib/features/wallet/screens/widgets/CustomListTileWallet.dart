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
  final VoidCallback onClickedDetail;
  final int isCheckImage;
  final String title;
  final double subtitle;

  const CustomListTitleWallet(
      {super.key,
      required this.onClicked,
      this.isCheckImage = 6,
      required this.title,
      required this.subtitle,
      required this.onClickedDetail});

  @override
  Widget build(BuildContext context) {
    String urlImage;
    switch (isCheckImage) {
      case 1:
        urlImage = IconWallet.bankDefault;
        break;
      case 2:
        urlImage = IconWallet.visaDefault;
        break;
      case 3:
        urlImage = IconWallet.cashDefault;
        break;
      case 4:
        urlImage = IconWallet.investDefault;
        break;
      case 5:
        urlImage = IconWallet.eWalletDefault;
        break;
      case 6:
        urlImage = IconWallet.otherDefault;
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
            title: GestureDetector(
              onTap: onClickedDetail,
              child: Text(title, style: TextStyles.textMenuItem),
            ),
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
