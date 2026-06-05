import 'dart:math';

import 'package:sabalpara_family/sabalpara_family.dart';

class AppColors {
  static const Color primary = Color(0xFF8349E5);
  static const Color text = Color(0xFF15161A);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFA5753);
  static const Color green = Color(0xFF149C68);
  static const Color grey = Color(0xFF5C5F68);
  static const Color skyBlue = Color(0xFF65B4FF);
  static const Color peach = Color(0xFFFFA565);
  static const Color goldenYellow = Color(0xFFFFD265);

  ///
  static MaterialColor generateMaterialColor() {
    return MaterialColor(primary.hashCode, {
      50: tintColor(primary, 0.9),
      100: tintColor(primary, 0.8),
      200: tintColor(primary, 0.6),
      300: tintColor(primary, 0.4),
      400: tintColor(primary, 0.2),
      500: primary,
      600: shadeColor(primary, 0.1),
      700: shadeColor(primary, 0.2),
      800: shadeColor(primary, 0.3),
      900: shadeColor(primary, 0.4),
    });
  }

  static int tintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static Color tintColor(Color color, double factor) {
    return Color.fromARGB(
      _extractAlpha(color),
      _adjustTintValue(_extractRed(color), factor),
      _adjustTintValue(_extractGreen(color), factor),
      _adjustTintValue(_extractBlue(color), factor),
    );
  }

  static int shadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  static Color shadeColor(Color color, double factor) {
    return Color.fromARGB(
      _extractAlpha(color),
      _adjustShadeValue(_extractRed(color), factor),
      _adjustShadeValue(_extractGreen(color), factor),
      _adjustShadeValue(_extractBlue(color), factor),
    );
  }

  static int _extractAlpha(Color color) => (color.hashCode >> 24) & 0xFF;

  static int _adjustTintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static int _adjustShadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  static int _extractRed(Color color) => (color.hashCode >> 16) & 0xFF;

  static int _extractGreen(Color color) => (color.hashCode >> 8) & 0xFF;

  static int _extractBlue(Color color) => color.hashCode & 0xFF;

  /// THEME DATA
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    primarySwatch: generateMaterialColor(),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    useMaterial3: true,
    fontFamily: AppAssets.mulish,
    scaffoldBackgroundColor: white,
  );
}
