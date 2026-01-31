import 'package:event_manager/controllers/theme_controller.dart';
import 'package:event_manager/firebase_options.dart';
import 'package:event_manager/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  // الخطوة 1: التأكد من تهيئة Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // الخطوة 2: تهيئة Firebase (بدونها سيظهر الخطأ الذي تراه)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  final box = GetStorage();
  MyApp({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return Obx(() {
  //     final theme = themeController.theme.value;
  //     return GetMaterialApp(
  //       localizationsDelegates: AppLocalizations.localizationsDelegates,
  //       supportedLocales: AppLocalizations.supportedLocales,
  //       locale: const Locale('ar'),
  //       debugShowCheckedModeBanner: false,
  //       title: "Event Manager",
  //       themeMode: theme.themeMode,
  //       theme: ThemeData(
  //         primarySwatch: theme.primaryColor,
  //         scaffoldBackgroundColor: Colors.deepPurple[50],
  //         appBarTheme: AppBarTheme(
  //           backgroundColor: theme.primaryColor,
  //           centerTitle: true,
  //           elevation: 2,
  //           titleTextStyle: TextStyle(
  //             fontSize: 20 * (theme.fontSize / 16),
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //         elevatedButtonTheme: ElevatedButtonThemeData(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: theme.primaryColor,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //           ),
  //         ),
  //         inputDecorationTheme: InputDecorationTheme(
  //           filled: true,
  //           fillColor: Colors.white,
  //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(16),
  //             borderSide: BorderSide(color: theme.primaryColor, width: 2),
  //           ),
  //         ),
  //       ),
  //       darkTheme: ThemeData(
  //         brightness: Brightness.dark,
  //         primaryColor: theme.primaryColor,
  //         scaffoldBackgroundColor: Colors.grey[900],
  //       ),
  //       initialRoute: AppRoutes.splash,
  //       routes: AppRoutes.routes,
  //     );
  //   });
  // }

  Widget build(BuildContext context) {
    return Obx(() {
      // جلب القيم مباشرة من الـ controller لضمان التحديث اللحظي
      final ThemeMode currentMode = themeController.themeMode;
      final MaterialColor primaryColor = themeController.primaryColor;
      final double fontSizeFactor = themeController.fontSize /
          16; // معامل القياس بناءً على الحجم الافتراضي

      return GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // ملاحظة: يفضل جعل الـ locale ديناميكي أيضاً إذا كنت تستخدم TranslationService
        locale: Get.locale ?? const Locale('ar'),
        debugShowCheckedModeBanner: false,
        title: "Event Manager",

        // ربط وضع الثيم (Light/Dark) المحفوظ
        themeMode: currentMode,

        // ===== الثيم الفاتح (Light Theme) =====
        theme: ThemeData(
          useMaterial3: true, // تفعيل Material 3 يعطي شكلاً أحدث
          primarySwatch: primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          scaffoldBackgroundColor: Colors.deepPurple[50],

          // تطبيق حجم الخط الديناميكي على كامل التطبيق
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 16 * fontSizeFactor),
            bodyMedium: TextStyle(fontSize: 14 * fontSizeFactor),
            titleLarge: TextStyle(
                fontSize: 22 * fontSizeFactor, fontWeight: FontWeight.bold),
          ),

          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            centerTitle: true,
            elevation: 2,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              fontSize: 20 * fontSizeFactor,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white, // لون النص داخل الزر
              textStyle: TextStyle(fontSize: 16 * fontSizeFactor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
        ),

        // ===== الثيم المظلم (Dark Theme) =====
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: Colors.grey[900],
          // تطبيق نفس منطق الخطوط للوضع المظلم
          textTheme: TextTheme(
            bodyLarge:
                TextStyle(fontSize: 16 * fontSizeFactor, color: Colors.white),
            bodyMedium: TextStyle(
                fontSize: 14 * fontSizeFactor, color: Colors.grey[300]),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[850],
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20 * fontSizeFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        initialRoute: AppRoutes.splash,
        routes: AppRoutes
            .routes, // إذا كنت تستخدم GetX يفضل استخدام getPages بدلاً من routes
      );
    });
  }
}
