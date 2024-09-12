import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/task_cubit/task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_state.dart';
import 'package:sample_to_do_app_ui/models/task_status_enum.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';

class CustomTrailingExpansionTileWidget extends StatelessWidget {
  const CustomTrailingExpansionTileWidget({
    super.key,
    required this.isExpanded,
    required this.taskIndex,
  });

  final bool isExpanded;
  final int taskIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksViewCubit, TasksViewState>(
      listener: (context, state) {
        if (state is UpdateDataViewTasksSuccess) {
          BlocProvider.of<TaskCubit>(context).controller.collapse();
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            getTextStatus(context),
            Icon(isExpanded
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp)
          ],
        );
      },
    );
  }

  Widget getTextStatus(BuildContext context) {
    final taskCubitProvider = BlocProvider.of<TaskCubit>(context);
    if (taskCubitProvider.taskModel!.taskStatus == TaskStatus.completed) {
      return Text(
        "Completed",
        style:
            AppStyle.styleSemibold14.copyWith(color: const Color(0xff34C759)),
      );
    } else if (taskCubitProvider.taskModel!.taskStatus == TaskStatus.notBegun) {
      return Text(
        "0/${taskCubitProvider.countOfTask} Task Completed",
        style: AppStyle.styleSemibold14
            .copyWith(color: const Color(0xff000000).withOpacity(0.5)),
      );
    } else {
      return Text(
          "${taskCubitProvider.countOfCompletedTask}/${taskCubitProvider.countOfTask} Task Completed",
          style: AppStyle.styleSemibold14);
    }
  }
}
