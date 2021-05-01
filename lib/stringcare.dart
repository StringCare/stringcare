import 'dart:ui';
import 'dart:typed_data';
import 'package:stringcare/src/web/stringcare_impl.dart'
    if (dart.library.io) 'package:stringcare/src/native/stringcare_impl.dart';
import 'src/commons/stringcare_commons.dart';
import 'src/i18n/app_localizations.dart';
import 'src/i18n/fallback_cupertino_localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/src/widgets/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'src/widget/sc_asset_image_provider.dart';
export 'src/widget/sc_image_asset.dart';
export 'src/extension/stringcare_ext.dart';

class Stringcare {
  static var langPath = "lang";
  static var supportedLangs = ['en'];

  static List<LocalizationsDelegate<dynamic>> delegates = [
        FallbackCupertinoLocalisationsDelegate(),
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ];

  static Locale Function(Locale, Iterable<Locale>) localeResolutionCallback = (locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    // If the locale of the device is not supported, use the first one
    // from the list (English, in this case).
    return supportedLocales.first;
  };

  static StringcareCommons api = StringcareImpl();

  static Future<String> get platformVersion async {
    return api.platformVersion;
  }

  static String testHash(List<String> keys) {
    return api.testHash(keys);
  }

  static String testSign(List<String> keys) {
    return api.testSign(keys);
  }

  static String obfuscate(String value) {
    return api.obfuscate(value);
  }

  static String obfuscateWith(List<String> keys, String value) {
    return api.obfuscateWith(keys, value);
  }

  static Uint8List obfuscateData(Uint8List value) {
    return api.obfuscateData(value);
  }

  static Uint8List obfuscateDataWith(List<String> keys, Uint8List value) {
    return api.obfuscateDataWith(keys, value);
  }

  static String reveal(String value) {
    return api.reveal(value);
  }

  static String revealWith(List<String> keys, String value) {
    return api.revealWith(keys, value);
  }

  static Uint8List revealData(Uint8List value) {
    return api.revealData(value);
  }

  static Uint8List revealDataWith(List<String> keys, Uint8List value) {
    return api.revealDataWith(keys, value);
  }

  static String getSignature(List<String> keys) {
    return api.getSignature(keys);
  }

  static String getSignatureOfValue(String value) {
    return api.getSignatureOfValue(value);
  }

  static String getSignatureOfBytes(List<int> data) {
    return api.getSignatureOfBytes(data);
  }

  static bool validSignature(String signature, List<String> keys) {
    return api.validSignature(signature, keys);
  }

  static String readableObfuscate(String value) {
    return api.readableObfuscate(value);
  }

  static String translate(BuildContext context, String key, {List<String> values}) {
    return AppLocalizations.of(context).translate(key, values: values);
  }

  static Future<String> translateWithLang(String lang, String key, {List<String> values}) {
    return AppLocalizations.sTranslate(lang, key, values: values);
  }

  static Future<Uint8List> revealAsset(String key) async {
    var asset = await rootBundle.load(key);
    var list = asset.buffer.asUint8List();
    return Stringcare.revealData(list);
  }

  static String getLang(BuildContext context) {
    return AppLocalizations.of(context).getLang();
  }
}
