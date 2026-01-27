class EventModel {
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String type;

  EventModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'type': type,
    };
  }
}
