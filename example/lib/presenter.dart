import 'dart:typed_data';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:stringcare/stringcare.dart';
import 'package:stringcare_example/vars.dart';

class Presenter {
  String p1 = "dsgfjkbndsgfbldsgbdjns";
  String p2 = "sfvsfdgvsdfvsfdvsfvsrf";
  String p3 = "dtlbkjdnsfvsftrglbjknd";

  ByteData imageBytes;

  String obfuscatedEmoji;
  String revealedEmoji;
  String signatureEmoji;
  String readableEmoji;
  bool sameSignatureTestEmoji;
  bool otherSignatureTestEmoji;

  String obfuscatedLorem;
  String revealedLorem;
  String signatureLorem;
  String readableLorem;
  bool sameSignatureTestLorem;
  bool otherSignatureTestLorem;

  Presenter() {
    obfuscatedEmoji = Stringcare.obfuscateWith([p2, p1, p3], Vars.emojis);
    revealedEmoji = Stringcare.revealWith([p1, p3, p2], obfuscatedEmoji);
    signatureEmoji = Stringcare.getSignature([p1, p2, p3]);
    readableEmoji = Stringcare.readableObfuscate(obfuscatedEmoji);
    sameSignatureTestEmoji =
        Stringcare.validSignature(signatureEmoji, [p3, p1, p2]);
    otherSignatureTestEmoji =
        Stringcare.validSignature(signatureEmoji, [p2, p3]);

    obfuscatedLorem = Stringcare.obfuscateWith([p2, p1, p3], Vars.loremipsu);
    revealedLorem = Stringcare.revealWith([p2, p1, p3], obfuscatedLorem);
    signatureLorem = Stringcare.getSignature([p1, p2, p3]);
    readableLorem = Stringcare.readableObfuscate(obfuscatedLorem);
    sameSignatureTestLorem =
        Stringcare.validSignature(signatureLorem, [p3, p1, p2]);
    otherSignatureTestLorem =
        Stringcare.validSignature(signatureLorem, [p2, p3]);
  }

  void prepareImages() {
    rootBundle.load('assets/voyager.jpeg').then((value) {
      imageBytes = value;
      var list = value.buffer.asUint8List();
      print(list.toString());
      var obfuscatedImage = Stringcare.obfuscateDataWith([p2, p1], list);
      print(obfuscatedImage.toString());
      var revealedImage = Stringcare.revealDataWith([p1, p2], obfuscatedImage);
      print(revealedImage.toString());

      String signA = Stringcare.getSignatureOfBytes(list);
      String signB = Stringcare.getSignatureOfBytes(revealedImage);
      print("signA: $signA");
      print("signB: $signB");
      print("same signature: ${signA == signB}");
    });
  }
}
