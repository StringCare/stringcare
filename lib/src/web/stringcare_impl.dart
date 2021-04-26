import 'dart:typed_data';

import 'package:stringcare/src/commons/stringcare_method_channel.dart';
import 'package:stringcare/src/compile/stringcare_impl.dart' as compile;

class StringcareImpl extends StringcareMethodChannel {

  final compile.StringcareImpl compiler = compile.StringcareImpl();

  StringcareImpl();

  String obfuscateWith(List<String> keys, String value) {
    return compiler.obfuscateWith(keys, value);
  }

  Uint8List obfuscateDataWith(List<String> keys, Uint8List value) {
    return compiler.obfuscateDataWith(keys, value);
  }

  String revealWith(List<String> keys, String value) {
    return compiler.revealWith(keys, value);
  }

  Uint8List revealDataWith(List<String> keys, Uint8List value) {
    return compiler.revealDataWith(keys, value);
  }

  @override
  String testSign(List<String> keys) {
    return compiler.testSign(keys);
  }

  @override
  String testHash(List<String> keys) {
    return compiler.testHash(keys);
  }
}
