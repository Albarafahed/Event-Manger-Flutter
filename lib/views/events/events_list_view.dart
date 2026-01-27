import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/events_list_controller.dart';
import '../../models/event_model.dart';

class EventsListView extends StatelessWidget {
  final List<EventModel> events;

  const EventsListView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(EventsListController());
    controller.setEvents(events);

    return DefaultTabController(
      // نستخدم طول قائمة tabKeys من الكنترولر
      length: controller.tabKeys.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.eventsTitle),
          bottom: TabBar(
            isScrollable: true,
            // نستخدم tabKeys ونحولها لأسماء مترجمة عبر دالة getTabName
            tabs: controller.tabKeys.map((key) {
              return Tab(text: controller.getTabName(context, key));
            }).toList(),
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.white,

            labelColor: const Color.fromARGB(255, 183, 58, 58),

            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          // نمرر الـ key الأصلي للفلترة لضمان دقة البيانات
          children: controller.tabKeys
              .map(
                (key) => Obx(
                    () => _buildList(context, controller.filterByType(key))),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<EventModel> list) {
    final l10n = AppLocalizations.of(context)!;

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_busy, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              l10n.noEventsFound,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final event = list[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              event.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("${event.date} - ${event.time}\n${event.location}"),
            ),
            trailing: Chip(
              label: Text(
                // يمكنك أيضاً هنا عمل دالة لترجمة نوع الفعالية الظاهر في الـ Chip
                event.type,
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.deepPurple[50],
            ),
          ),
        );
      },
    );
  }
}
