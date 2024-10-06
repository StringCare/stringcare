abstract class AppLocalizationsInterface {
  Future<bool> load();

  String getLang();

  String? translate(String key, {List<String>? values});
}
