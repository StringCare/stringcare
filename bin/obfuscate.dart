import 'package:stringcare/src/compile/utils.dart';
import 'package:path/path.dart';

void main(List<String> arguments) async {
  print(introMessage('0.0.1'));

  var config = loadConfigFile();

  var assetsPath = config["assets_path"];
  var assetsBasePath = config["assets_base_path"];

  print(infoAssetsObfuscateMessage(assetsPath, assetsBasePath));

  final baseFiles = await dirContents(assetsBasePath);

  for (var item in baseFiles) {
    var originalFilePath = item.path;
    var obfuscatedFilePath = "${assetsPath}/${basename(item.path)}";
    print(infoAssetsFileObfuscationMessage(originalFilePath, obfuscatedFilePath));

    obfuscateFile(originalFilePath, obfuscatedFilePath);
  }

}