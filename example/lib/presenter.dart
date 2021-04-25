import 'package:stringcare/stringcare.dart';
import 'package:stringcare_example/vars.dart';

class Presenter {
  String p1 = "dsgfjkbndsgfbldsgbdjns";
  String p2 = "sfvsfdgvsdfvsfdvsfvsrf";
  String p3 = "dtlbkjdnsfvsftrglbjknd";

  String obfuscatedBlank;
  String revealedBlank;
  String obfuscatedHello;
  String revealedHello;
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
    obfuscatedBlank = Stringcare.obfuscate(Vars.blank);
    revealedBlank = Stringcare.reveal(obfuscatedBlank);
    obfuscatedHello = Stringcare.obfuscate(Vars.hello);
    revealedHello = Stringcare.reveal(obfuscatedHello);

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
}
