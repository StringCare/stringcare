import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_refresh/global_refresh.dart';
import 'package:go_router/go_router.dart';
import 'package:stringcare/src/web/stringcare_impl.dart'
    if (dart.library.io) 'package:stringcare/src/native/stringcare_impl.dart';

import 'src/commons/stringcare_commons.dart';
import 'src/i18n/app_localizations.dart';
import 'src/i18n/fallback_cupertino_localizations_delegate.dart';

export 'src/extension/stringcare_ext.dart';
export 'src/i18n/remote_languages.dart';
export 'src/widget/sc_asset_image_provider.dart';
export 'src/widget/sc_image_asset.dart';
export 'src/widget/sc_svg.dart';
export 'src/widget/sc_state.dart';

class Stringcare {
  static Stringcare? _instance;

  Stringcare._internal();

  GoRouter? router;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context {
    final context = router?.routerDelegate.navigatorKey.currentContext ??
        navigatorKey.currentContext;
    if (context == null) {
      throw Exception('💥 Context not ready');
    }
    return context;
  }

  factory Stringcare() {
    _instance ??= Stringcare._internal();
    return _instance!;
  }

  var langPath = "lang";

  String? Function() withLang = () {
    return null;
  };

  Locale? Function() withLocale = () {
    return null;
  };

  List<Locale> locales = [Locale('en')];

  List<LocalizationsDelegate<dynamic>> delegates = [
    FallbackCupertinoLocalisationsDelegate(),
    // A class which loads the translations from JSON files
    AppLocalizations.delegate,
    // Built-in localization of basic text for Material widgets
    GlobalMaterialLocalizations.delegate,
    // Built-in localization for text direction LTR/RTL
    GlobalWidgetsLocalizations.delegate,
  ];

  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback =
      (locale, supportedLocales) {
    if (locale == null) return supportedLocales.first;

    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode.toLowerCase() ==
              locale.languageCode.toLowerCase() &&
          supportedLocale.countryCode?.toLowerCase() ==
              locale.countryCode?.toLowerCase()) {
        return supportedLocale;
      }
    }

    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode.toLowerCase() ==
          locale.languageCode.toLowerCase()) {
        if (supportedLocale.countryCode != null &&
            supportedLocale.countryCode!.isEmpty) {
          return supportedLocale;
        } else if (supportedLocale.countryCode == null) {
          return supportedLocale;
        }
      }
    }

    // If the locale of the device is not supported, use the first one
    // from the list (English, in this case).
    return supportedLocales.first;
  };

  final StringcareCommons api = StringcareImpl();

  Future<String?> get platformVersion async {
    return api.platformVersion;
  }

  String testHash(List<String> keys) {
    return api.testHash(keys);
  }

  String testSign(List<String> keys) {
    return api.testSign(keys);
  }

  String obfuscate(String value) {
    return api.obfuscate(value);
  }

  String obfuscateWith(List<String> keys, String value) {
    return api.obfuscateWith(keys, value);
  }

  Uint8List? obfuscateData(Uint8List value) {
    return api.obfuscateData(value);
  }

  Uint8List? obfuscateDataWith(List<String> keys, Uint8List value) {
    return api.obfuscateDataWith(keys, value);
  }

  String reveal(String value) {
    return api.reveal(value);
  }

  String revealWith(List<String> keys, String value) {
    return api.revealWith(keys, value);
  }

  Uint8List? revealData(Uint8List? value) {
    return api.revealData(value);
  }

  Uint8List? revealDataWith(List<String> keys, Uint8List value) {
    return api.revealDataWith(keys, value);
  }

  String getSignature(List<String> keys) {
    return api.getSignature(keys);
  }

  String getSignatureOfValue(String value) {
    return api.getSignatureOfValue(value);
  }

  String getSignatureOfBytes(List<int> data) {
    return api.getSignatureOfBytes(data);
  }

  bool validSignature(String signature, List<String> keys) {
    return api.validSignature(signature, keys);
  }

  String readableObfuscate(String value) {
    return api.readableObfuscate(value);
  }

  String? translate(BuildContext context, String key, {List<String>? values}) {
    return AppLocalizations.of(context)!.translate(
      key,
      values: values,
    );
  }

  Future<String?> translateWithLang(String lang, String key,
      {List<String>? values}) {
    return AppLocalizations.sTranslate(lang, key, values: values);
  }

  Future<Uint8List?> revealAsset(String key) async {
    var asset = await rootBundle.load(key);
    var list = asset.buffer.asUint8List();
    return Stringcare().revealData(list);
  }

  String? getLang() => getLangWithContext(context);

  String? getLangWithContext(BuildContext? context) {
    if (context == null) return null;
    return AppLocalizations.of(context)?.getLang();
  }

  Future<bool> load() => loadWithContext(context);

  Future<bool> loadWithContext(BuildContext? context) async {
    if (context == null) return false;
    return AppLocalizations.of(context)?.load() ?? Future.value(false);
  }

  void refreshWithLang(String? lang) {
    withLang = () => lang;
    GlobalRefresh().refresh();
  }

  void refreshWithLocale(Locale? locale) {
    withLocale = () => locale;
    GlobalRefresh().refresh();
  }
}
