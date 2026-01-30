import 'package:event_manager/core/services/lang_service.dart';
import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// تأكد من استيراد ملف التوليد التلقائي

import '../../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // تعريف متغير للوصول للترجمة بسهولة داخل هذه الـ Widget
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.loginButton),
        actions: [
          const SizedBox(width: 48)
        ], // حجز مساحة فقط لكي لا يغطي العنوان الزر
        flexibleSpace: Stack(
          children: [
            Positioned(
              // لتثبيت الزر في جهة اليمين دائماً بغض النظر عن اللغة
              right: 10,
              top: MediaQuery.of(context).padding.top +
                  10, // لضبط مكانه تحت شريط الحالة
              child: Directionality(
                textDirection:
                    TextDirection.ltr, // لضمان ظهور القائمة المنسدلة بشكل صحيح
                child: PopupMenuButton<Locale>(
                  icon: const Icon(Icons.language, color: Colors.white),
                  onSelected: (locale) {
                    TranslationService.changeLocale(locale);
                  },
                  itemBuilder: (context) {
                    return TranslationService.locales.map((e) {
                      int index = TranslationService.locales.indexOf(e);
                      return PopupMenuItem(
                        value: e,
                        child: Text(TranslationService.langs[index]),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===== Icon =====
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple[100],
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    size: 80,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  l10n.welcomeBack, // استخدام الترجمة
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  l10n.loginToContinue, // استخدام الترجمة
                  style: const TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 32),

                // ===== Email =====
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration(
                    l10n.emailLabel, // ترجمة العنوان
                    l10n.emailHint, // ترجمة التلميح
                    Icons.email,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.emailEmptyError; // ترجمة الخطأ
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return l10n.emailInvalidError; // ترجمة الخطأ
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ===== Password =====
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: !controller.showPassword.value,
                    decoration: _inputDecoration(
                      l10n.passwordLabel, // ترجمة العنوان
                      l10n.passwordHint, // ترجمة التلميح
                      Icons.lock,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.deepPurple,
                        ),
                        onPressed: controller.togglePassword,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.passwordEmptyError; // ترجمة الخطأ
                      }
                      if (value.length < 7) {
                        return l10n.passwordLengthError; // ترجمة الخطأ
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // ===== Error (من الكنترولر) =====
                Obx(
                  () => controller.errorMessage.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // ===== Login Button =====
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: controller.login,
                    child: Text(
                      l10n.loginButton, // استخدام الترجمة
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ===== Sign Up =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.noAccountText), // استخدام الترجمة
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed('/sign-up');
                      },
                      child: Text(
                        l10n.signUpText, // استخدام الترجمة
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      ),
    );
  }
}
