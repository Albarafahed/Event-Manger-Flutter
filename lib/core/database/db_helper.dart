import 'package:event_manager/models/event_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }
  

  initDb() async {
    String path = join(await getDatabasesPath(), "event_manager_v2.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // 1. جدول المستخدمين
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');

        // 2. جدول الفعاليات
        await db.execute('''
          CREATE TABLE events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT,
            title TEXT,
            description TEXT,
            date TEXT,
            time TEXT,
            location TEXT,
            type TEXT,
            FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
          )
        ''');

        // 3. جدول المهام
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            eventId INTEGER,
            taskName TEXT,
            isDone INTEGER DEFAULT 0,
            FOREIGN KEY (eventId) REFERENCES events (id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // --- دوال المستخدمين ---
  Future<int> insertUser(Map<String, dynamic> userMap) async {
    Database dbClient = await db;
    return await dbClient.insert('users', userMap);
  }

  // --- دوال الفعاليات ---
  Future<int> insertEvent(Map<String, dynamic> eventMap) async {
    Database dbClient = await db;
    return await dbClient.insert('events', eventMap);
  }

  // *** دالة التعديل (Update) التي طلبتها ***
  Future<int> updateEvent(EventModel event) async {
    Database dbClient = await db; // تم تصحيح المسمى هنا
    return await dbClient.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<List<Map<String, dynamic>>> getEventsByUserId(String userId) async {
    Database dbClient = await db;
    return await dbClient
        .query('events', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<int> deleteEvent(int id) async {
    Database dbClient = await db;
    return await dbClient.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- دوال المهام والتحقق ---
  Future<int> insertTask(Map<String, dynamic> taskMap) async {
    Database dbClient = await db;
    return await dbClient.insert('tasks', taskMap);
  }

  Future<List<Map<String, dynamic>>> getTasksByEventId(int eventId) async {
    Database dbClient = await db;
    return await dbClient
        .query('tasks', where: 'eventId = ?', whereArgs: [eventId]);
  }

  Future<int> updateTaskStatus(int taskId, int isDone) async {
    Database dbClient = await db;
    return await dbClient.update('tasks', {'isDone': isDone},
        where: 'id = ?', whereArgs: [taskId]);
  }

  Future<Map<String, dynamic>?> loginCheck(
      String email, String password) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return res.isNotEmpty ? res.first : null;
  }
  Future<int> deleteTask(int id) async {
    final data = await db;
    return await data.delete(
      'tasks', // تأكد من اسم الجدول لديك
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> updateTaskName(int id, String name) async {
    final dbs = await db;
    return await dbs.update(
      'tasks',
      {'taskName': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
  