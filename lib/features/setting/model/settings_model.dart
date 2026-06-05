import 'package:sabalpara_family/sabalpara_family.dart';

class SettingsModel {
  final String? title;
  final String? icon;
  final VoidCallback? onTap;

  SettingsModel({this.title, this.icon, this.onTap});

  SettingsModel copyWith({String? title, String? icon, VoidCallback? onTap}) =>
      SettingsModel(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        onTap: onTap ?? this.onTap,
      );
}
