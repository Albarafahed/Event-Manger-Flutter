import 'package:flutter/material.dart';

class ThemeModel {
  ThemeMode themeMode;
  MaterialColor primaryColor;
  double fontSize;
  bool notificationsEnabled;

  ThemeModel({
    required this.themeMode,
    required this.primaryColor,
    required this.fontSize,
    required this.notificationsEnabled,
  });

  ThemeModel copyWith({
    ThemeMode? themeMode,
    MaterialColor? primaryColor,
    double? fontSize,
    bool? notificationsEnabled,
  }) {
    return ThemeModel(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      fontSize: fontSize ?? this.fontSize,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
