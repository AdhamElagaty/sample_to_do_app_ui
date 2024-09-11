import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_state.dart';
import 'package:sample_to_do_app_ui/database/repository/task_repository.dart';
import 'package:sample_to_do_app_ui/models/task_model.dart';
import 'package:sample_to_do_app_ui/utils/view_date_picker.dart';

class TasksViewCubit extends Cubit<TasksViewState> {
  TasksViewCubit() : super(TasksViewStateInitial());

  DateTime dateTime = DateTime.now();
  List<TaskModel>? tasksModel;

  Future<void> selectDate(BuildContext context) async {
    DateTime? resultOfDate = await viewDatePicker(context, date: dateTime);
    if (resultOfDate != null) {
      dateTime = resultOfDate;
      await getTasksByDateDate();
    }
  }

  Future<void> getTasksByDateDate() async {
    try {
      List<TaskModel> tasks = await TaskRepository().getTasksByDate(dateTime);
      tasksModel = tasks;
      if (tasksModel!.isEmpty) {
        emit(UpdateDataViewTasksNotExist());
      } else {
        emit(UpdateDataViewTasksSuccess());
      }
    } on Exception {
      emit(UpdateDataViewTasksFailure(errorMessage: "Error! on tasks loading"));
    }
  }

  int getDateTense() {
    int date = DateTime(dateTime.day, dateTime.month, dateTime.year)
        .microsecondsSinceEpoch;
    int currentDate =
        DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)
            .microsecondsSinceEpoch;
    if (date > currentDate) {
      return 1;
    } else if (date < currentDate) {
      return 2;
    } else {
      return 0;
    }
  }
}
