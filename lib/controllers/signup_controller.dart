import 'package:event_manager/l10n/app_localizations.dart' show AppLocalizations;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();
  final RxBool showPassword = false.obs;
  final RxList<User> users = <User>[].obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void register() {
    if (formKey.currentState!.validate()) {
      box.write('savedEmail', emailController.text.trim());
      box.write('savedPassword', passwordController.text);

      // Get.snackbar("Success", "Account registered successfully!");
      // Get.offAllNamed('/login'); // العودة للدخول

     Get.snackbar(
        AppLocalizations.of(Get.context!)!.successTitle,
        AppLocalizations.of(Get.context!)!.signupSuccess,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        
      );

      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
