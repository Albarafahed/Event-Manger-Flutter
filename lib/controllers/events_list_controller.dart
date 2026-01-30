import 'package:event_manager/core/database/db_helper.dart';
import 'package:event_manager/l10n/app_localizations.dart';
import 'package:event_manager/views/events/create_event_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/event_model.dart';

class EventsListController extends GetxController {
  final RxList<EventModel> events = <EventModel>[].obs;
  final dbHelper = DbHelper();
  final l10n = AppLocalizations.of(Get.context!)!;
  // *** أضف هذا المتغير الجديد ***
  // هذا المتغير سيحمل بيانات الفعالية التي نريد تعديلها
  EventModel? editingEvent;

  final List<String> tabKeys = [
    'All',
    'Meeting',
    'Party',
    'Special Occasion',
    'Other'
  ];

  @override
  void onInit() {
    super.onInit();
    loadEventsFromDatabase();
  }

  Future<void> loadEventsFromDatabase() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final List<Map<String, dynamic>> data =
          await dbHelper.getEventsByUserId(user.uid);
      events.assignAll(data.map((e) => EventModel.fromMap(e)).toList());
    }
  }

  // *** دالة جديدة لتجهيز عملية التعديل والانتقال للصفحة ***
  void prepareUpdate(EventModel event) {
    editingEvent = event; // تخزين البيانات

    // الانتقال المباشر للكلاس بدلاً من الاسم
    Get.to(() => CreateEventView(
          onAddEvent: (updatedEvent) {
            loadEventsFromDatabase(); // تحديث القائمة بعد العودة
          },
        ))?.then((_) {
      editingEvent = null; // تصفير البيانات عند العودة
    });
  }

  // *** تعديل دالة الحذف لتكون أكثر أماناً ***
  Future<void> deleteEvent(int? eventId) async {
    if (eventId != null) {
      await dbHelper.deleteEvent(eventId);
      events.removeWhere((e) => e.id == eventId);
      Get.snackbar(l10n.success, l10n.deleteSuccess,
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  List<EventModel> filterByType(String type) {
    if (type == 'All') return events;
    return events.where((e) => e.type == type).toList();
  }

  String getTabName(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'All':
        return l10n.tabAll;
      case 'Meeting':
        return l10n.tabMeeting;
      case 'Party':
        return l10n.tabParty;
      case 'Special Occasion':
        return l10n.tabSpecialOccasion;
      case 'Other':
        return l10n.tabOther;
      default:
        return key;
    }
  }
}
