import 'package:event_manager/core/database/db_helper.dart';
import 'package:event_manager/models/taskModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final dbHelper = DbHelper();
  final taskTitleController = TextEditingController();

  // جلب المهام المرتبطة بـ ID فعالية معينة
  Future<void> loadTasks(int eventId) async {
    final List<Map<String, dynamic>> data =
        await dbHelper.getTasksByEventId(eventId);
    tasks.assignAll(data.map((e) => TaskModel.fromMap(e)).toList());
  }

  // إضافة مهمة جديدة للجدول الثالث
  Future<void> addTask(int eventId) async {
    if (taskTitleController.text.isEmpty) return;

    final newTask = TaskModel(
      eventId: eventId,
      taskName: taskTitleController.text,
    );

    await dbHelper.insertTask(newTask.toMap());
    taskTitleController.clear();
    loadTasks(eventId); // تحديث القائمة فوراً
  }

  // تحديث حالة المهمة (مكتملة/غير مكتملة)
  Future<void> toggleTask(TaskModel task) async {
    task.isDone = !task.isDone;
    await dbHelper.updateTaskStatus(task.id!, task.isDone ? 1 : 0);
    tasks.refresh(); // تحديث الواجهة
  }

  // حذف مهمة محددة
  Future<void> deleteTask(int taskId, int eventId) async {
    try {
      await dbHelper
          .deleteTask(taskId); // تأكد من وجود هذه الدالة في الـ DbHelper
      await loadTasks(eventId); // إعادة تحميل المهام لتحديث القائمة

      // اختيارياً: إظهار رسالة نجاح
      // Get.snackbar("نجاح", "تم حذف المهمة");
    } catch (e) {
      Get.snackbar("خطأ", "فشل حذف المهمة");
    }
  }
  // دالة تحديث اسم المهمة

 
Future<void> updateTaskName(int taskId, String newName, int eventId) async {
    if (newName.trim().isEmpty) return;

    await dbHelper.updateTaskName(taskId, newName);

    int index = tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      // نأخذ النسخة القديمة ونغير فقط الاسم
      final updatedTask = tasks[index];
      updatedTask.taskName = newName;

      // نعيد وضعها في القائمة بشكل صريح
      tasks[index] = updatedTask;
    }
  }
}
