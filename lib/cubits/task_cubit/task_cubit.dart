import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/task_cubit/task_state.dart';
import 'package:sample_to_do_app_ui/database/repository/sub_task_repository.dart';
import 'package:sample_to_do_app_ui/models/sub_task_model.dart';
import 'package:sample_to_do_app_ui/models/task_model.dart';
import 'package:sample_to_do_app_ui/models/task_status_enum.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskStateInitial());

  TaskModel? taskModel;
  bool isExpanded = false;
  ExpansionTileController controller = ExpansionTileController();
  int countOfCompletedTask = 0;
  int countOfTask = 0;

  int getNumberOfCompletedSubTasksPerTask() {
    int count = 0;
    for (var task in taskModel!.subTasksModel!) {
      if (task.isCompleted) {
        count++;
      }
    }
    return count;
  }

  void changeExpasion(bool value) {
    isExpanded = value;
    if (isExpanded) {
      emit(TaskStateOpen());
    } else {
      emit(TaskStateClosed());
    }
  }

  void reset(TaskModel task) {
    taskModel = task;
    isExpanded = false;
    _updateTaskStatus();
    emit(TaskStateInitial());
  }

  void _updateTaskStatus() {
    countOfCompletedTask = getNumberOfCompletedSubTasksPerTask();
    countOfTask = taskModel!.subTasksModel!.length;
    if (countOfCompletedTask == 0) {
      taskModel!.taskStatus = TaskStatus.notBegun;
    } else if (countOfCompletedTask < countOfTask) {
      taskModel!.taskStatus = TaskStatus.inProgress;
    } else if (countOfCompletedTask == countOfTask) {
      taskModel!.taskStatus = TaskStatus.completed;
    }
  }

  void changeStateOfTask() {
    _updateTaskStatus();
    emit(TaskStateChange());
  }

  Future<void> deleteSupTask(int subTaskIndex) async {
    SubTaskModel subTask = taskModel!.subTasksModel![subTaskIndex];
    try {
      await SubTaskRepository().deleteSubTask(subTask.id!);
      taskModel!.subTasksModel!.removeAt(subTaskIndex);
      if (taskModel!.subTasksModel!.isEmpty) {
        emit(TaskStateDeleted());
      } else {
        emit(TaskStateSubTaskDeleted());
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
