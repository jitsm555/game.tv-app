import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_tv_app/utils/localization/application_localizations.dart';

class AppLocalizationsDelegate
    extends LocalizationsDelegate<ApplicationLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<ApplicationLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    ApplicationLocalizations localizations =
        new ApplicationLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
