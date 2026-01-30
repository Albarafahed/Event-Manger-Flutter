import 'package:event_manager/l10n/app_localizations.dart';
import 'package:event_manager/views/EventDetailsView.dart';
import 'package:event_manager/views/events/create_event_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/events_list_controller.dart';
import '../../models/event_model.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدمنا اسم l10n ليكون موحداً وسهلاً
    final l10n = AppLocalizations.of(context)!;

    final controller = Get.isRegistered<EventsListController>()
        ? Get.find<EventsListController>()
        : Get.put(EventsListController());

    return DefaultTabController(
      length: controller.tabKeys.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.eventsTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.loadEventsFromDatabase(),
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: controller.tabKeys.map((key) {
              return Tab(text: controller.getTabName(context, key));
            }).toList(),
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelColor: const Color.fromARGB(255, 183, 58, 58),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: controller.tabKeys.map((key) {
            return Obx(() {
              final filteredList = controller.filterByType(key);
              return _buildList(context, filteredList, controller);
            });
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            controller.editingEvent = null;
            Get.to(() => CreateEventView(onAddEvent: (event) {
                  controller.loadEventsFromDatabase();
                }));
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<EventModel> list,
      EventsListController controller) {
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            title: Text(
              event.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("${event.date} - ${event.time}\n${event.location}"),
            ),
            trailing: SizedBox(
              width: 100,
              child: Wrap(
                spacing: 0,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 22),
                    onPressed: () {
                      controller.prepareUpdate(event);
                      Get.to(() => CreateEventView(onAddEvent: (updatedEvent) {
                            controller.loadEventsFromDatabase();
                          }));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.red, size: 22),
                    onPressed: () =>
                        _confirmDelete(context, controller, event.id!),
                  ),
                ],
              ),
            ),
            onTap: () {
              Get.to(() => EventDetailsView(event: event));
            },
          ),
        );
      },
    );
  }

  void _confirmDelete(
      BuildContext context, EventsListController controller, int id) {
    // 1. يجب تعريف l10n هنا أيضاً لأنها دالة منفصلة
    final l10n = AppLocalizations.of(context)!;

    Get.dialog(
      AlertDialog(
        // 2. إزالة كلمة const لأن النصوص المترجمة ليست ثابتة برمجياً
        title: Text(l10n.deleteEventTitle),
        content: Text(l10n.deleteConfirmMessage),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () {
              controller.deleteEvent(id);
              Get.back();
            },
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
