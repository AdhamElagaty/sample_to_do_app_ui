import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/task_cubit/task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_state.dart';
import 'package:sample_to_do_app_ui/models/task_model.dart';
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
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return BlocConsumer<TasksViewCubit, TasksViewState>(
            listener: (context, state) {},
            builder: (context, state) {
              return tasksUIList(state, context);
            },
          );
        } else {
          return const Center(child: Text('Something went wrong.'));
        }
      },
    );
  }

  Widget tasksUIList(TasksViewState state, BuildContext context) {
    if (state is UpdateDataViewTasksSuccess) {
      final tasks = BlocProvider.of<TasksViewCubit>(context).tasksModel;
      if (tasks == null || tasks.isEmpty) {
        return buildNoTasksMessage();
      }
      return buildTasksList(tasks);
    } else if (state is UpdateDataViewTasksNotExist) {
      return buildNoTasksMessage();
    } else if (state is UpdateDataViewTasksFailure) {
      return Center(child: Text(state.errorMessage));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget buildNoTasksMessage() {
    return Center(
      child: Text(
        "No Tasks in this day 😊",
        style: AppStyle.styleBold18
            .copyWith(color: const Color(0xff000000).withOpacity(0.5)),
      ),
    );
  }

  Widget buildTasksList(List<TaskModel> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => BlocProvider(
        create: (context) => TaskCubit(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CustomExpansionTileTaskWidget(
            taskIndex: index,
            title: Helper.formatTimeOfDayToStringfromDateTime(
                tasks[index].dateTime),
          ),
        ),
      ),
    );
  }
}
