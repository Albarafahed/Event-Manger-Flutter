import 'package:event_manager/core/database/db_helper.dart';
import 'package:event_manager/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../core/services/user_session.dart';
import '../models/user.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dbHelper = DbHelper();
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();
  final RxBool showPassword = false.obs;
  final RxString errorMessage = "".obs;
  final l10n = AppLocalizations.of(Get.context!)!;
  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  //         "مرحباً بك",
  //         userMap['email'],
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //       );
  //     } else {
  //       // 4. إذا لم يوجد المستخدم أو البيانات خاطئة
  //       errorMessage.value = AppLocalizations.of(Get.context!)!.loginError;
  //     }
  //   }
  // }

  void login() async {
    final ln10 = AppLocalizations.of(Get.context!)!;
    if (formKey.currentState!.validate()) {
      try {
        // 1. تسجيل الدخول عبر Firebase
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        if (userCredential.user != null) {
          // 2. حفظ حالة الجلسة (نستخدم UID الخاص بـ Firebase الآن)
          box.write('isLoggedIn', true);
          box.write('current_user_uid', userCredential.user!.uid);

          // 3. تحديث كائن المستخدم في الجلسة الحالية
          UserSession.currentUser = User(
            id: userCredential.user!.uid, // استخدم UID هنا كمعرف نصي
            email: userCredential.user!.email!,
            password:
                passwordController.text, // كلمة المرور لا تُسترجع من فايربيس
          );

          errorMessage.value = "";
          Get.offAllNamed('/home');

          Get.snackbar(
            ln10.welcomeUser,
            userCredential.user!.email!,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
        // ignore: unused_catch_clause
      } on FirebaseAuthException catch (e) {
        final currentL10n = AppLocalizations.of(Get.context!)!;
        // رسالة خطأ في حال كانت البيانات غير صحيحة
        // errorMessage.value = AppLocalizations.of(Get.context!)!.loginError;
        Get.snackbar(
          currentL10n.loginFailed,
          currentL10n.invalidLogin,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
