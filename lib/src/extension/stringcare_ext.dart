import 'package:flutter/widgets.dart';
import 'package:stringcare/stringcare.dart';
import 'dart:typed_data';

extension StringcareStringExt on String {

  String on(BuildContext context, {List<String> values}) {
    return Stringcare.translate(context, this, values: values);
  }

  Future<String> getLang(String lang, {List<String> values}) {
    return Stringcare.translateWithLang(lang, this, values: values);
  }

  String obfuscate() {
    return Stringcare.obfuscate(this);
  }

  String obfuscateWith(List<String> keys) {
    return Stringcare.obfuscateWith(keys, this);
  }

  String reveal() {
    return Stringcare.reveal(this);
  }

  String revealWith(List<String> keys) {
    return Stringcare.revealWith(keys, this);
  }

  String readableObfuscate() {
    return Stringcare.readableObfuscate(this);
  }

  Future<Uint8List> revealAsset() async {
    return Stringcare.revealAsset(this);
  }

}

extension StringcareUint8ListExt on Uint8List {

  Uint8List obfuscateData() {
    return Stringcare.obfuscateData(this);
  }

  Uint8List obfuscateDataWith(List<String> keys) {
    return Stringcare.obfuscateDataWith(keys, this);
  }

  Uint8List revealData() {
    return Stringcare.revealData(this);
  }

  Uint8List revealDataWith(List<String> keys) {
    return Stringcare.revealDataWith(keys, this);
  }

}
