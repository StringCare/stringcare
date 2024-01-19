import 'package:flutter/foundation.dart';

import 'app_localizations.dart';

class RemoteLanguages {
  static RemoteLanguages? _instance;

  RemoteLanguages._internal();

  bool shouldReload = false;

  factory RemoteLanguages() {
    _instance ??= RemoteLanguages._internal();
    return _instance!;
  }

  Map<String, Map<String, String>> localizedStrings = Map();
  AppLocalizations? localizations;

  Future<void> addLanguage(String language, Map<String, String> values) async {
    localizedStrings[language] = values;
    shouldReload = true;
    await localizations?.load();
    if (kDebugMode) {
      print('Remote language loaded (${values.length} entries)');
    }
  }

  void addKeyLanguage(String language, String key, String value) {
    if (localizedStrings[language] == null) {
      localizedStrings[language] = Map();
    }
    localizedStrings[language]![key] = value;
  }

  Future<void> reload() async {
    shouldReload = true;
    await localizations?.load();
  }
}
