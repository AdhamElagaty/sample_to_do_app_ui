import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_state.dart';
import 'package:sample_to_do_app_ui/database/repository/task_repository.dart';
import 'package:sample_to_do_app_ui/utils/helper.dart';
import 'package:sample_to_do_app_ui/utils/view_date_picker.dart';
import 'package:sample_to_do_app_ui/utils/view_time_picker.dart';
import 'package:sample_to_do_app_ui/models/sub_task_model.dart';
import 'package:sample_to_do_app_ui/models/task_model.dart';
import 'package:sample_to_do_app_ui/models/task_status_enum.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySubTak = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final taskController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode autoSUbTaskvalidateMode = AutovalidateMode.disabled;
  TaskModel taskModel = TaskModel(
      dateTime: DateTime.now(),
      taskStatus: TaskStatus.notBegun,
      subTasksModel: <SubTaskModel>[]);

  Future<void> _saveTask(TaskModel task) async {
    try {
      await TaskRepository().addTaskWithSubTasks(task);
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> confirmTask() async {
    try {
      if (formKey.currentState!.validate() &&
          taskModel.subTasksModel!.isNotEmpty) {
        DateTime taskDateTime = Helper.parseDateString(dateController.text);
        TimeOfDay taskTimeOfDay =
            Helper.parseTimeOfDayString(timeController.text);
        bool isValide = await checkDate(taskDateTime, taskTimeOfDay);
        if (isValide) {
          taskModel.dateTime =
              Helper.combineDateTimeWithTime(taskDateTime, taskTimeOfDay);
          await _saveTask(taskModel);
          emit(AddTaskSuccess());
        }
      } else {
        autovalidateMode = AutovalidateMode.always;
        if (taskModel.subTasksModel!.isEmpty) {
          autoSUbTaskvalidateMode = AutovalidateMode.always;
        }
        emit(AddTaskFailure(errorMessage: "Error! Enter All Data Fields"));
      }
    } catch (e) {
      emit(AddTaskFailure(errorMessage: "Error! Try Again"));
    }
  }

  Future<bool> checkDate(DateTime date, TimeOfDay time) async {
    bool isValid = await TaskRepository().hasTaskWithSameDateTime(date, time);
    if (!isValid) {
      emit(AddTaskFailure(
          errorMessage: "A task with the same date and time already exists"));
      return false;
    }
    return true;
  }

  Future<void> getDate(BuildContext context) async {
    DateTime? date = await viewDatePicker(context);
    if (date != null) {
      dateController.text = Helper.formatDateToString(date);
    } else {
      dateController.text = "";
    }
  }

  Future<void> getTime(BuildContext context) async {
    TimeOfDay? time = await viewTimePicker(context);
    if (time != null) {
      timeController.text = Helper.formatTimeOfDayToString(time);
    } else {
      timeController.text = "";
    }
  }

  bool isSubTaskInitialState() {
    return taskModel.subTasksModel!.isEmpty;
  }

  void addSubTask() {
    if (formKeySubTak.currentState!.validate()) {
      taskModel.subTasksModel!.add(SubTaskModel(
        title: taskController.text,
        isCompleted: false,
      ));
      taskController.clear();
      autoSUbTaskvalidateMode = AutovalidateMode.disabled;
      emit(AddSubTaskSuccess());
    } else {
      autoSUbTaskvalidateMode = AutovalidateMode.always;
      emit(AddSubTaskFailure(errorMessage: "Error! Task text not validate"));
    }
  }

  void removeSubTask(int index) {
    taskModel.subTasksModel!.removeAt(index);
    emit(RemoveSubTaskSuccess());
    if (taskModel.subTasksModel!.isEmpty) {
      emit(AddSubTaskInitial());
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
