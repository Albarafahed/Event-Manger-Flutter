import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/event_model.dart';

class CreateEventController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();

  final RxString eventType = "Other".obs;

  final List<String> eventTypes = [
    "Meeting",
    "Party",
    "Special Occasion",
    "Other",
  ];

  // ===== Date Picker =====
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  // ===== Time Picker =====
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // ignore: use_build_context_synchronously
      timeController.text = pickedTime.format(context);
    }
  }

  // ===== Submit Event =====
  void submitEvent(Function(EventModel) onAddEvent) {
    if (!formKey.currentState!.validate()) return;

    final event = EventModel(
      title: titleController.text,
      description: descriptionController.text,
      date: dateController.text,
      time: timeController.text,
      location: locationController.text,
      type: eventType.value,
    );

    onAddEvent(event);

    // ✅ رسالة نجاح
    Get.snackbar(
      AppLocalizations.of(Get.context!)!.successTitle,
      AppLocalizations.of(Get.context!)!.createEventSuccess,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // ✅ تصفير الحقول
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
    locationController.clear();
    eventType.value = "Other";
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
