import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage(); // تعريف حاوية التخزين

  // مفاتيح التخزين
  final String _darkKey = 'isDarkMode';
  final String _colorKey = 'primaryColor';
  final String _fontKey = 'fontSize';
  final String _notifKey = 'notifEnabled';

  // المتغيرات التفاعلية مع جلب القيم المحفوظة مسبقاً (أو وضع قيم افتراضية)
  final _themeMode = ThemeMode.light.obs;
  final _primaryColor = Colors.deepPurple.obs;
  final _fontSize = 16.0.obs;
  final _notificationsEnabled = true.obs;

  ThemeMode get themeMode => _themeMode.value;
  MaterialColor get primaryColor => _primaryColor.value;
  double get fontSize => _fontSize.value;
  bool get notificationsEnabled => _notificationsEnabled.value;

  @override
  void onInit() {
    super.onInit();
    _loadSettings(); // تحميل الإعدادات عند بدء التشغيل
  }

  // تحميل الإعدادات من الذاكرة
  void _loadSettings() {
    // تحميل الوضع الليلي
    bool? isDark = _box.read(_darkKey);
    if (isDark != null) {
      _themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    }

    // تحميل اللون الأساسي (نخزن الـ index الخاص بـ Colors.primaries)
    int? colorIndex = _box.read(_colorKey);
    if (colorIndex != null) {
      _primaryColor.value = Colors.primaries[colorIndex];
    }

    // تحميل حجم الخط
    double? savedFont = _box.read(_fontKey);
    if (savedFont != null) {
      _fontSize.value = savedFont;
    }

    // تحميل حالة التنبيهات
    bool? notif = _box.read(_notifKey);
    if (notif != null) {
      _notificationsEnabled.value = notif;
    }
  }

  // تبديل الوضع الليلي وحفظه
  void toggleDarkMode(bool isDark) {
    _themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(_themeMode.value);
    _box.write(_darkKey, isDark);
  }

  // تغيير اللون الأساسي وحفظه
  void setPrimaryColor(MaterialColor color) {
    _primaryColor.value = color;
    // نحفظ الترتيب (index) للون لسهولة استرجاعه
    int index = Colors.primaries.indexOf(color);
    _box.write(_colorKey, index);

    // لإعادة بناء الثيم فوراً باللون الجديد
    Get.forceAppUpdate();
  }

  // تغيير حجم الخط وحفظه
  void setFontSize(double size) {
    _fontSize.value = size;
    _box.write(_fontKey, size);
  }

  // تبديل التنبيهات وحفظها
  void toggleNotifications(bool value) {
    _notificationsEnabled.value = value;
    _box.write(_notifKey, value);
  }
}
