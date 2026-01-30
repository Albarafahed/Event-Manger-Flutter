import 'package:event_manager/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final l10n = AppLocalizations.of(Get.context!)!;
  // مراقب لحالة المستخدم (سواء كان مسجلاً أو لا)
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // ربط المتغير بحالة Firebase الحقيقية
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // --- دالة إنشاء حساب جديد ---
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAllNamed('/home'); // الانتقال للرئيسية بعد النجاح
    } on FirebaseAuthException catch (e) {
      Get.snackbar(l10n.createError, e.message ?? l10n.somethingWentWrong,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // --- دالة تسجيل الدخول ---
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          l10n.loginErrorTitle, // "خطأ في الدخول"
          l10n.invalidCredentials, // "البريد أو كلمة المرور غير صحيحة",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // --- تسجيل الخروج ---
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
