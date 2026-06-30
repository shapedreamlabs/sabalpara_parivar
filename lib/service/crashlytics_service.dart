import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

enum CrashArea {
  api,
  database,
  firebase,
  payment,
  fileTransfer,
  mediaPicker,
  businessLogic,
}

class CrashlyticsService {
  CrashlyticsService._();

  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  static Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  static Future<void> recordError(
    CrashArea area,
    dynamic error,
    StackTrace? stackTrace, {
    bool fatal = false,
    Map<String, String>? info,
  }) async {
    if (kDebugMode || !_shouldReport(error)) {
      return;
    }

    await _crashlytics.setCustomKey('crash_area', area.name);

    if (info != null) {
      for (final entry in info.entries) {
        await _crashlytics.setCustomKey(entry.key, entry.value);
      }
    }

    await _crashlytics.recordError(
      error,
      stackTrace,
      reason: area.name,
      fatal: fatal,
    );
  }

  static Future<void> log(String message) async {
    if (kDebugMode) return;
    await _crashlytics.log(message);
  }

  static bool _shouldReport(dynamic error) {
    if (error is AppException) {
      return false;
    }

    if (error is DioException) {
      if (error.type == DioExceptionType.cancel) {
        return false;
      }

      final statusCode = error.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        return false;
      }

      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return false;
      }

      final wrappedError = error.error;
      if (wrappedError is AppException) {
        return false;
      }
    }

    return true;
  }
}
