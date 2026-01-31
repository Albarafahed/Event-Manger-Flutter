import 'package:event_manager/controllers/task_controller.dart';
import 'package:event_manager/l10n/app_localizations.dart';
import 'package:event_manager/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsView extends StatelessWidget {
  final EventModel event;
  const EventDetailsView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // استخدام put لضمان عمل الكنترولر داخل الصفحة
    final taskController = Get.put(TaskController());

    // جلب المهام المرتبطة بهذه الفعالية
    taskController.loadTasks(event.id!);

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Column(
        children: [
          // أضف هذا داخل Column في EventDetailsView
          Obx(() {
            if (taskController.tasks.isEmpty) return const SizedBox();

            final total = taskController.tasks.length;
            final done = taskController.tasks.where((t) => t.isDone).length;
            final progress = done / total;

            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.tasksProgress,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("${(progress * 100).toInt()}%"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: Colors.green,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
            );
          }),
          // عرض تفاصيل الفعالية في كرت أنيق
          Card(
            margin: const EdgeInsets.all(12),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.info_outline, color: Colors.white),
              ),
              title: Text(event.location,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${event.date} | ${event.time}"),
            ),
          ),

          const Divider(),

          // قسم إضافة مهمة جديدة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController.taskTitleController,
                    decoration: InputDecoration(
                      hintText: l10n.addTaskHint,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle,
                      color: Colors.green, size: 35),
                  onPressed: () {
                    if (taskController.taskTitleController.text
                        .trim()
                        .isNotEmpty) {
                      taskController.addTask(event.id!);
                    } else {
                      Get.snackbar(l10n.createError, l10n.fieldCannotBeEmpty,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                ),
              ],
            ),
          ),

          // قائمة المهام مع ميزات السحب (Dismissible)
          Expanded(
            child: Obx(() {
              if (taskController.tasks.isEmpty) {
                return Center(child: Text(l10n.noTasksFound));
              }
              return ListView.builder(
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.tasks[index];

                  return Dismissible(
                    key: Key(task.id.toString()),
                    // السحب في الاتجاهين: يمين للتعديل، يسار للحذف
                    direction: DismissDirection.horizontal,

                    // خلفية التعديل (سحب لليمين)
                    background: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),

                    // خلفية الحذف (سحب لليسار)
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),

                    // التحكم في الأكشن بناءً على اتجاه السحب
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        // تعديل: نفتح الدايلوج ونرجع false لكي لا يختفي السطر
                        _showEditTaskDialog(
                            context, taskController, task, event.id!);
                        return false;
                      } else {
                        // حذف: نرجع true لتأكيد الحذف البصري
                        return true;
                      }
                    },

                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        taskController.deleteTask(task.id!, event.id!);
                      }
                    },

                    child: CheckboxListTile(
                      title: Text(
                        task.taskName,
                        style: TextStyle(
                          decoration:
                              task.isDone ? TextDecoration.lineThrough : null,
                          color: task.isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      value: task.isDone,
                      activeColor: Colors.green,
                      onChanged: (val) => taskController.toggleTask(task),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // نافذة تعديل اسم المهمة
  void _showEditTaskDialog(
      BuildContext context, TaskController controller, task, int eventId) {
    final editController = TextEditingController(text: task.taskName);

    Get.defaultDialog(
      title: AppLocalizations.of(context)!.editTask,
      content: TextField(
        controller: editController,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      textConfirm: AppLocalizations.of(context)!.save,
      textCancel: AppLocalizations.of(context)!.cancel,
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.updateTaskName(task.id!, editController.text, eventId);
        Get.back();
      },
    );
  }
}
