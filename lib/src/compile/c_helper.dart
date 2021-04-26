import 'dart:typed_data';
import 'dart:convert';

String getStringFromRevealed(Uint8List listOfBytes) {
  return utf8.decode(listOfBytes, allowMalformed: true);
}

Uint8List stringToUint8List(
  String string,
) {
  return utf8.encode(string);
}

Uint8List stringByteToInt32(
  String string,
) {
  final array = string.split(",").map((e) => int.parse(e));
  return Uint8List.fromList(array.toList());
}

String getStringBytesFromIntList(Uint8List listOfBytes) {
  return listOfBytes
      .toList()
      .map((e) {
        return e.toString();
      })
      .toList()
      .join(",");
}
