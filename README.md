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

You can locate the `stringcare.cpp` file in:

```
stringcare/ios/classes/Classes/stringcare.cpp
```

If XCode ask for include the `Runner-Bridging-Header.h` file to the project, do it.

![setup](https://github.com/StringCare/stringcare/raw/master/images/ios_macos_setup.png?raw=true)

#### Key setup

This is not a precompiled library (`dylib`, `dll`, `so`) so it is strongly recommended to change the default values in the C++ file.

You can locate the `stringcare.cpp` file in:

```
stringcare/ios/classes/Classes/stringcare.cpp
```

```cpp
std::string sign(std::string key) {
    std::string val = "";
    int i = 0;
    int u = 0;
    for (char &c : key) {
        val[u] = c;
        u++;
        # i = i + (int) c + ((2 + 3 + 6) * (4 + 2) * (3 * 1) * u); default
        i = i + (int) c + ((4 + 2) * (3 * 1) * u);
        val += std::to_string(i);
        u = u + (std::to_string(i).length() - 1);
    }
    return val;
}
```

```cpp
extern "C" __attribute__((visibility("default"))) __attribute__((used))
int *obfuscate(char const *key, int *value, int const keySize, int const valueSize) {
    std::string pd = "hello_world";
    # ...
}
```

```cpp
extern "C" __attribute__((visibility("default"))) __attribute__((used))
int *reveal(char const *key, int *value, int const keySize, int const valueSize) {
    std::string pd = "hello_world";
    # ...
}
```

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

