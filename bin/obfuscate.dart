import 'package:stringcare/src/compile/utils.dart';

void main(List<String> arguments) async {
  print(introMessage('0.0.1'));

  var config = loadConfigFile();

  /// Prepare assets
  var assetsPaths = await processAssetsObfuscation(config);

  /// Prepare lang
  var langsPaths = await processLangObfuscation(config);

  buildRFile(config, assetsPaths, langsPaths);
}