import 'package:event_manager/controllers/events_list_controller.dart';
import 'package:event_manager/core/database/db_helper.dart';
import 'package:event_manager/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
final l10n = AppLocalizations.of(Get.context!)!;
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

  final dbHelper = DbHelper();
  // الوصول للكنترولر الخاص بالقائمة لجلب بيانات التعديل

  final listController = Get.isRegistered<EventsListController>()
      ? Get.find<EventsListController>()
      : Get.put(EventsListController());

  @override
  void onInit() {
    super.onInit();

    // بدلاً من Get.find المباشر، نستخدم Get.put لضمان وجوده إذا لم يكن موجوداً

    if (listController.editingEvent != null) {
      var e = listController.editingEvent!;
      titleController.text = e.title;
      descriptionController.text = e.description;
      dateController.text = e.date;
      timeController.text = e.time;
      locationController.text = e.location;
      eventType.value = e.type;
    }
  }

  Future<void> submitEvent(Function(EventModel) onAddEvent) async {
    if (!formKey.currentState!.validate()) return;

    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    // إنشاء كائن الفعالية (مع الحفاظ على الـ ID القديم إذا كنا في وضع التعديل)
    final event = EventModel(
      id: listController.editingEvent?.id, // مهم جداً للتعديل
      userId: firebaseUser.uid,
      title: titleController.text,
      description: descriptionController.text,
      date: dateController.text,
      time: timeController.text,
      location: locationController.text,
      type: eventType.value,
    );

    try {
      if (listController.editingEvent == null) {
        // وضع الإضافة
        await dbHelper.insertEvent(event.toMap());
        Get.snackbar(l10n.success,l10n.addSuccess);
      } else {
        // وضع التعديل
        await dbHelper.updateEvent(event);
        Get.snackbar(l10n.success,l10n.updateSuccess);
      }

      onAddEvent(event);
      Get.back();
      _clearFields();
    } catch (e) {
      Get.snackbar(l10n.error,l10n.databaseSaveError);
    }
  }

  void _clearFields() {
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
