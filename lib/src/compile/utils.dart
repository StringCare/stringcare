import 'package:path/path.dart';
import 'package:yaml/yaml.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:stringcare/src/compile/stringcare_impl.dart';
import 'package:stringcare/src/compile/c_helper.dart' as helper;
import 'package:stringcare/src/compile/exceptions.dart';
import 'dart:typed_data';

String introMessage(String version) => '''
  ════════════════════════════════════════════
     Stringcare (v $version)
     Hash: ${StringcareImpl().testHash([])}                               
     Sign: ${StringcareImpl().testSign([])}                               
  ════════════════════════════════════════════
  ''';

String infoAssetsObfuscateMessage(String assetsPath, String assetsBasePath) => '''
  Generating obfuscated assets:
   - From "$assetsBasePath"
   - To "$assetsPath"                              
  ''';

String infoLangObfuscateMessage(String langPath, String langBasePath) => '''
  Generating obfuscated langs:
   - From "$langBasePath"
   - To "$langPath"                              
  ''';

String infoAssetsFileObfuscationMessage(String originalFile, String obfuscatedFile) => '''
  Obfuscating:
   - From "$originalFile"
   - To "$obfuscatedFile"                              
  ''';

String infoAssetsRevealedMessage(String assetsPath, String assetsBasePath) => '''
  Generating revealed assets:
   - From "$assetsBasePath"
   - To "$assetsPath"                              
  ''';

String infoLangRevealedMessage(String assetsPath, String assetsBasePath) => '''
  Generating revealed lang:
   - From "$assetsBasePath"
   - To "$assetsPath"                              
  ''';

String infoAssetsFileRevealedMessage(String originalFile, String revealedFile) => '''
  Revealing:
   - From "$originalFile"
   - To "$revealedFile"                              
  ''';

void obfuscateFile(String originalFilePath, String obfuscatedFilePath) {
  final api = StringcareImpl();

  var originalFile = File(originalFilePath);
  var obfuscatedFile = File(obfuscatedFilePath);

  Uint8List originalData = originalFile.readAsBytesSync(); 
  // print("original hash: ${api.getSignatureOfBytes(originalData)}");

  Uint8List obfuscatedData = api.obfuscateData(originalData);
  // print("result hash: ${api.getSignatureOfBytes(obfuscatedData)}");

  obfuscatedFile.writeAsBytesSync(obfuscatedData);
}

void revealFile(String originalFilePath, String revealedFilePath) {
  final api = StringcareImpl();

  var originalFile = File(originalFilePath);
  var revealedFile = File(revealedFilePath);

  Uint8List originalData = originalFile.readAsBytesSync(); 

  Uint8List revealedData = api.revealData(originalData);
  revealedFile.writeAsBytesSync(revealedData);
}

Map<String, dynamic> loadConfigFile() {
  final File file = File("pubspec.yaml");
  final String yamlString = file.readAsStringSync();
  // ignore: always_specify_types
  final Map yamlMap = loadYaml(yamlString);

  if (!(yamlMap['stringcare'] is Map)) {
    stderr.writeln(NoConfigFoundException('Check that your config file pubspec.yaml has a `stringcare` section'));
    exit(1);
  }

  final Map<String, dynamic> config = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry in yamlMap['stringcare'].entries) {
    config[entry.key] = entry.value;
  }

  return config;
}

Future<List<FileSystemEntity>> dirContents(String path) {
  final files = <FileSystemEntity>[];
  final completer = Completer<List<FileSystemEntity>>();
  final lister = Directory(path).list(recursive: true);
  lister.listen((file) {
    if (!FileSystemEntity.isDirectorySync(file.path))
      files.add(file);
  }, onDone: () => completer.complete(files));
  return completer.future;
}

Future<List<String>> processAssetsObfuscation(Map<String, dynamic> config) async {
  var paths = <String>[];
  if (!config.containsKey("assets")) {
    return paths;
  }
  if (!config["assets"].containsKey("obfuscated")) {
    return paths;
  }
  if (!config["assets"].containsKey("original")) {
    return paths;
  }
  
  var assetsPath = config["assets"]["obfuscated"];
  var assetsBasePath = config["assets"]["original"];

  print(infoAssetsObfuscateMessage(assetsPath, assetsBasePath));

  final baseFiles = await dirContents(assetsBasePath);

  for (var item in baseFiles) {
    var originalFilePath = item.path;

    var obfuscatedFilePath = "${item.path.replaceAll(assetsBasePath, assetsPath)}";
    var folderDestiny = Directory(obfuscatedFilePath.replaceAll(basename(item.path), ""));

    if (!folderDestiny.existsSync()) {
        folderDestiny.createSync(recursive: true);
    }
    paths.add("$assetsPath${obfuscatedFilePath.split(assetsPath)[1]}");
    print(infoAssetsFileObfuscationMessage(originalFilePath, obfuscatedFilePath));

    obfuscateFile(originalFilePath, obfuscatedFilePath);
  }

  return paths;
}

