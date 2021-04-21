import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

Pointer<Int32> dataToInt32(
  Uint8List value,
) {
  var list = value.toList();
  final Pointer<Int32> result = malloc<Int32>(list.length);
  final Int32List nativeArray = result.asTypedList(list.length);
  nativeArray.setAll(0, list);
  return result;
}

Pointer<Int32> stringToInt32(
  String string,
) {
  final units = utf8.encode(string);
  final Pointer<Int32> result = malloc<Int32>(units.length);
  final Int32List nativeArray = result.asTypedList(units.length);
  nativeArray.setAll(0, units);
  return result;
}

Pointer<Int32> stringByteToInt32(
  String string,
) {
  final array = string.split(",").map((e) => int.parse(e));
  final Pointer<Int32> result = malloc<Int32>(array.length);
  final Int32List nativeArray = result.asTypedList(array.length);
  nativeArray.setAll(0, array);
  return result;
}

Uint8List getBytesFromIntList(Pointer<Int32> listOfBytes, int size) {
  return Uint8List.fromList(listOfBytes.asTypedList(size).toList());
}

String getStringFromUtf8List(Pointer<Utf8> listOfBytes) {
  return listOfBytes.toDartString();
}

String getStringFromRevealed(Pointer<Int32> listOfBytes, int size) {
  var list = listOfBytes.asTypedList(size).toList();
  return utf8.decode(list.sublist(0, size), allowMalformed: true);
}

String getStringBytesFromIntList(Pointer<Int32> listOfBytes, int size) {
  return listOfBytes
      .asTypedList(size)
      .toList()
      .map((e) {
        return e.toString();
      })
      .toList()
      .join(",");
}
