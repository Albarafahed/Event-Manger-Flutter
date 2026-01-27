import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService {
  // اللغات المتاحة
  static final locales = [
    const Locale('en'),
    const Locale('ar'),
  ];

  // الأسماء التي تظهر في القائمة
  static final langs = [
    'English',
    'العربية',
  ];

  // دالة تغيير اللغة
  static void changeLocale(Locale locale) {
    Get.updateLocale(locale); // هذا هو السطر السحري الذي يقوم بالترجمة فوراً
  }
}
