import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_tv_app/utils/localization/application_localizations_delegate.dart';

class ApplicationLocalizations {
  final Locale locale;

  ApplicationLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  static ApplicationLocalizations of(BuildContext context) {
    return Localizations.of<ApplicationLocalizations>(
        context, ApplicationLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<ApplicationLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load JSON file from the "language" folder
    String jsonString =
    await rootBundle.loadString('resources/language/${locale.languageCode}.json');
    Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
    _localizedStrings = jsonLanguageMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }
}
