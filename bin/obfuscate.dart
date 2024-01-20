import 'package:stringcare/src/compile/utils.dart';

void main(List<String> arguments) async {
  print(introMessage('0.1.0'));

  var config = loadConfigFile();

  /// Prepare assets
  var assetsPaths = await processAssetsObfuscation(config);

  /// Prepare lang
  var stringKeys = await processLangObfuscation(config);

  buildRFile(config, assetsPaths, stringKeys);
}
