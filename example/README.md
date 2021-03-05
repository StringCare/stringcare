# Stringcare for Flutter

- Platforms supported: Android, iOS, MacOS

This is a Flutter plugin for encrypt/decrypt `string` values and files with C++ code. 

Only `ffi` and `crypto ` dependencies are used.

### Installation

It is not possible to use the plugin directly by adding the dependency to the `pubspec.yaml` file.
Due to some limitations when adding the C++ file to the iOS and MacOS runner targets, you need to download the repository.

```bash
git clone https://github.com/StringCare/stringcare.git
```

Then include the dependency to the `pubspec.yaml` file.

```yaml
dependencies:
    stringcare:
        path: ../stringcare
```

#### iOS and MacOS setup

Add the C++ file to the `Runner` targets.

If XCode ask for include the `Runner-Bridging-Header.h` file to the project, do it.

<p align="center"><img width="80%" vspace="20" src="https://github.com/StringCare/stringcare/raw/master/images/ios_macos_setup.png"></p>

### Values usage 

#### Simple

```dart
String obfuscated = Stringcare.obfuscate("hello there 😀");
String revealed = Stringcare.reveal(obfuscated);

print(revealed); // prints "hello there 😀"
```

#### With extra keys
```dart
String p1 = "dsgfjkbndsgfbldsgbdjns";
String p2 = "sfvsfdgvsdfvsfdvsfvsrf";
String p3 = "dtlbkjdnsfvsftrglbjknd";

String obfuscated = Stringcare.obfuscateWith([p2, p1, p3], "hello there 😀");
String revealed = Stringcare.revealWith([p1, p3, p2], obfuscated);

print(revealed); // prints "hello there 😀"
```

### Files usage 

#### Simple

```dart
var file = File("file/path");

Uint8List obfuscated = Stringcare.obfuscateData(file.readAsBytesSync());
file.writeAsBytesSync(obfuscated);

Uint8List revealed = Stringcare.revealData(obfuscated);
file.writeAsBytesSync(revealed);
```

#### With extra keys
```dart
String p1 = "dsgfjkbndsgfbldsgbdjns";
String p2 = "sfvsfdgvsdfvsfdvsfvsrf";
String p3 = "dtlbkjdnsfvsftrglbjknd";

var file = File("file/path");

Uint8List obfuscated = Stringcare.obfuscateDataWith([p2, p1, p3], file.readAsBytesSync());
file.writeAsBytesSync(obfuscated);

Uint8List revealed = Stringcare.revealDataWith([p1, p3, p2], obfuscated);
file.writeAsBytesSync(revealed);
```

