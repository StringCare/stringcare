import 'package:stringcare/src/compile/utils.dart';

void main(List<String> arguments) async {
  print(introMessage('0.0.1'));

  var config = loadConfigFile();

  /// Prepare assets
  await processAssetsObfuscation(config);

  /// Prepare lang
  await processLangObfuscation(config);
}