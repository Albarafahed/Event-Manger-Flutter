import 'package:event_manager/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:event_manager/l10n/app_localizations.dart'; // استيراد الترجمة

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        break;

      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/settings',
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // تعريف متغير الترجمة
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: l10n.homeTitle, // استخدام ترجمة "Home"
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: l10n.settingsTitle, // استخدام ترجمة "Settings"
        ),
      ],
    );
  }
}
