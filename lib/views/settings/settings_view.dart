import 'package:event_manager/controllers/theme_controller.dart';
import 'package:event_manager/core/services/lang_service.dart';
import 'package:event_manager/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:event_manager/l10n/app_localizations.dart'; // استيراد الترجمة

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ThemeController controller = Get.put(ThemeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle), // ترجمة العنوان

        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) {
              TranslationService.changeLocale(locale);
            },
            itemBuilder: (context) {
              return TranslationService.locales
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(
                        TranslationService
                            .langs[TranslationService.locales.indexOf(e)],
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // ===== Dark Mode =====
            Obx(
              () => SwitchListTile(
                title: Text(l10n.darkMode), // ترجمة الوضع الليلي
                value: controller.themeMode == ThemeMode.dark,
                onChanged: controller.toggleDarkMode,
              ),
            ),
            const Divider(),

            // ===== Primary Color =====
            Obx(
              () => ListTile(
                title: Text(l10n.primaryColor), // ترجمة اللون الأساسي
                trailing: CircleAvatar(
                  backgroundColor: controller.primaryColor,
                ),
                onTap: () async {
                  MaterialColor pickedColor = controller.primaryColor;
                  await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                          l10n.pickPrimaryColor), // ترجمة عنوان اختيار اللون
                      content: BlockPicker(
                        pickerColor: pickedColor,
                        onColorChanged: (color) {
                          pickedColor = Colors.primaries.firstWhere(
                            // ignore: deprecated_member_use
                            (c) => c.value == color.value,
                            orElse: () => controller.primaryColor,
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(l10n.cancel), // ترجمة إلغاء
                        ),
                        TextButton(
                          onPressed: () {
                            controller.setPrimaryColor(pickedColor);
                            Navigator.pop(context);
                          },
                          child: Text(l10n.select), // ترجمة اختيار
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),

            // ===== Font Size =====
            Obx(() {
              double size = controller.fontSize;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(l10n.fontSize,
                        style: const TextStyle(fontSize: 16)), // ترجمة حجم الخط
                  ),
                  Slider(
                    min: 12,
                    max: 30,
                    divisions: 9,
                    label: size.toInt().toString(),
                    value: size,
                    onChanged: controller.setFontSize,
                  ),
                ],
              );
            }),
            const Divider(),

            // ===== Notifications =====
            Obx(
              () => SwitchListTile(
                title: Text(l10n.enableNotifications), // ترجمة التنبيهات
                value: controller.notificationsEnabled,
                onChanged: controller.toggleNotifications,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
