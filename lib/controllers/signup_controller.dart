// ignore_for_file: unused_element

import 'package:event_manager/core/database/db_helper.dart';
import 'package:event_manager/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final dbHelper = DbHelper();
  final RxBool showPassword = false.obs;
  final RxList<User> users = <User>[].obs;
final l10n = AppLocalizations.of(Get.context!)!;
  void togglePassword() {
    showPassword.value = !showPassword.value;
  }
Future<void> register() async {
  if (formKey.currentState!.validate()) {
    try {
      // 1. إنشاء الحساب في Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // 2. (اختياري) يمكنك أيضاً حفظ الـ uid في SQFlite إذا أردت استخدامه محلياً
      if (userCredential.user != null) {
        Get.snackbar(
          AppLocalizations.of(Get.context!)!.successTitle,
          AppLocalizations.of(Get.context!)!.signupSuccess,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed('/login');
      }
    } on FirebaseAuthException catch (e) {
      // التعامل مع أخطاء Firebase (مثل: الإيميل مستخدم مسبقاً)
      String errorMsg = l10n.somethingWentWrong;
      if (e.code == 'email-already-in-use') errorMsg = l10n.emailAlreadyInUse;
      
      Get.snackbar(l10n.error, errorMsg,
          backgroundColor: Colors.red, colorText: Colors.white);
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
