// import '../../models/event_model.dart';
// import '../database/db_helper.dart';

// class EventService {
//   static Future<void> insertEvent(EventModel event) async {
//     final db = await DatabaseService.database;
//     await db.insert('events', event.toMap());
//   }

//   static Future<List<EventModel>> getEvents() async {
//     final db = await DatabaseService.database;
//     final List<Map<String, dynamic>> maps =
//         await db.query('events', orderBy: 'date ASC');

//     return maps.map((e) => EventModel.fromMap(e)).toList();
//   }
// }
