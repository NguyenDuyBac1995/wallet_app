import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/wallet/blocs/wallet_bloc/wallet_bloc.dart';
import 'package:big_wallet/features/wallet/screens/widgets/customItemAccumulation.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/widgets/custom_container.widget.dart';
import 'package:big_wallet/utilities/assets.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/common.dart';
import 'package:big_wallet/utilities/widgets/loanding_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'widgets/CustomListTileWallet.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late bool _isActive;
  double _value = 0.0;
  BuildContext? _bottomSheetContext;

  @override
  void initState() {
    context.read<WalletBloc>().add(GetListWalletEvent(context, ''));
    _isActive = false;
    super.initState();
  }

  void _onChanged(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
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
                    child:
                        Text("${context.l10n?.wallet}", style: TextStyles.h1))),
            CustomContainerWidget(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${context.l10n?.walletBalance}",
                          style: TextStyles.text,
                        ),
                        const CustomIcon(
                          IconConstant.arrowGoingUpAlt,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: BlocBuilder<WalletBloc, WalletState>(
                      buildWhen: (previous, current) {
                        return current is WalletLoaded;
                      },
                      builder: (context, state) {
                        if (state is WalletLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  currencyFormat.format(
                                      state.responseWallet.totalBalance),
                                  style: TextStyles.h1,
                                ),
                              ),
                              Text(
                                '+13.47%',
                                style: TextStyles.text.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF008A00)),
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  currencyFormat.format(0),
                                  style: TextStyles.h1,
                                ),
                              ),
                              Text(
                                '+13.47%',
                                style: TextStyles.text.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF008A00)),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 39,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isActive = !_isActive;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: !_isActive
                                ? const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFA8D930),
                                        Color.fromRGBO(95, 201, 67, 0.7),
                                      ],
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  )
                                : null,
                            child: Text(
                              "${context.l10n?.walletYour}",
                              style: TextStyles.text.copyWith(
                                  fontSize: 18,
                                  color: !_isActive
                                      ? Colors.white
                                      : const Color(0xFF1A202C)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isActive = !_isActive;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: _isActive
                                ? const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFA8D930),
                                        Color.fromRGBO(95, 201, 67, 0.7),
                                      ],
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                  )
                                : null,
                            child: Text(
                              "${context.l10n?.accumulation}",
                              style: TextStyles.text.copyWith(
                                  fontSize: 18,
                                  color: _isActive
                                      ? Colors.white
                                      : const Color(0xFF1A202C)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            _isActive
                ? Column(
                    children: [
                      CustomItemAccumulation(
                        onClickedEdit: (p0) {
                          setState(() {
                            _value = p0;
                          });
                        },
                        valueNumber: _value,
                        title: 'Buy Like',
                        startDate: '2023-03-30T02:35:00+00:00',
                        endDate: '2024-03-30T02:35:00+00:00',
                      ),
                      CustomItemAccumulation(
                        onClickedEdit: (p0) {
                          setState(() {
                            _value = p0;
                          });
                        },
                        title: 'O to',
                        valueNumber: _value,
                        startDate: '2023-03-30T02:35:00+00:00',
                        endDate: '2024-03-30T02:35:00+00:00',
                      )
                    ],
                  )
                : BlocBuilder<WalletBloc, WalletState>(
                    buildWhen: (previous, current) {
                      return current is WalletLoaded;
                    },
                    builder: (context, state) {
                      if (state is WalletInitial) {
                        return const LoadingScreens();
                      } else if (state is WalletLoading) {
                        return const LoadingScreens();
                      } else if (state is WalletLoaded) {
                        return Column(
                          children: state.responseWallet.result != null
                              ? state.responseWallet.result!
                                  .map((wallet) => CustomListTitleWallet(
                                        title: wallet.name != null
                                            ? wallet.name!
                                            : '',
                                        subtitle: wallet.balance!.toDouble(),
                                        isCheckImage: wallet.type!,
                                        onClicked: () {
                                          showBottomSheet(wallet.id!);
                                        },
                                        onClickedDetail: () {
                                          Navigator.pushNamed(context,
                                              Routes.detailWalletScreen);
                                        },
                                      ))
                                  .toList()
                              : [],
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          !_isActive
              ? Navigator.pushNamed(context, Routes.addWalletScreen,
                  arguments: "new")
              : Navigator.pushNamed(context, Routes.addSavingScreen);
        },
        backgroundColor: CustomColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void showBottomSheet(String id) => showModalBottomSheet(
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.addWalletScreen,
                        arguments: "${id}");
                  },
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.incomeScreen);
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
