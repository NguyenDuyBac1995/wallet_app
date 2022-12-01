// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:big_wallet/models/translate.model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../enums/context.enum.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalization on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}

extension Translations on AppLocalizations {
  String get(Context context, Translate translate, String defaultValue) {
    var messageId = '${translate.context}|${translate.key}';
    switch (messageId) {
      case 'General|EntityAlreadyExistsException':
        switch (context) {
          case Context.signup:
          case Context.signin:
            return entityAlreadyExistsException(account);
          default:
            return defaultValue;
        }
      default:
        return defaultValue;
    }
  }
}
