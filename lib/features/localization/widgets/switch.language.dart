import 'package:big_wallet/features/localization/models/language.model.dart';
import 'package:flutter/material.dart';

class SwitchLanguageWidget extends StatelessWidget {
  final Function(String languageCode) onChange;
  final String languageCode;
  const SwitchLanguageWidget(
      {super.key, required this.onChange, required this.languageCode});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          iconSize: 0.0,
          alignment: Alignment.centerRight,
          value: languageCode,
          items: Language.languages()
              .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                  value: e.code,
                  child: Row(children: [
                    Image.asset(
                      e.flag,
                      height: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      e.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ])))
              .toList(),
          onChanged: (value) async {
            var languageCode = value ?? 'en';
            onChange(languageCode);
          }),
    );
  }
}
