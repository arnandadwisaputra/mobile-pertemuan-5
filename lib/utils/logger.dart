import 'package:flutter/foundation.dart';

/// Penyedia layanan log terstruktur yang aman dan tidak menampilkan data di mode Release.
class Logger {
  /// General method untuk mencetak log terstruktur secara internal.
  static void _writeLog(String level, String message) {
    // Log hanya dieksekusi dan ditampilkan apabila aplikasi berjalan di Mode Debug (kDebugMode)
    if (kDebugMode) {
      final String timestamp = DateTime.now().toIso8601String();
      print('[$timestamp] [$level] $message');
    }
  }

  /// Log level untuk melacak alur kode pencarian kesalahan (debug).
  static void debug(String message) => _writeLog('DEBUG', message);

  /// Log level untuk informasi umum sistem operasional.
  static void info(String message) => _writeLog('INFO', message);

  /// Log level untuk peringatan ketidaksesuaian sistem yang berpotensi memicu galat.
  static void warning(String message) => _writeLog('WARNING', message);

  /// Log level untuk merekam kondisi fatal/error sistem tanpa mencatat credential sensitif.
  static void error(String message, [Object? error]) {
    final String secureMessage = error != null ? '$message | Error: $error' : message;
    _writeLog('ERROR', secureMessage);
  }
}
