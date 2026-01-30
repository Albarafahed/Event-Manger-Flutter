import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/create_event_controller.dart';
import '../../controllers/events_list_controller.dart';
import '../../models/event_model.dart';

class CreateEventView extends StatelessWidget {
  final Function(EventModel) onAddEvent;

  const CreateEventView({super.key, required this.onAddEvent});

  @override
  Widget build(BuildContext context) {
    // تعريف متغير الترجمة
    final l10n = AppLocalizations.of(context)!;

    // استدعاء الكنترولر الخاص بالصفحة
    final controller = Get.put(CreateEventController());

    // التحقق من وجود فعالية قيد التعديل
    final listController = Get.find<EventsListController>();
    final isEdit = listController.editingEvent != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? l10n.editEvent : l10n.createEventTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey, // مفتاح التحقق
          child: Column(
            children: [
              _field(
                controller: controller.titleController,
                label: l10n.eventTitleLabel,
                icon: Icons.title,
                context: context,
              ),
              _field(
                controller: controller.descriptionController,
                label: l10n.eventDescriptionLabel,
                icon: Icons.description,
                context: context,
              ),
              _dateField(controller, context),
              _timeField(controller, context),
              _field(
                controller: controller.locationController,
                label: l10n.eventLocationLabel,
                icon: Icons.location_on,
                context: context,
              ),

              // ===== Dropdown مع التحقق =====
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue: controller.eventType.value.isEmpty
                      ? null
                      : controller.eventType.value,
                  decoration: InputDecoration(
                    labelText: l10n.eventTypeLabel,
                    prefixIcon: const Icon(Icons.category),
                  ),
                  items: controller.eventTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) => controller.eventType.value = value!,
                  validator: (value) =>
                      value == null ? l10n.selectEventTypeHint : null,
                ),
              ),

              const SizedBox(height: 32),

              // ===== زر الحفظ / التحديث مع الـ Validation =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEdit ? Colors.orange : null,
                  ),
                  onPressed: () {
                    // التحقق من صحة المدخلات قبل الاستمرار
                    if (controller.formKey.currentState!.validate()) {
                      controller.submitEvent(onAddEvent);

                      Get.back(); // العودة للخلف

                      // تنبيه المستخدم بالنجاح بناءً على الحالة
                      Get.snackbar(
                        l10n.success,
                        isEdit ? l10n.updateSuccess : l10n.addSuccess,
                        backgroundColor: isEdit
                            // ignore: deprecated_member_use
                            ? Colors.orange.withOpacity(0.8)
                            // ignore: deprecated_member_use
                            : Colors.green.withOpacity(0.8),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Text(
                    isEdit ? l10n.updateButton : l10n.addEventButton,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Methods ---

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required BuildContext context,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value == null || value.trim().isEmpty
            ? "$label ${l10n.fieldCannotBeEmpty}"
            : null,
      ),
    );
  }

  Widget _dateField(CreateEventController controller, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _pickerField(
      controller: controller.dateController,
      label: l10n.eventDateLabel,
      icon: Icons.date_range,
      onTap: () => controller.selectDate(context),
      context: context,
    );
  }

  Widget _timeField(CreateEventController controller, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _pickerField(
      controller: controller.timeController,
      label: l10n.eventTimeLabel,
      icon: Icons.access_time,
      onTap: () => controller.selectTime(context),
      context: context,
    );
  }

  Widget _pickerField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value == null || value.isEmpty
            ? "$label ${l10n.fieldCannotBeEmpty}"
            : null,
      ),
    );
  }
}
