import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/database/database_helper.dart';
import 'package:sample_to_do_app_ui/utils/helper.dart';
import 'package:sample_to_do_app_ui/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertTask(TaskModel task) async {
    final db = await _dbHelper.database;
    return await db.insert('Task', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<TaskModel?> getTaskById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('Task', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TaskModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await _dbHelper.database;
    final maps = await db.query('Task');

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await _dbHelper.database;
    return await db
        .update('Task', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Task', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TaskModel>> getTasksByDateTime(
      DateTime date, TimeOfDay time) async {
    final dateTime = Helper.combineDateTimeWithTime(date, time);
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT * FROM Task 
      WHERE dateTime = ?
      ''', [dateTime.millisecondsSinceEpoch]);

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    final db = await _dbHelper.database;
    final String formattedDate =
        "${date.year}-${date.month}-${date.day}"; // Format the date to YYYY-MM-DD

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT * FROM Task 
    WHERE DATE(dateTime / 1000, 'unixepoch') = ?
  ''', [formattedDate]);

    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }
}
