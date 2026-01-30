class EventModel {
  final int? id; // أضفنا id ليكون تلقائي من قاعدة البيانات
  final String userId;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String type;

  EventModel({
    this.id, // الـ id اختياري لأنه يُنشأ تلقائياً عند الحفظ
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
  });

  // 1. لتحويل الكائن إلى Map (عند الحفظ في قاعدة البيانات)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // نرسل الـ id فقط إذا كان موجوداً
      'userId': userId,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'type': type,
    };
  }

  // 2. لتحويل الـ Map القادم من قاعدة البيانات إلى كائن (عند جلب البيانات)
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      type: map['type'],
    );
  }
}
