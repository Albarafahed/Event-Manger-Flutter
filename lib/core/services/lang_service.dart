// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TranslationService {
//   // اللغات المتاحة
//   static final locales = [
//     const Locale('en'),
//     const Locale('ar'),
//   ];

//   // الأسماء التي تظهر في القائمة
//   static final langs = [
//     'English',
//     'العربية',
//   ];

//   // دالة تغيير اللغة
//   static void changeLocale(Locale locale) {
//     Get.updateLocale(locale); // هذا هو السطر السحري الذي يقوم بالترجمة فوراً
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService {
  // اللغات المتاحة (Locale)
  static final locales = [
    const Locale('en'), // الإنجليزية
    const Locale('ar'), // العربية
    const Locale('fr'), // الفرنسية
    const Locale('tr'), // التركية
    const Locale('zh'), // الصينية
  ];

  // الأسماء مع الأعلام لتظهر في القائمة بشكل أجمل
  static final langs = [
    'English 🇺🇸',
    'العربية 🇾🇪',
    'Français 🇫🇷',
    'Türkçe 🇹🇷',
    '中文 🇨🇳',
  ];

  // دالة تغيير اللغة
  static void changeLocale(Locale langName) {
    final index = locales.indexOf(langName);
    if (index != -1) {
      Get.updateLocale(locales[index]);
      // يمكنك هنا حفظ اللغة المختارة في GetStorage لتبقى ثابتة عند إعادة تشغيل التطبيق
    }
  }
}
