import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stringcare/stringcare.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    Map<String, dynamic>? jsonMap;

    try {
      var data;
      if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
        data = await rootBundle.load(
            '${Stringcare.langPath}/${locale.languageCode}_${locale.countryCode}.json');
      } else {
        data = await rootBundle
            .load('${Stringcare.langPath}/${locale.languageCode}.json');
      }
      var jsonRevealed = Stringcare.revealData(data.buffer.asUint8List())!;
      jsonMap = json.decode(utf8.decode(jsonRevealed, allowMalformed: true));
    } catch (e) {
      try {
        var data = await rootBundle
            .load('${Stringcare.langPath}/${locale.languageCode}.json');
        var jsonRevealed = Stringcare.revealData(data.buffer.asUint8List())!;
        jsonMap = json.decode(utf8.decode(jsonRevealed, allowMalformed: true));
      } catch (e) {
        _localizedStrings = Map();
        return true;
      }
    }

    _localizedStrings = jsonMap!.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  static Future<String?> sTranslate(String language, String key,
      {List<String>? values}) async {
    // Load the language JSON file from the "lang" folder
    var lang;
    var country = "";
    if (language.contains("-")) {
      lang = language.split("-")[0];
      country = language.split("-")[1];
    } else if (language.contains("_")) {
      lang = language.split("_")[0];
      country = language.split("_")[1];
    } else {
      lang = language;
    }

    Map<String, dynamic>? jsonMap;

    try {
      var data;
      if (country.isNotEmpty) {
        data = await rootBundle
            .load('${Stringcare.langPath}/${lang}_$country.json');
      } else {
        data = await rootBundle.load('${Stringcare.langPath}/$lang.json');
      }
      var jsonRevealed = Stringcare.revealData(data.buffer.asUint8List())!;
      jsonMap = json.decode(utf8.decode(jsonRevealed, allowMalformed: true));
    } catch (e) {
      try {
        var data = await rootBundle.load('${Stringcare.langPath}/$lang.json');
        var jsonRevealed = Stringcare.revealData(data.buffer.asUint8List())!;
        jsonMap = json.decode(utf8.decode(jsonRevealed, allowMalformed: true));
      } catch (e) {
        return "";
      }
    }

    Map<String, String> _localizedStrings = jsonMap!.map((key, value) {
      return MapEntry(key, value.toString());
    });

    if (!_localizedStrings.containsKey(key)) {
      return "";
    }

    if (values == null || values.isEmpty) {
      return _localizedStrings[key];
    } else {
      var base = _localizedStrings[key];
      for (var i = 0; i < values.length; i++) {
        base = base!.replaceAll("\$${(i + 1).toString()}", values[i]);
      }
      return base;
    }
  }

  // This method will be called from every widget which needs a localized text
  String? translate(String key, {List<String>? values}) {
    if (!_localizedStrings.containsKey(key)) {
      return "";
    }

    if (values == null || values.isEmpty) {
      return _localizedStrings[key];
    } else {
      var base = _localizedStrings[key];
      for (var i = 0; i < values.length; i++) {
        base = base!.replaceAll("\$${(i + 1).toString()}", values[i]);
      }
      return base;
    }
  }

  String getLang() {
    if (delegate.isSupported(locale)) {
      return "${locale.languageCode}_${locale.countryCode}";
    }
    return "${Stringcare.locales[0].languageCode}_${Stringcare.locales[0].countryCode}";
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    for (Locale supportedLocale in Stringcare.locales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
