import 'dart:convert';
import 'dart:developer';

import 'package:dio/src/options.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/error_logger.dart';

class APILogger extends ParseErrorLogger {
  static const int _defaultPadding = 3;

  void printSuccessLog({
    required dynamic responseBody,
    required dynamic parameters,
    required String? url,
    required String? token,
    required String? apiMethod,
    Map header = const {},
    String? requestTime,
    bool isRequest = true,
    int spacerLines = _defaultPadding,
  }) {
    final apiType = isRequest ? 'REQUEST' : 'RESPONSE';
    final data = '${">" * 40} $apiType ${"<" * 40}\n'
        ' Method        - $apiMethod\n'
        ' Request URL   - $url\n'
        ' UTC Time      - ${DateTime.now()}\n'
        ' Authentication Token - $token\n'
        ' X-Request-Timestamp - $requestTime\n'
        ' Parameters    - ${prettyJson(parameters)}\n'
        'Header - $header\n'
        ' Body - ${prettyJson(responseBody)}\n'
        '${"-" * 100}\n';

    if (kDebugMode) {
      log(data.padLeft(3, ' ').padRight(3, ' '));
    }
  }

  void printErrorLog({
    required dynamic responseBody,
    required dynamic parameters,
    required String? url,
    required String? token,
    required String? errorString,
    required int statusCode,
    String? deviceId,
    String? requestTime,
    int spacerLines = _defaultPadding,
  }) {
    final data = '${">" * 40} REQUEST ${"<" * 40} \n'
        'Request URL   - $url\n'
        'UTC Time      - ${DateTime.now()}\n'
        'Authentication Token - $token\n'
        'Device ID - $deviceId\n'
        'X-Request-Timestamp - $requestTime\n'
        'Parameters    - ${prettyJson(parameters)}\n'
        'Body - ${prettyJson(responseBody)}\n'
        '----------ERROR----------\n'
        'Status Code - $statusCode\n'
        'Message     - $errorString\n'
        '${"-" * 100}\n';

    if (kDebugMode) {
      log(data.padLeft(3, ' ').padRight(3, ' '));
    }
  }

  String prettyJson(dynamic json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(label: s.toString());
    }
    return '';
  }

  @override
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    Logger().e(
      'Error in Parsing response message',
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }
}
