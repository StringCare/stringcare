
<p align="center"><img width="10%" vspace="10" src="https://github.com/StringCare/stringcare/raw/master/images/ic_launcher/res/mipmap-xxxhdpi/ic_launcher.png"></p>

<h2 align="center" style="margin-bottom:30px" vspace="20">Stringcare for Flutter</h2>
<p align="center">[Land-a dependency](https://landa-app.com/)</p>
<p align="center"><img width="10%" vspace="20" src="https://github.com/StringCare/AndroidLibrary/raw/develop/white.png"></p>


- Platforms supported: Android, iOS, macOS

This is a Flutter plugin for encrypt/decrypt `String` and `Uint8List` objects with C++ code. 

Only `ffi` and `crypto` dependencies are used.

### Installation

It is not possible to use the plugin directly by adding the dependency to the `pubspec.yaml` file.
Due to some limitations when adding the C++ file to the iOS and macOS runner targets, you need to download the repository.

```bash
git clone https://github.com/StringCare/stringcare.git
```

Then include the dependency to the `pubspec.yaml` file.

```yaml
dependencies:
    stringcare:
        path: ../stringcare
```

#### iOS and macOS setup

Add the C++ file to the `Runner` targets.

You can locate the `stringcare.cpp` file in:

```
stringcare/ios/Classes/stringcare.cpp
```

If XCode ask for include the `Runner-Bridging-Header.h` file to the project, do it.

![setup](https://github.com/StringCare/stringcare/raw/master/images/ios_macos_setup.png?raw=true)

#### Key setup

This is the default key used when no extra keys are provided.
Implement your own key by changing the `pd` value:

> stringcare/ios/Classes/stringcare.cpp

```cpp
std::string pd = "your_pasword";
```

> Feel free to change anything you want in this C++ file. I recommend you to change the numeric values of the `sign` method in this file.

### String usage 

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

### Uint8List usage 

#### Simple

```dart
var file = File("file/path");
Uint8List original = file.readAsBytesSync(); 

Uint8List obfuscated = Stringcare.obfuscateData(original);
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
Uint8List original = file.readAsBytesSync(); 

Uint8List obfuscated = Stringcare.obfuscateDataWith([p2, p1, p3], original);
file.writeAsBytesSync(obfuscated);

Uint8List revealed = Stringcare.revealDataWith([p1, p3, p2], obfuscated);
file.writeAsBytesSync(revealed);
```

