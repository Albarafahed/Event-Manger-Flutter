import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// استيراد ملف الترجمة المولّد تلقائياً
import '../../controllers/signup_controller.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    // تعريف متغير الترجمة
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      // استخدام l10n.signUpButton أو l10n.registerTitle للعنوان
      appBar: AppBar(title: Text(l10n.signUpButton), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),

              // ===== Icon =====
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple[100],
                ),
                child: const Icon(
                  Icons.person_add_alt_1,
                  size: 80,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                l10n.createAccount, // ترجمة "Create Account"
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 32),

              // ===== Email =====
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  l10n.emailLabel, // ترجمة "Email" من Login
                  l10n.emailHint, // ترجمة "Enter your email" من Login
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
                    l10n.passwordLabel, // ترجمة "Password"
                    l10n.passwordHint, // ترجمة "Enter your password"
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

              // ===== Register Button =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.signUpButton, // ترجمة "Sign Up" أو "Register"
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== Registered Users =====
              Obx(
                () => controller.users.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.registeredUsers, // ترجمة "Registered Users"
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.users.length,
                            itemBuilder: (context, index) {
                              final user = controller.users[index];
                              return Card(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.person,
                                    color: Colors.deepPurple,
                                  ),
                                  title: Text(user.email),
                                  subtitle: Text(
                                    "${l10n.passwordLabel}: ${'*' * user.password.length}", // ترجمة "Password"
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.accountText), // استخدام الترجمة
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed('/login');
                    },
                    child: Text(
                      l10n.loginButton, // استخدام الترجمة
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
