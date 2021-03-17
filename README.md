
<p align="center"><img width="10%" vspace="10" src="https://github.com/StringCare/stringcare/raw/master/images/ic_launcher/res/mipmap-xxxhdpi/ic_launcher.png"></p>

<h2 align="center" style="margin-bottom:30px" vspace="20">Stringcare for Flutter</h2>
<p align="center"><a href="https://landa-app.com/">Land-a dependency</a></p>
<p align="center"><img width="10%" vspace="20" src="https://github.com/StringCare/AndroidLibrary/raw/develop/white.png"></p>


- Platforms supported: Android, iOS, macOS

This is a Flutter plugin for encrypt/decrypt `String` and `Uint8List` objects easily with C++ code. 

Only `ffi` and `crypto` dependencies are used.

### Installation

It is not possible to use the plugin directly by adding the dependency to the `pubspec.yaml` file.
Due to some limitations when adding the C++ file to the iOS and macOS runner targets, you need to fork/clone the repository.

> In order to increase the security, it is recommended to modify the code (how the keys are generated) in your fork before use it.

> Make your fork private.

Clone your private fork to your local machine.

```bash
git clone https://github.com/YOUR-USERNAME/stringcare.git
```

Then include the dependency to the `pubspec.yaml` file.

```yaml
dependencies:
    stringcare:
        git:
            url: https://github.com/YOUR-USERNAME/stringcare.git
```

> Since Flutter 2, I noticed dangerous problems when indexing the project after adding the local dependency by `path: ../whatever`. That's why I recommend to implement the plugin by `git: url: https://..`.

#### iOS and macOS setup

Add the C++ file to the `Runner` targets.

You can locate the `stringcare.cpp` file in your cloned private fork:

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

### Finish the setup

Once you modify the C++ file as you want, you need to push those changes to your private fork. For updating the plugin from a git repository you can:

```bash
// remove stringcare from your pubspec.yaml

flutter pub get

// add stringcare again to your pubspec.yaml

flutter pub get
```

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

