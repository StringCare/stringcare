import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stringcare/src/native/stringcare_impl.dart' as native;
import 'package:stringcare/src/web/stringcare_impl.dart' as web;
import 'package:stringcare/stringcare.dart';

void main() {
  const MethodChannel channel = MethodChannel('stringcare');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    var nativeImpl = native.StringcareImpl();
    var webImpl = web.StringcareImpl();
    print("nativeImpl sign: " + nativeImpl.testSign([]));
    print("webImpl sign: " + webImpl.testSign([]));
    expect(await Stringcare.platformVersion, '42');
  });

  test('init hash match', () async {
    var nativeImpl = native.StringcareImpl();
    var webImpl = web.StringcareImpl();
    var nHash = nativeImpl.testHash([]);
    var wHash = webImpl.testHash([]);
    print("native hash: $nHash");
    print("web hash: $wHash");
    expect(nHash, wHash);
  });

  test('sign match', () async {
    var nativeImpl = native.StringcareImpl();
    var webImpl = web.StringcareImpl();
    var nSign = nativeImpl.testSign([]);
    var wSign = webImpl.testSign([]);
    print("native sign: $nSign");
    print("web sign: $wSign");
    expect(nSign, wSign);
  });
}
