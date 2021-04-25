import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import 'dart:async';
import 'dart:io';
import 'package:stringcare/src/compile/stringcare_impl.dart';
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
  print("original hash: ${api.getSignatureOfBytes(originalData)}");

  Uint8List obfuscatedData = api.obfuscateData(originalData);
  print("result hash: ${api.getSignatureOfBytes(obfuscatedData)}");

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
  final lister = Directory(path).list(recursive: false);
  lister.listen((file) => files.add(file),
      onDone: () => completer.complete(files));
  return completer.future;
}