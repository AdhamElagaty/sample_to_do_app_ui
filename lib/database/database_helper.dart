import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'task_manager.db'),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Task(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          dateTime INTEGER,
          taskStatus INTEGER
        )
      ''');

        await db.execute('''
        CREATE TABLE SubTask(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          isCompleted INTEGER,
          taskId INTEGER,
          FOREIGN KEY(taskId) REFERENCES Task(id) ON DELETE CASCADE
        )
      ''');
      },
      version: 1,
    );
  }
}
