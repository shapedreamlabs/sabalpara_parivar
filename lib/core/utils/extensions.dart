import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

extension DateTimeFormat on DateTime {
  String formatDateFromDateTime() {
    final formattedDate = DateFormat('dd MMM yyyy').format(this);
    return formattedDate;
  }

  String get formateDateTimeToAgo {
    if (isToday) {
      return "Today, $toHhMmA";
    } else if (isYesterday) {
      return "Yesterday, $toHhMmA";
    } else {
      final difference = DateTime.now().difference(this);
      if (difference.inDays <= 1) {
        return "${difference.inDays} days ago, $toHhMmA";
      } else {
        return "$toDdMmYyyy, $toHhMmA";
      }
    }
  }

  bool get isToday {
    return isSameDay(.now(), this);
  }

  bool get isYesterday {
    return isSameDay(.now().subtract(Duration(days: 1)), this);
  }
}

extension ValidationExt on String {
  bool isEmailValid() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }

  bool isPhoneValid() {
    return RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)").hasMatch(this);
  }
}

extension StringFormatingExt on String {
  double? get tryDouble {
    try {
      final value = double.tryParse(this);
      if (value != null && !value.isNaN) {
        return value;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Map? get tryMap {
    try {
      return jsonDecode(this);
    } catch (e) {
      return null;
    }
  }

  Color? get tryColor {
    try {
      return Color(int.parse(replaceAll("#", "0xFF")));
    } catch (e) {
      return null;
    }
  }

  String? get tryGetFontName {
    try {
      return split("_").first;
    } catch (e) {
      return null;
    }
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension IntFormatingExt on int {
  Color get toResultIndexedColor {
    final colorList = [
      AppColors.skyBlue,
      AppColors.peach,
      AppColors.goldenYellow,
    ];
    return colorList[this % colorList.length];
  }
}

extension NumFormatingExt on num {
  String? get toAmount {
    try {
      final formatter = NumberFormat('#,##,###');
      return formatter.format(this);
    } catch (e) {
      return null;
    }
  }

  String? get toDuration {
    try {
      return "${(this / 60).floor().toString().padLeft(2, '0')}:${(this % 60).floor().toString().padLeft(2, '0')}";
    } catch (e) {
      return null;
    }
  }
}

extension DateFormatingExt on DateTime {
  String? get toDdMmYyyy {
    try {
      return DateFormat("dd/MM/yyyy").format(this);
    } catch (e) {
      return null;
    }
  }

  String? get toDdMmmYyyy {
    try {
      return DateFormat("dd MMM, yyyy").format(this);
    } catch (e) {
      return null;
    }
  }

  String? get toDdMmmmYyyy {
    try {
      return DateFormat("dd MMMM yyyy").format(this);
    } catch (e) {
      return null;
    }
  }

  String? get toMmmDdYyyy {
    try {
      return DateFormat("MMM dd, yyyy").format(this);
    } catch (e) {
      return null;
    }
  }

  String? get toDdMmYyyyWithDash {
    try {
      return DateFormat("dd-MM-yyyy").format(this);
    } catch (e) {
      return null;
    }
  }

  String? get toHhMmA {
    try {
      return DateFormat("hh:mm a").format(this);
    } catch (e) {
      return null;
    }
  }
}

extension NavigatorExtention on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);

  NavigatorState get navigator => Navigator.of(this);

  Object? get args => ModalRoute.of(this)?.settings.arguments;
}

extension NumUtils on num {
  Duration get milliseconds => Duration(
    microseconds: (this * Duration.microsecondsPerMillisecond).round(),
  );

  Duration get seconds =>
      Duration(milliseconds: (this * Duration.millisecondsPerSecond).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());
}

extension SpaceExtention on num {
  /// Vertical Space
  Widget get spaceVertical => SizedBox(height: toDouble());

  /// Horizontal Space
  Widget get spaceHorizontal => SizedBox(width: toDouble());
}

/// IterableExtension
extension IterableExtension<T> on Iterable<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

/// DoubleExtension
extension DoubleExtension on double {
  /// prettify
  String get prettify => toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
}

extension FileExtension on File {
  /// get File Extension
  String get getExtension {
    final List<String> list = path.split(".");
    if (list.isNotEmpty) {
      return list.last;
    }
    return "jpg";
  }

  /// get File Name
  String? get getName {
    final List<String> list = path.split("/");
    if (list.isNotEmpty) {
      return list.last;
    }
    return null;
  }
}

extension ColorExtension on Color {
  String get toHex => '#${toARGB32().toRadixString(16).padLeft(6, '0')}';
}
