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
  // الخطوة 1: التأكد من تهيئة Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // الخطوة 2: تهيئة Firebase (بدونها سيظهر الخطأ الذي تراه)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  final box = GetStorage();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = themeController.theme.value;
      return GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        title: "Event Manager",
        themeMode: theme.themeMode,
        theme: ThemeData(
          primarySwatch: theme.primaryColor,
          scaffoldBackgroundColor: Colors.deepPurple[50],
          appBarTheme: AppBarTheme(
            backgroundColor: theme.primaryColor,
            centerTitle: true,
            elevation: 2,
            titleTextStyle: TextStyle(
              fontSize: 20 * (theme.fontSize / 16),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
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
              borderSide: BorderSide(color: theme.primaryColor, width: 2),
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: theme.primaryColor,
          scaffoldBackgroundColor: Colors.grey[900],
        ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      );
    });
  }
}
