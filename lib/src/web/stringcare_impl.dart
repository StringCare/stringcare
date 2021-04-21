import 'dart:typed_data';

import 'package:stringcare/src/commons/stringcare_commons.dart';
import 'package:stringcare/src/web/c_helper.dart';

import 'c_aproximation.dart' as c;

class StringcareImpl extends StringcareCommons {
  StringcareImpl();

  String obfuscateWith(List<String> keys, String value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return "";
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      var data = stringToUint8List(value);

      var res = getStringBytesFromIntList(
          c.obfuscate(key, data, key.length, data.length));

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Uint8List obfuscateDataWith(List<String> keys, Uint8List value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return null;
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      var res = c.obfuscate(key, value, key.length, value.length);

      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String revealWith(List<String> keys, String value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return "";
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      var data = stringByteToInt32(value);

      var res =
          getStringFromRevealed(c.reveal(key, data, key.length, data.length));

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Uint8List revealDataWith(List<String> keys, Uint8List value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return null;
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      var res = c.reveal(key, value, key.length, value.length);

      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  String testSign(List<String> keys) {
    var key = "";
    if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
      key = prepareKey(keys);
    }
    return c.testSign(key);
  }

  @override
  String testHash(List<String> keys) {
    var key = "";
    if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
      key = prepareKey(keys);
    }
    return c.testHash(key);
  }
}
