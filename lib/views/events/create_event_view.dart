import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/create_event_controller.dart';
import '../../models/event_model.dart';

class CreateEventView extends StatelessWidget {
  final Function(EventModel) onAddEvent;

  const CreateEventView({super.key, required this.onAddEvent});

  @override
  Widget build(BuildContext context) {
    // تعريف متغير الترجمة
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(CreateEventController());

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createEventTitle)), // ترجمة العنوان
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              _field(
                controller: controller.titleController,
                label: l10n.eventTitleLabel, // ترجمة "العنوان"
                icon: Icons.title,
                context: context,
              ),
              _field(
                controller: controller.descriptionController,
                label: l10n.eventDescriptionLabel, // ترجمة "الوصف"
                icon: Icons.description,
                context: context,
              ),
              _dateField(controller, context),
              _timeField(controller, context),
              _field(
                controller: controller.locationController,
                label: l10n.eventLocationLabel, // ترجمة "الموقع"
                icon: Icons.location_on,
                context: context,
              ),

              // ===== Dropdown =====
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue: controller.eventType.value.isEmpty
                      ? null
                      : controller.eventType.value,
                  decoration: InputDecoration(
                    labelText: l10n.eventTypeLabel, // ترجمة "نوع الفعالية"
                    prefixIcon: const Icon(Icons.category),
                  ),
                  items: controller.eventTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (value) => controller.eventType.value = value!,
                  validator: (value) =>
                      value == null ? l10n.selectEventTypeHint : null,
                ),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.submitEvent(onAddEvent),
                  child: Text(
                    l10n.addEventButton, // ترجمة زر الإضافة
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

  // تعديل الـ helper methods لدعم الترجمة
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
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
        validator: (value) => value == null || value.isEmpty
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
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
        validator: (value) => value == null || value.isEmpty
            ? "$label ${l10n.fieldCannotBeEmpty}"
            : null,
      ),
    );
  }
}
