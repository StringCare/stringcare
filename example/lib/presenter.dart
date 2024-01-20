import 'package:stringcare/stringcare.dart';
import 'package:stringcare_example/vars.dart';

class Presenter {
  String p1 = "dsgfjkbndsgfbldsgbdjns";
  String p2 = "sfvsfdgvsdfvsfdvsfvsrf";
  String p3 = "dtlbkjdnsfvsftrglbjknd";

  String obfuscatedBlank = '';
  String revealedBlank = '';
  String obfuscatedHello = '';
  String revealedHello = '';
  String obfuscatedEmoji = '';
  String revealedEmoji = '';
  String signatureEmoji = '';
  String readableEmoji = '';
  bool sameSignatureTestEmoji = false;
  bool otherSignatureTestEmoji = false;

  String obfuscatedLorem = '';
  String revealedLorem = '';
  String signatureLorem = '';
  String readableLorem = '';
  bool sameSignatureTestLorem = false;
  bool otherSignatureTestLorem = false;

  Presenter() {
    obfuscatedBlank = Vars.blank.obfuscate();
    revealedBlank = obfuscatedBlank.reveal();
    obfuscatedHello = Vars.hello.obfuscate();
    revealedHello = obfuscatedHello.reveal();

    obfuscatedEmoji = Vars.emojis.obfuscateWith([p2, p1, p3]);
    revealedEmoji = obfuscatedEmoji.revealWith([p1, p3, p2]);
    signatureEmoji = Stringcare().getSignature([p1, p2, p3]);
    readableEmoji = obfuscatedEmoji.readableObfuscate();
    sameSignatureTestEmoji =
        Stringcare().validSignature(signatureEmoji, [p3, p1, p2]);
    otherSignatureTestEmoji =
        Stringcare().validSignature(signatureEmoji, [p2, p3]);

    obfuscatedLorem = Vars.loremipsu.obfuscateWith([p2, p1, p3]);
    revealedLorem = obfuscatedLorem.revealWith([p2, p1, p3]);
    signatureLorem = Stringcare().getSignature([p1, p2, p3]);
    readableLorem = obfuscatedLorem.readableObfuscate();
    sameSignatureTestLorem =
        Stringcare().validSignature(signatureLorem, [p3, p1, p2]);
    otherSignatureTestLorem =
        Stringcare().validSignature(signatureLorem, [p2, p3]);
  }
}
