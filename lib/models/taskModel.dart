class TaskModel {
  final int? id;
  final int eventId; // الربط بالجدول الثاني
  String taskName;
  bool isDone;

  TaskModel({
    this.id,
    required this.eventId,
    required this.taskName,
    this.isDone = false,
  });

  // لتحويله إلى Map عند الحفظ في SQFlite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'eventId': eventId,
      'taskName': taskName,
      'isDone': isDone ? 1 : 0, // SQLite يحفظ البولين كـ 0 أو 1
    };
  }

  // لتحويل الخريطة القادمة من القاعدة إلى كائن Task
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      eventId: map['eventId'],
      taskName: map['taskName'],
      isDone: map['isDone'] == 1,
    );
  }
}
