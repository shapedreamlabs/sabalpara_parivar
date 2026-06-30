import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class PrefService {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e, stack) {
      await CrashlyticsService.recordError(CrashArea.database, e, stack);
      rethrow;
    }
  }

  static Future<bool> set(String key, dynamic value) async {
    try {
      if (value is int) {
        return prefs.setInt(key, value);
      } else if (value is double) {
        return prefs.setDouble(key, value);
      } else if (value is String) {
        return prefs.setString(key, value);
      } else if (value is bool) {
        return prefs.setBool(key, value);
      } else if (value is List<String>) {
        return prefs.setStringList(key, value);
      }
      return false;
    } catch (e, stack) {
      await CrashlyticsService.recordError(
        CrashArea.database,
        e,
        stack,
        info: {'key': key},
      );
      rethrow;
    }
  }

  static int getInt(String key) {
    return prefs.getInt(key) ?? 0;
  }

  static double getDouble(String key) {
    return prefs.getDouble(key) ?? 0;
  }

  static String getString(String key) {
    return prefs.getString(key) ?? '';
  }

  static bool getBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  static List<String> getStringList(String key) {
    return prefs.getStringList(key) ?? [];
  }

  static Future<bool> removeKey(String key) async {
    try {
      return await prefs.remove(key);
    } catch (e, stack) {
      await CrashlyticsService.recordError(
        CrashArea.database,
        e,
        stack,
        info: {'key': key},
      );
      rethrow;
    }
  }

  static Future<bool> clear() async {
    try {
      return await prefs.clear();
    } catch (e, stack) {
      await CrashlyticsService.recordError(CrashArea.database, e, stack);
      rethrow;
    }
  }
}
