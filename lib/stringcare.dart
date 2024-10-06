import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_refresh/global_refresh.dart';
import 'package:go_router/go_router.dart';
import 'package:stringcare/src/compile/stringcare_impl.dart' as compile;
import 'package:stringcare/src/i18n/app_localizations_interface.dart';
import 'package:stringcare/src/i18n/app_localizations_test.dart';
import 'package:stringcare/src/web/stringcare_impl.dart'
    if (dart.library.io) 'package:stringcare/src/native/stringcare_impl.dart';

import 'src/commons/stringcare_commons.dart';
import 'src/i18n/app_localizations.dart';
import 'src/i18n/fallback_cupertino_localizations_delegate.dart';

export 'src/extension/stringcare_ext.dart';
export 'src/i18n/remote_languages.dart';
export 'src/widget/sc_asset_image_provider.dart';
export 'src/widget/sc_image_asset.dart';
export 'src/widget/sc_state.dart';
export 'src/widget/sc_svg.dart';

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

  /// Disables native libs (.so and .dylib) and uses the Dart implementation.
  var disableNative = false;

  /// Defines the origin of the text resources. When the encrypted mode is TRUE,
  /// the encrypted resources are consumed, otherwise the original unencrypted
  /// resources are used.
  var useEncrypted = true;

  var langPath = "lang";
  var langBasePath = "lang_base";

  String get languageOrigin => useEncrypted ? langPath : langBasePath;

  String? Function() withLang = () {
    return null;
  };

  Locale? Function() withLocale = () {
    return null;
  };

  List<Locale> locales = [Locale('en')];

  List<LocalizationsDelegate<dynamic>> commonDelegates = [
    FallbackCupertinoLocalisationsDelegate(),
    // Built-in localization of basic text for Material widgets
    GlobalMaterialLocalizations.delegate,
    // Built-in localization for text direction LTR/RTL
    GlobalWidgetsLocalizations.delegate,
  ];

  List<LocalizationsDelegate<dynamic>> get delegates {
    final list = <LocalizationsDelegate<dynamic>>[];
    for (var delegate in commonDelegates) {
      list.add(delegate);
    }
    // A class which loads the translations from JSON files
    if (useEncrypted) {
      list.add(AppLocalizations.delegate);
    } else {
      list.add(AppLocalizationsTest.delegate);
    }
    return list;
  }

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

  final StringcareCommons _productionApi = StringcareImpl();

  final StringcareCommons _testApi = compile.StringcareImpl();

  StringcareCommons get _api => disableNative ? _testApi : _productionApi;

  Future<String?> get platformVersion => _api.platformVersion;

  String testHash(List<String> keys) => _api.testHash(keys);

  String testSign(List<String> keys) => _api.testSign(keys);

  String obfuscate(String value) => _api.obfuscate(value);

  String obfuscateWith(List<String> keys, String value) =>
      _api.obfuscateWith(keys, value);

  Uint8List? obfuscateData(Uint8List value) => _api.obfuscateData(value);

  Uint8List? obfuscateDataWith(List<String> keys, Uint8List value) =>
      _api.obfuscateDataWith(keys, value);

  String reveal(String value) => _api.reveal(value);

  String revealWith(List<String> keys, String value) =>
      _api.revealWith(keys, value);

  Uint8List? revealData(Uint8List? value) => _api.revealData(value);

  Uint8List? revealDataWith(List<String> keys, Uint8List value) =>
      _api.revealDataWith(keys, value);

  String getSignature(List<String> keys) => _api.getSignature(keys);

  String getSignatureOfValue(String value) => _api.getSignatureOfValue(value);

  String getSignatureOfBytes(List<int> data) => _api.getSignatureOfBytes(data);

  bool validSignature(String signature, List<String> keys) =>
      _api.validSignature(signature, keys);

  String readableObfuscate(String value) => _api.readableObfuscate(value);

  String? translate(
    BuildContext context,
    String key, {
    List<String>? values,
  }) =>
      appLocalizations?.translate(
        key,
        values: values,
      );

  Future<String?> translateWithLang(
    String lang,
    String key, {
    List<String>? values,
  }) =>
      useEncrypted
          ? AppLocalizations.sTranslate(lang, key, values: values)
          : AppLocalizationsTest.sTranslate(lang, key, values: values);

  Future<Uint8List?> revealAsset(String key) async {
    var asset = await rootBundle.load(key);
    var list = asset.buffer.asUint8List();
    return Stringcare().revealData(list);
  }

  String? getLang() => getLangWithContext(context);

  String? getLangWithContext(BuildContext? context) {
    if (context == null) return null;
    return appLocalizations?.getLang();
  }

  Future<bool> load() => loadWithContext(context);

  AppLocalizationsInterface? get appLocalizations => useEncrypted
      ? AppLocalizations.of(context)
      : AppLocalizationsTest.of(context);

  Future<bool> loadWithContext(BuildContext? context) async {
    if (context == null) return false;
    return appLocalizations?.load() ?? Future.value(false);
  }

  Future<void> refreshWithLangWithContext(
    BuildContext? context,
    String? lang,
  ) async {
    withLang = () => lang;
    if (await Stringcare().loadWithContext(context)) {
      GlobalRefresh().refresh();
    }
  }

  Future<void> refreshWithLocaleWithContext(
    BuildContext? context,
    Locale? locale,
  ) async {
    withLocale = () => locale;
    if (await Stringcare().loadWithContext(context)) {
      GlobalRefresh().refresh();
    }
  }

  Future<void> refreshWithLang(String? lang) =>
      refreshWithLangWithContext(context, lang);

  Future<void> refreshWithLocale(Locale? locale) =>
      refreshWithLocaleWithContext(context, locale);
}
