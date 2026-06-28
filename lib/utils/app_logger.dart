import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void log(String message, {String tag = 'APP'}) {
    if (kDebugMode) {
      debugPrint('[$tag] $message');
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) debugPrint('[ERROR] $error');
      if (stackTrace != null) debugPrint('[STACKTRACE] $stackTrace');
    }
  }

  static void debug(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }
}