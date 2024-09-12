import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_state.dart';
import 'package:sample_to_do_app_ui/database/repository/sub_task_repository.dart';
import 'package:sample_to_do_app_ui/models/sub_task_model.dart';
import 'package:sample_to_do_app_ui/utils/view_dialog.dart';

class SubTaskCubit extends Cubit<SubTaskState> {
  SubTaskCubit() : super(SubTaskStateInitial());

  SubTaskModel? subTaskModel;
  final GlobalKey<FormState> formKeyEditSubTask = GlobalKey<FormState>();
  final subTaskEditController = TextEditingController();

  Future<void> updateSubTaskCompletion() async {
    SubTaskModel subTask = subTaskModel!;
    try {
      subTask.isCompleted = !subTask.isCompleted;
      await SubTaskRepository().updateSubTask(subTask);
      subTaskModel = subTask;
      if (subTaskModel!.isCompleted) {
        emit(SubTaskCompleted());
      } else {
        emit(SubTaskNotCompleted());
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateSupTask(
      BuildContext context, Widget editSubTaskFormDialogBody) async {
    SubTaskModel subTask = subTaskModel!;
    try {
      subTaskEditController.text = subTask.title;
      viewCustomDialog(
        context: context,
        title: "Edit Task",
        content: editSubTaskFormDialogBody,
        cancelButtonText: "Cancel",
        confirmButtonText: "Update",
        onConfirm: () async {
          if (subTaskEditController.text != subTask.title) {
            subTask.title = subTaskEditController.text;
            await SubTaskRepository().updateSubTask(subTask);
            subTaskModel = subTask;
            emit(SubTaskUpdated());
          }
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  String? validateTaskText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Task';
    } else if (value.length < 5) {
      return 'Task must be at least 5 characters long';
    } else if (value.length > 100) {
      return 'Task must not exceed 100 characters';
    }
    return null;
  }
}