Future<List<String>> processLangObfuscation(Map<String, dynamic> config) async {
  var keys = <String>[];

  if (!config.containsKey("lang")) {
    return keys;
  }
  if (!config["lang"].containsKey("obfuscated")) {
    return keys;
  }
  if (!config["lang"].containsKey("original")) {
    return keys;
  }

  var langPath = config["lang"]["obfuscated"];
  var langBasePath = config["lang"]["original"];

  print(infoLangObfuscateMessage(langPath, langBasePath));

  final baseFiles = await dirContents(langBasePath);


  for (var item in baseFiles) {
    var originalFilePath = item.path;
    var obfuscatedFilePath = "${langPath}/${basename(item.path)}";
    print(infoAssetsFileObfuscationMessage(originalFilePath, obfuscatedFilePath));

    var file = File(originalFilePath);
    var data = await file.readAsBytes();
    Map<String, dynamic> jsonMap = json.decode(utf8.decode(data, allowMalformed: true));
    for (String key in jsonMap.keys) {
      if (!keys.contains(key))
        keys.add(key);
    }
    obfuscateFile(originalFilePath, obfuscatedFilePath);
  }
  
  return keys;
}

void processAssetsReveal(Map<String, dynamic> config) async {
  if (!config.containsKey("assets")) {
    return;
  }
  if (!config["assets"].containsKey("obfuscated")) {
    return;
  }
  if (!config["assets"].containsKey("test")) {
    return;
  }
    
  var assetsPath = config["assets"]["obfuscated"];
  var assetsTestPath = config["assets"]["test"];

  print(infoAssetsRevealedMessage(assetsTestPath, assetsPath));

  final baseFiles = await dirContents(assetsPath);

  for (var item in baseFiles) {
    var originalFilePath = item.path;

    var revealedFilePath = "${item.path.replaceAll(assetsPath, assetsTestPath)}";
    var folderDestiny = Directory(revealedFilePath.replaceAll(basename(item.path), ""));

    if (!folderDestiny.existsSync()) {
        folderDestiny.createSync(recursive: true);
    }

    print(infoAssetsFileRevealedMessage(originalFilePath, revealedFilePath));

    revealFile(originalFilePath, revealedFilePath);
  }
}

void processLangReveal(Map<String, dynamic> config) async {
  if (!config.containsKey("lang")) {
    return;
  }
  if (!config["lang"].containsKey("obfuscated")) {
    return;
  }
  if (!config["lang"].containsKey("test")) {
    return;
  }
  
  var langPath = config["lang"]["obfuscated"];
  var langTestPath = config["lang"]["test"];

  print(infoLangRevealedMessage(langTestPath, langPath));

  final baseFiles = await dirContents(langPath);

  for (var item in baseFiles) {
    var originalFilePath = item.path;
    var revealedFilePath = "${langTestPath}/${basename(item.path)}";
    print(infoAssetsFileRevealedMessage(originalFilePath, revealedFilePath));

    revealFile(originalFilePath, revealedFilePath);
  }
}

void buildRFile(Map<String, dynamic> config, List<String> assets, List<String> keys,) {
  var className = "R";
  var classDir = "lib";

  if (config.containsKey("resources")) {
    if (config["resources"].containsKey("class_name")) {
      className = config["resources"]["class_name"];
    }
    if (!config["resources"].containsKey("class_dir")) {
      classDir = config["resources"]["class_dir"];
    }
  }

  var assetsContent = '''
  ''';

  var i = 0;
  for (String asset in assets) {
    if (i > 0) {
      assetsContent += "\t";
    }
    var parts = asset.split("/");
    var cPart = parts.sublist(1, parts.length).join("/");
    assetsContent += "final String ${cPart.replaceAll("/", "_").replaceAll(".", "_")} = \"$asset\";\n";
    i++;
  }

  var langsContent = '''
  ''';

  i = 0;
  for (String key in keys) {
    if (i > 0) {
      langsContent += "\t";
    }
    langsContent += "final String ${key} = \"$key\";\n";
    i++;
  }

  var content = '''
/// Autogenerated file. Run the obfuscation command for refresh:
/// 
///      flutter pub run stringcare:obfuscate
/// 

// ignore_for_file: non_constant_identifier_names
class Assets {
  Assets();

$assetsContent
}

class Strings {
  Strings();

$langsContent
}

class $className {
  static Assets assets = Assets();
  static Strings strings = Strings();
}
  ''';

  var filePath = "$classDir";
  if (!filePath.endsWith("/")) {
    filePath += "/";
  } 
  filePath += "${className.toLowerCase()}.dart";

  var file = File(filePath);
  file.writeAsBytesSync(helper.stringToUint8List(content));

  print("Generated $className class in $filePath");
}