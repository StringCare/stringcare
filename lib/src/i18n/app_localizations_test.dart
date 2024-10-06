import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stringcare/stringcare.dart';

import 'app_localizations_interface.dart';

class AppLocalizationsTest extends AppLocalizationsInterface {
  final Locale systemLocale;

  final dividerA = '-';

  final dividerB = '_';

  Locale get locale {
    final locale = Stringcare().withLocale();
    if (locale != null) {
      return locale;
    }
    final lang = Stringcare().withLang();
    if (lang != null) {
      if (lang.contains(dividerA)) {
        String language = lang.split(dividerA)[0].toLowerCase();
        String country = lang.split(dividerA)[1].toUpperCase();
        return Locale(language, country);
      } else if (lang.contains(dividerB)) {
        String language = lang.split(dividerB)[0].toLowerCase();
        String country = lang.split(dividerB)[1].toUpperCase();
        return Locale(language, country);
      } else if (lang.isNotEmpty) {
        return Locale(lang.toLowerCase());
      }
    }
    return systemLocale;
  }

  AppLocalizationsTest(this.systemLocale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizationsTest? of(BuildContext context) {
    return Localizations.of<AppLocalizationsTest>(
        context, AppLocalizationsTest);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizationsTest> delegate =
      _AppLocalizationsDelegateTest();

  late Map<String, String> _localizedStrings;

  @override
  Future<bool> load() => _loadLanguage(
        locale.languageCode,
        locale.countryCode ?? '',
      );

  Future<bool> _loadLanguage(String languageCode, String countryCode) async {
    // Load the language JSON file from the "lang" folder
    Map<String, dynamic>? jsonMap;

    try {
      var data;
      if (countryCode.isNotEmpty) {
        final file = File('${Stringcare().languageOrigin}/${languageCode}_$countryCode.json');
        data = file.readAsBytesSync();
      } else {
        final file = File('${Stringcare().languageOrigin}/${languageCode}.json');
        data = file.readAsBytesSync();
      }
      jsonMap = json.decode(
        utf8.decode(
          data,
          allowMalformed: true,
        ),
      );
    } catch (e) {
      try {
        final file = File('${Stringcare().languageOrigin}/$languageCode.json');
        jsonMap = json.decode(
          utf8.decode(
            file.readAsBytesSync(),
            allowMalformed: true,
          ),
        );
      } catch (e) {
        _localizedStrings = Map();
      }
    }

    _localizedStrings = jsonMap?.map(
          (key, value) {
            return MapEntry(key, value.toString());
          },
        ) ??
        Map<String, String>();

    var asyncLoad = false;

    var language =
        RemoteLanguages().localizedStrings['$languageCode-$countryCode'] ??
            RemoteLanguages().localizedStrings['$languageCode'] ??
            Map();

    if (language.isNotEmpty) {
      for (var entry in language.entries.toList()) {
        _localizedStrings[entry.key] = language[entry.key] ?? '';
      }
      asyncLoad = true;
    }

    if (!asyncLoad) {
      for (var lang in RemoteLanguages().localizedStrings.keys.toList()) {
        if (lang.contains('$languageCode-')) {
          var language = RemoteLanguages().localizedStrings[lang] ?? Map();
          for (var entry in language.entries.toList()) {
            _localizedStrings[entry.key] = language[entry.key] ?? '';
          }
          break;
        }
      }
    }

    return true;
  }

  static Future<String?> sTranslate(
    String language,
    String key, {
    List<String>? values,
  }) async {
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
            .load('${Stringcare().languageOrigin}/${lang}_$country.json');
      } else {
        data =
            await rootBundle.load('${Stringcare().languageOrigin}/$lang.json');
      }
      jsonMap = json
          .decode(utf8.decode(data.buffer.asUint8List(), allowMalformed: true));
    } catch (e) {
      try {
        var data =
            await rootBundle.load('${Stringcare().languageOrigin}/$lang.json');
        jsonMap = json.decode(
            utf8.decode(data.buffer.asUint8List(), allowMalformed: true));
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
  @override
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

  @override
  String getLang() {
    if (delegate.isSupported(locale)) {
      return "${locale.languageCode}_${locale.countryCode}";
    }
    final defaultLocale = Stringcare().locales[0];
    return "${defaultLocale.languageCode}_${defaultLocale.countryCode}";
  }
}

class _AppLocalizationsDelegateTest
    extends LocalizationsDelegate<AppLocalizationsTest> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegateTest();

  @override
  bool isSupported(Locale locale) {
    for (Locale supportedLocale in Stringcare().locales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<AppLocalizationsTest> load(Locale locale) async {
    AppLocalizationsTest localizations = new AppLocalizationsTest(locale);
    RemoteLanguages().localizations = localizations;
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegateTest old) {
    if (RemoteLanguages().shouldReload) {
      RemoteLanguages().shouldReload = false;
      return true;
    }
    return false;
  }
}
