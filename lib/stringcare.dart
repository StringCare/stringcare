import 'dart:typed_data';
import 'package:stringcare/src/web/stringcare_impl.dart'
    if (dart.library.io) 'package:stringcare/src/native/stringcare_impl.dart';
import 'src/commons/stringcare_commons.dart';

class Stringcare {
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
}
