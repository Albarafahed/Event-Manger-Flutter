import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ===== دوران أيقونة =====
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              curve: Curves.linear,
              builder: (context, value, child) {
                return Transform.rotate(angle: value * 6.3, child: child);
              },
              child: const Icon(
                Icons.event_available_rounded,
                size: 100,
                color: Colors.white,
              ),
              onEnd: () {
                // إعادة الدوران بشكل ناعم
                controller.update();
              },
            ),

            const SizedBox(height: 30),

            const Text(
              "Event Manager",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Manage your events easily",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


