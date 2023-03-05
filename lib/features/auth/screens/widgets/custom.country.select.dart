import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/styled.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';

class CustomCountrySelect extends StatefulWidget {
  const CustomCountrySelect(
      {super.key, required this.country, required this.onSelectCountry});
  final Country country;
  final Function() onSelectCountry;
  @override
  State<CustomCountrySelect> createState() => _CustomCountrySelect();
}

class _CustomCountrySelect extends State<CustomCountrySelect> {
  late Country _country = CountryPickerUtils.getCountryByIsoCode('vn');

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _country = widget.country ?? CountryPickerUtils.getCountryByIsoCode('vn');
    });
    super.initState();
  }

  void _openFilteredCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
                titlePadding: const EdgeInsets.all(0.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: CustomStyled.inputDecorationBorderNone(
                    placeholder: "Search"),
                isSearchable: true,
                // title: const Text('Select your phone code'),
                onValuePicked: (Country country) =>
                    setState(() => _country = country),
                itemBuilder: _buildDialogItem)),
      );
  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8.0),
        Text("+${country.phoneCode}"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: CustomStyled.boxShadowDecoration,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none, // No border
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: CustomColors.gray,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            prefixIcon: GestureDetector(
              onTap: _openFilteredCountryPickerDialog,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: _buildCupertinoSelectedItem(_country),
              ),
            )),
      ),
    );
  }
}
