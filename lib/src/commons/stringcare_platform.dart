import 'dart:typed_data';

/// The interface that implementations of stringcare must implement.
///
/// Platform implementations should extend this class rather than implement it as `stringcare`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [StringcarePlatform] methods.
abstract class StringcarePlatform {
  /// Constructs a StringcarePlatform.
  StringcarePlatform();

  Future<String> get platformVersion async {
    throw UnimplementedError(
        'Future<String> get platformVersion has not been implemented.');
  }

  String testHash(List<String> keys) {
    throw UnimplementedError(
        'String obfuscate(String value) has not been implemented.');
  }

  String testSign(List<String> keys) {
    throw UnimplementedError(
        'String obfuscate(String value) has not been implemented.');
  }

  String obfuscate(String value) {
    throw UnimplementedError(
        'String obfuscate(String value) has not been implemented.');
  }

  String obfuscateWith(List<String> keys, String value) {
    throw UnimplementedError(
        'String obfuscateWith(List<String> keys, String value) has not been implemented.');
  }

  Uint8List obfuscateData(Uint8List value) {
    throw UnimplementedError(
        'Uint8List obfuscateData(Uint8List value) has not been implemented.');
  }

  Uint8List obfuscateDataWith(List<String> keys, Uint8List value) {
    throw UnimplementedError(
        'Uint8List obfuscateDataWith(List<String> keys, Uint8List value) has not been implemented.');
  }

  String reveal(String value) {
    throw UnimplementedError(
        'String reveal(String value) has not been implemented.');
  }

  String revealWith(List<String> keys, String value) {
    throw UnimplementedError(
        'String revealWith(List<String> keys, String value) has not been implemented.');
  }

  Uint8List revealData(Uint8List value) {
    throw UnimplementedError(
        'Uint8List revealData(Uint8List value) has not been implemented.');
  }

  Uint8List revealDataWith(List<String> keys, Uint8List value) {
    throw UnimplementedError(
        'Uint8List revealDataWith(List<String> keys, Uint8List value) has not been implemented.');
  }
}
