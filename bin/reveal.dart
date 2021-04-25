import 'package:stringcare/src/compile/utils.dart';
import 'package:path/path.dart';

void main(List<String> arguments) async {
  print(introMessage('0.0.1'));

  var config = loadConfigFile();

  var assetsPath = config["assets_reveal_test_path"];
  var assetsBasePath = config["assets_path"];

  print(infoAssetsRevealedMessage(assetsPath, assetsBasePath));

  final baseFiles = await dirContents(assetsBasePath);

  for (var item in baseFiles) {
    var originalFilePath = item.path;
    var revealedFilePath = "${assetsPath}/${basename(item.path)}";
    print(infoAssetsFileRevealedMessage(originalFilePath, revealedFilePath));

    revealFile(originalFilePath, revealedFilePath);
  }

}