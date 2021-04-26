import 'package:stringcare/src/compile/utils.dart';
import 'package:path/path.dart';

void main(List<String> arguments) async {
  print(introMessage('0.0.1'));

  var config = loadConfigFile();

  /// Prepare assets
  await processAssetsReveal(config);

  /// Prepare lang
  await processLangReveal(config);
}