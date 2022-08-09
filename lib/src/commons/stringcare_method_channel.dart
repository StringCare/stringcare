import 'package:flutter/services.dart';

import 'stringcare_commons.dart';

abstract class StringcareMethodChannel extends StringcareCommons {
  static const MethodChannel _channel = const MethodChannel('stringcare');

  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

}
