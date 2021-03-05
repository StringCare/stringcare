import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

class Stringcare {
  static const MethodChannel _channel = const MethodChannel('stringcare');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String getSignature(List<String> keys) {
    return sha256.convert(utf8.encode(_prepareKey(keys))).toString();
  }

  static String getSignatureOfValue(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  static String getSignatureOfBytes(List<int> data) {
    return sha256.convert(data).toString();
  }

  static bool validSignature(String signature, List<String> keys) {
    if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
      return signature == getSignature(keys);
    }
    return false;
  }

  static String readableObfuscate(String value) {
    return utf8.decode(value.split(",").map((e) => int.parse(e)).toList(),
        allowMalformed: true);
  }

  static String obfuscate(String value) {
    return obfuscateWith([], value);
  }

  static String obfuscateWith(List<String> keys, String value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return "";
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = _prepareKey(keys);
      }

      final DynamicLibrary stringcareLib = Platform.isAndroid
          ? DynamicLibrary.open("libstringcare.so")
          : DynamicLibrary.process();

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          obfuscate = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("obfuscate")
              .asFunction();

      var intSize = _originalStringInt32Size(value);

      var data = _stringToInt32(value);

      var res = _getStringBytesFromIntList(
          obfuscate(
              key.toNativeUtf8(), data, key.length, intSize),
          intSize);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }

  static Uint8List obfuscateDataWith(List<String> keys, Uint8List value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return null;
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = _prepareKey(keys);
      }

      final DynamicLibrary stringcareLib = Platform.isAndroid
          ? DynamicLibrary.open("libstringcare.so")
          : DynamicLibrary.process();

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          obfuscate = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("obfuscate")
              .asFunction();

      var data = _dataToInt32(value);

      var res = _getBytesFromIntList(
          obfuscate(key.toNativeUtf8(), data, key.length, value.length),
          value.length);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String reveal(String value) {
    return revealWith([], value);
  }

  static String revealWith(List<String> keys, String value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return "";
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = _prepareKey(keys);
      }

      final DynamicLibrary stringcareLib = Platform.isAndroid
          ? DynamicLibrary.open("libstringcare.so")
          : DynamicLibrary.process();

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          reveal = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("reveal")
              .asFunction();

      var intSize = _obfuscatedInt32Lent(value);

      var data = _stringByteToInt32(value);

      var res = _getBytesFromObfuscated(
          reveal(key.toNativeUtf8(), data, key.length,
              intSize),
          intSize);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }

  static Uint8List revealDataWith(List<String> keys, Uint8List value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return null;
      }

      if (keys != null && keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = _prepareKey(keys);
      }

      final DynamicLibrary stringcareLib = Platform.isAndroid
          ? DynamicLibrary.open("libstringcare.so")
          : DynamicLibrary.process();

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          reveal = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("reveal")
              .asFunction();

      var data = _dataToInt32(value);

      var res = _getBytesFromIntList(
          reveal(key.toNativeUtf8(), data, key.length,
              value.length),
          value.length);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String _getStringBytesFromIntList(
      Pointer<Int32> listOfBytes, int size) {
    return listOfBytes
        .asTypedList(size)
        .toList()
        .map((e) {
          return e.toString();
        })
        .toList()
        .join(",");
  }

  static Uint8List _getBytesFromIntList(Pointer<Int32> listOfBytes, int size) {
    return Uint8List.fromList(listOfBytes.asTypedList(size).toList());
  }

  static String _getBytesFromObfuscated(Pointer<Int32> listOfBytes, int size) {
    var list = listOfBytes.asTypedList(size).toList();
    return utf8.decode(list.sublist(0, size), allowMalformed: true);
  }

  static int _originalStringInt32Size(String string) {
    final units = utf8.encode(string);
    return units.length;
  }

  static int _obfuscatedInt32Lent(String string) {
    return string.split(",").length;
  }

  static String _prepareKey(List<String> keys) {
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

  static Pointer<Int32> _dataToInt32(Uint8List value) {
    var list = value.toList();
    final Pointer<Int32> result = malloc<Int32>(list.length);
    final Int32List nativeArray = result.asTypedList(list.length);
    nativeArray.setAll(0, list);
    return result;
  }

  static Pointer<Int32> _stringToInt32(String string) {
    final units = utf8.encode(string);
    final Pointer<Int32> result = malloc<Int32>(units.length);
    final Int32List nativeArray = result.asTypedList(units.length);
    nativeArray.setAll(0, units);
    return result;
  }

  static Pointer<Int32> _stringByteToInt32(String string) {
    final array = string.split(",").map((e) => int.parse(e));
    final Pointer<Int32> result = malloc<Int32>(array.length);
    final Int32List nativeArray = result.asTypedList(array.length);
    nativeArray.setAll(0, array);
    return result;
  }
}
