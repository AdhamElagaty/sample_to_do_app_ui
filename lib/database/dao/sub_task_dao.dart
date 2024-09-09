import 'package:sample_to_do_app_ui/database/database_helper.dart';
import 'package:sample_to_do_app_ui/models/sub_task_model.dart';
import 'package:sqflite/sqflite.dart';

class SubTaskDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertSubTask(SubTaskModel subTask) async {
    final db = await _dbHelper.database;
    return await db.insert('SubTask', subTask.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SubTaskModel>> getSubTasksByTaskId(int taskId) async {
    final db = await _dbHelper.database;
    final maps =
        await db.query('SubTask', where: 'taskId = ?', whereArgs: [taskId]);

    return List.generate(maps.length, (i) {
      return SubTaskModel.fromMap(maps[i]);
    });
  }

  Future<SubTaskModel?> getSubTaskById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('SubTask', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return SubTaskModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<SubTaskModel>> getAllSubTasks() async {
    final db = await _dbHelper.database;
    final maps = await db.query('SubTask');

    return List.generate(maps.length, (i) {
      return SubTaskModel.fromMap(maps[i]);
    });
  }

  Future<int> updateSubTask(SubTaskModel subTask) async {
    final db = await _dbHelper.database;
    return await db.update('SubTask', subTask.toMap(),
        where: 'id = ?', whereArgs: [subTask.id]);
  }

  Future<int> deleteSubTask(int? id) async {
    final db = await _dbHelper.database;
    return await db.delete('SubTask', where: 'id = ?', whereArgs: [id]);
  }
}
