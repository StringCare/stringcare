import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

import 'stringcare_platform.dart';

abstract class StringcareCommons implements StringcarePlatform {
  static const MethodChannel _channel = const MethodChannel('stringcare');

  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  String obfuscate(String value) {
    return obfuscateWith([], value);
  }

  Uint8List obfuscateData(Uint8List value) {
    return obfuscateDataWith([], value);
  }

  String reveal(String value) {
    return revealWith([], value);
  }

  Uint8List revealData(Uint8List value) {
    return revealDataWith([], value);
  }

  int originalStringInt32Size(String string) {
    final units = utf8.encode(string);
    return units.length;
  }

  int obfuscatedInt32Lent(String string) {
    return string.split(",").length;
  }

  String prepareKey(List<String> keys) {
    keys.sort((a, b) => a.compareTo(b));
    int max = 0;

    keys.forEach((key) {
      if (max < key.length) {
        max = key.length;
      }
    });

    String key = "";
    for (int x = 0; x < max; x++) {
      for (int y = 0; y < keys.length; y++) {
        var list = keys[y];
        if (x < list.length) {
          key += list[x];
        }
      }
    }

    return key;
  }

  String getSignature(List<String> keys) {
    return sha256.convert(utf8.encode(prepareKey(keys))).toString();
  }

  String getSignatureOfValue(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  String getSignatureOfBytes(List<int> data) {
    return sha256.convert(data).toString();
  }

  bool validSignature(String signature, List<String> keys) {
    if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
      return signature == getSignature(keys);
    }
    return false;
  }

  String readableObfuscate(String value) {
    return utf8.decode(value.split(",").map((e) => int.parse(e)).toList(),
        allowMalformed: true);
  }
}
