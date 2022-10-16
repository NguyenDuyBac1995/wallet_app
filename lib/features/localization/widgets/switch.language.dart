import 'package:big_wallet/features/app/blocs/app.bloc.dart';
import 'package:big_wallet/features/localization/models/language.model.dart';
import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchLanguageWidget extends StatefulWidget {
  const SwitchLanguageWidget({super.key});
  @override
  State<SwitchLanguageWidget> createState() => _SwitchLanguageWidgetState();
}

class _SwitchLanguageWidgetState extends State<SwitchLanguageWidget>
    with SingleTickerProviderStateMixin {
  String _languageCode = 'en';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppBloc(ConfigurationRepository()),
        child: BlocBuilder<AppBloc, AppState>(builder: ((context, state) {
          return DropdownButtonHideUnderline(
            child: DropdownButton(
                iconSize: 0.0,
                alignment: Alignment.centerRight,
                value: state.locale.languageCode,
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
                  _languageCode = value ?? 'en';
                  context
                      .read<AppBloc>()
                      .add(ChangeLanguage(Locale(_languageCode)));
                }),
          );
        })));
  }
}
