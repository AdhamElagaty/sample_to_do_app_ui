import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_state.dart';
import 'package:sample_to_do_app_ui/database/repository/sub_task_repository.dart';
import 'package:sample_to_do_app_ui/models/sub_task_model.dart';

class SubTaskCubit extends Cubit<SubTaskState> {
  SubTaskCubit() : super(SubTaskStateInitial());

  SubTaskModel? subTaskModel;

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
}
