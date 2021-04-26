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
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    var data = await rootBundle.load('${Stringcare.langPath}/${locale.languageCode}.json');
    var jsonRevealed = Stringcare.revealData(data.buffer.asUint8List());
    Map<String, dynamic> jsonMap = json.decode(utf8.decode(jsonRevealed, allowMalformed: true));

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  static Future<String> sTranslate(String language, String key, {List<String> values}) async {
    // Load the language JSON file from the "lang" folder
    var lang;
    if (language.contains("-")) {
      lang = language.split("-")[0];
    } else {
      lang = language;
    }

    String jsonString =
    await rootBundle.loadString('${Stringcare.langPath}/$lang.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    Map<String, String> _localizedStrings = jsonMap.map((key, value) {
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
        base = base.replaceAll("\$${(i + 1).toString()}", values[i]);
      }
      return base;
    }
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key, {List<String> values}) {
    if (!_localizedStrings.containsKey(key)) {
      return "";
    }

    if (values == null || values.isEmpty) {
      return _localizedStrings[key];
    } else {
      var base = _localizedStrings[key];
      for (var i = 0; i < values.length; i++) {
        base = base.replaceAll("\$${(i + 1).toString()}", values[i]);
      }
      return base;
    }
  }

  String getLang() {
    if (delegate.isSupported(locale)) {
      return locale.languageCode;
    }
    return "en";
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return Stringcare.supportedLangs.contains(locale.languageCode);
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
