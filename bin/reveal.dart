import 'package:stringcare/src/compile/utils.dart';

void main(List<String> arguments) async {
  print(introMessage('0.1.0'));

  var config = loadConfigFile();

  /// Prepare assets
  await processAssetsReveal(config);

  /// Prepare lang
  await processLangReveal(config);
}
