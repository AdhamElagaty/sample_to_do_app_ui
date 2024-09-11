import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_state.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';
import 'package:sample_to_do_app_ui/utils/helper.dart';
import 'package:sample_to_do_app_ui/widgets/custom_expansion_tile_task_widget.dart';

class GenerateTileTasksListWidget extends StatelessWidget {
  const GenerateTileTasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: BlocProvider.of<TasksViewCubit>(context).getTasksByDateDate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return BlocConsumer<TasksViewCubit, TasksViewState>(
            listener: (context, state) {},
            builder: (context, state) {
              return tasksUIList(state, context);
            },
          );
        }
      },
    );
  }

  Widget tasksUIList(TasksViewState state, BuildContext context) {
    if (state is UpdateDataViewTasksSuccess) {
      final tasks = BlocProvider.of<TasksViewCubit>(context).tasksModel;
      if (tasks == null || tasks.isEmpty) {
        return Center(
          child: Text(
            "No Tasks in this day 😊",
            style: AppStyle.styleBold18
                .copyWith(color: const Color(0xff000000).withOpacity(0.5)),
          ),
        );
      }
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => CustomExpansionTileTaskWidget(
          title:
              Helper.formatTimeOfDayToStringfromDateTime(tasks[index].dateTime),
        ),
      );
    } else if (state is UpdateDataViewTasksNotExist) {
      return Center(
        child: Text(
          "No Tasks in this day 😊",
          style: AppStyle.styleBold18
              .copyWith(color: const Color(0xff000000).withOpacity(0.5)),
        ),
      );
    } else if (state is UpdateDataViewTasksFailure) {
      return Center(
        child: Text(state.errorMessage),
      );
    } else {
      // Handle unexpected states
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
