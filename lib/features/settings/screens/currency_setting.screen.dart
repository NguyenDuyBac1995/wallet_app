import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:country_pickers/countries.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';

class CurrencySettingScreen extends StatefulWidget {
  const CurrencySettingScreen({super.key});

  @override
  State<CurrencySettingScreen> createState() => _CurrencySettingScreenState();
}

class _CurrencySettingScreenState extends State<CurrencySettingScreen> {
  final TextEditingController _controllerCurrency = TextEditingController();
  late Currency? _currency;
  @override
  void initState() {
    // TODO: implement initState
    _currency = CurrencyService().findByCode('VND');
    super.initState();
  }

  // List<Country> _countryList = countryList;
// final List<Country> _countryList = countryList;
  final List<Country> _countryList = countryList;

  // void onHandleShowCurrency() => showCurrencyPicker(
  //       context: context,
  //       showFlag: true,
  //       showCurrencyName: true,
  //       showCurrencyCode: true,
  //       onSelect: (Currency currency) {
  //         setState(() {
  //           _controllerCurrency.text = currency.name;
  //           _currency = currency;
  //         });
  //       },
  //     );
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.titleCurrencySetting ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: ListView.builder(
            itemCount: _countryList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading:
                    CountryPickerUtils.getDefaultFlagImage(_countryList[index]),
                title: Text('${_countryList[index].name} '),
                onTap: () {
                  // Handle the selected country here
                  print('Selected country: ${_countryList[index].name}');
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
