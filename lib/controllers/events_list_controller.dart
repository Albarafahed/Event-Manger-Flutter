import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/event_model.dart';

class EventsListController extends GetxController {
  final RxList<EventModel> events = <EventModel>[].obs;

  // نستخدم الأسماء البرمجية (IDs) للفلترة لكي لا تتأثر بتغيير اللغة
  final List<String> tabKeys = [
    'All',
    'Meeting',
    'Party',
    'Special Occasion',
    'Other',
  ];

  // دالة لجلب الاسم المترجم لكل قسم بناءً على الـ BuildContext
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

  void setEvents(List<EventModel> list) {
    events.assignAll(list);
  }

  List<EventModel> filterByType(String type) {
    if (type == 'All') return events;
    return events.where((e) => e.type == type).toList();
  }
}
