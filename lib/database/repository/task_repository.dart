import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/database/dao/sub_task_dao.dart';
import 'package:sample_to_do_app_ui/models/task_model.dart';
import '../dao/task_dao.dart';

class TaskRepository {
  final TaskDao _taskDao = TaskDao();
  final SubTaskDao _subTaskDao = SubTaskDao();

  Future<void> addTaskWithSubTasks(TaskModel task) async {
    task.id = await _taskDao.insertTask(task);
    for (var subTask in task.subTasksModel!) {
      subTask.taskId = task.id;
      await _subTaskDao.insertSubTask(subTask);
    }
  }

  Future<TaskModel?> getTaskWithSubTasks(int taskId) async {
    TaskModel? task = await _taskDao.getTaskById(taskId);
    if (task != null) {
      task.subTasksModel = await _subTaskDao.getSubTasksByTaskId(task.id!);
    }
    return task;
  }

  Future<void> updateTaskWithSubTasks(TaskModel task) async {
    await _taskDao.updateTask(task);
    for (var subTask in task.subTasksModel!) {
      await _subTaskDao.updateSubTask(subTask);
    }
  }

  Future<void> deleteTaskWithSubTasks(int taskId) async {
    await _taskDao.deleteTask(taskId);
    for (var subTask in (await _subTaskDao.getSubTasksByTaskId(taskId))) {
      await _subTaskDao.deleteSubTask(subTask.id!);
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    List<TaskModel> tasks = await _taskDao.getAllTasks();

    for (var task in tasks) {
      task.subTasksModel = await _subTaskDao.getSubTasksByTaskId(task.id!);
    }

    return tasks;
  }

  Future<bool> hasTaskWithSameDateTime(DateTime date, TimeOfDay time) async {
    List<TaskModel> tasks = await _taskDao.getTasksByDateTime(date, time);
    return tasks.isEmpty;
  }

  Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    return await _taskDao.getTasksByDate(date);
  }
}
