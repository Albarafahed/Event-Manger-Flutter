import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../core/services/user_session.dart';
import '../models/user.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final box = GetStorage();
  final RxBool showPassword = false.obs;
  final RxString errorMessage = "".obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      String? savedEmail = box.read('savedEmail');
      String? savedPassword = box.read('savedPassword');

      if (emailController.text.trim() == savedEmail &&
          passwordController.text == savedPassword) {
        // حفظ الحالة في التخزين الدائم أولاً
        box.write('isLoggedIn', true);

        // تأكد من تهيئة المستخدم بشكل صحيح
        UserSession.currentUser = User(
          email: emailController.text,
          password: passwordController.text,
        );

        errorMessage.value = "";
        // استخدم التنقل بالاسم وتأكد من وجود المسار في AppRoutes
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = AppLocalizations.of(Get.context!)!.loginError;
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
