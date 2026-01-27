import 'package:event_manager/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var theme = ThemeModel(
    themeMode: ThemeMode.light,
    primaryColor: Colors.deepPurple,
    fontSize: 16,
    notificationsEnabled: true,
  ).obs;

  // ===== Getters =====
  ThemeMode get themeMode => theme.value.themeMode;
  MaterialColor get primaryColor => theme.value.primaryColor;
  double get fontSize => theme.value.fontSize;
  bool get notificationsEnabled => theme.value.notificationsEnabled;

  // ===== Actions =====
  void toggleDarkMode(bool isDark) {
    theme.update(
      (val) => val!.themeMode = isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void setPrimaryColor(MaterialColor color) {
    theme.update((val) => val!.primaryColor = color);
  }

  void setFontSize(double size) {
    theme.update((val) => val!.fontSize = size);
  }

  void toggleNotifications(bool enabled) {
    theme.update((val) => val!.notificationsEnabled = enabled);
  }
}
