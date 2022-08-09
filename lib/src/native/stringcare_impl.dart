import 'dart:typed_data';
import 'dart:io';

import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:stringcare/src/commons/stringcare_method_channel.dart';

import 'c_helper.dart';

class StringcareImpl extends StringcareMethodChannel {
  late DynamicLibrary stringcareLib;

  StringcareImpl() {
    if (Platform.isAndroid) {
      stringcareLib = DynamicLibrary.open("libstringcare.so");
    } else if (Platform.isIOS) {
      stringcareLib = DynamicLibrary.process();
    } else if (Platform.isMacOS) {
      stringcareLib = DynamicLibrary.process();
    } else if (Platform.isWindows) {
      stringcareLib = DynamicLibrary.open('stringcare.dll');
    } else if (Platform.isLinux) {
      stringcareLib =
          DynamicLibrary.open(Platform.environment['LIBSTRINGCARE_PATH']!);
    }
  }

  @override
  String obfuscateWith(List<String> keys, String value) {
    try {
      var key = "";
      if (value.isEmpty) {
        return "";
      }

      if (keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          obfuscate = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("obfuscate")
              .asFunction();

      var intSize = originalStringInt32Size(value);

      var data = stringToInt32(value);

      var res = getStringBytesFromIntList(
          obfuscate(key.toNativeUtf8(), data, key.length, intSize), intSize);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  Uint8List? obfuscateDataWith(List<String> keys, Uint8List value) {
    try {
      var key = "";
      if (value.isEmpty) {
        return null;
      }

      if (keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          obfuscate = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("obfuscate")
              .asFunction();

      var data = dataToInt32(value);

      var res = getBytesFromIntList(
          obfuscate(key.toNativeUtf8(), data, key.length, value.length),
          value.length);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  String revealWith(List<String> keys, String value) {
    try {
      var key = "";
      if (value.isEmpty) {
        return "";
      }

      if (keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          reveal = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("reveal")
              .asFunction();

      var intSize = obfuscatedInt32Lent(value);

      var data = stringByteToInt32(value);

      var res = getStringFromRevealed(
          reveal(key.toNativeUtf8(), data, key.length, intSize), intSize);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  Uint8List? revealDataWith(List<String> keys, Uint8List? value) {
    try {
      var key = "";
      if (value == null || value.isEmpty) {
        return null;
      }

      if (keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      final Pointer<Int32> Function(
              Pointer<Utf8> key, Pointer<Int32> val, int keySize, int valueSize)
          reveal = stringcareLib
              .lookup<
                  NativeFunction<
                      Pointer<Int32> Function(Pointer<Utf8>, Pointer<Int32>,
                          Int32, Int32)>>("reveal")
              .asFunction();

      var data = dataToInt32(value);

      var res = getBytesFromIntList(
          reveal(key.toNativeUtf8(), data, key.length, value.length),
          value.length);

      malloc.free(data);

      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  String testSign(List<String> keys) {
    try {
      var key = "";
      if (keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      final Pointer<Utf8> Function(Pointer<Utf8> key) signTest = stringcareLib
          .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
              "signTest")
          .asFunction();

      var res = getStringFromUtf8List(signTest(key.toNativeUtf8()));

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  String testHash(List<String> keys) {
    try {
      var key = "";
      if (keys.isNotEmpty && keys.join("").isNotEmpty) {
        key = prepareKey(keys);
      }

      final Pointer<Utf8> Function(Pointer<Utf8> key) hashTest = stringcareLib
          .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
              "hashTest")
          .asFunction();

      var res = getStringFromUtf8List(hashTest(key.toNativeUtf8()));

      return res;
    } catch (e) {
      print(e);
      return "";
    }
  }
}
