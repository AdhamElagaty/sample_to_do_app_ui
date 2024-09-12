import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/task_cubit/task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/task_cubit/task_state.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_cubit.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';
import 'package:sample_to_do_app_ui/widgets/sub_task_widget.dart';
import 'package:sample_to_do_app_ui/widgets/custom_trailing_expansion_tile_widget.dart';

class CustomExpansionTileTaskWidget extends StatelessWidget {
  const CustomExpansionTileTaskWidget({
    super.key,
    required this.title,
    required this.taskIndex,
  });

  final String title;
  final int taskIndex;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context)
        .reset(BlocProvider.of<TasksViewCubit>(context).tasksModel![taskIndex]);
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskStateDeleted) {
          BlocProvider.of<TasksViewCubit>(context)
                  .tasksModel![taskIndex]
                  .subTasksModel =
              BlocProvider.of<TaskCubit>(context).taskModel!.subTasksModel!;
          BlocProvider.of<TasksViewCubit>(context).deleteTask(taskIndex);
        } else if (state is TaskStateSubTaskDeleted) {
          BlocProvider.of<TasksViewCubit>(context)
                  .tasksModel![taskIndex]
                  .subTasksModel =
              BlocProvider.of<TaskCubit>(context).taskModel!.subTasksModel!;
          BlocProvider.of<TaskCubit>(context).changeStateOfTask();
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onLongPress: () {
            BlocProvider.of<TasksViewCubit>(context)
                .deleteTaskWithDialog(context, taskIndex);
          },
          child: ExpansionTile(
            controller: BlocProvider.of<TaskCubit>(context).controller,
            backgroundColor: const Color(0xfff7f7f7),
            collapsedBackgroundColor: const Color(0xfff7f7f7),
            shape: const ContinuousRectangleBorder(
                side: BorderSide(
                  color: Color.fromARGB(255, 197, 192, 192),
                  width: 8,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            collapsedShape: const ContinuousRectangleBorder(
                side: BorderSide(
                  color: Color.fromARGB(255, 197, 192, 192),
                  width: 6,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            expandedAlignment: Alignment.centerLeft,
            trailing: CustomTrailingExpansionTileWidget(
              isExpanded: BlocProvider.of<TaskCubit>(context).isExpanded,
              taskIndex: taskIndex,
            ),
            onExpansionChanged: (value) {
              BlocProvider.of<TaskCubit>(context).changeExpasion(value);
            },
            showTrailingIcon: true,
            title: Text(
              title,
              style: AppStyle.styleBold18,
            ),
            children: generateSubTaskWidgets(context, taskIndex),
          ),
        );
      },
    );
  }

  List<Widget> generateSubTaskWidgets(BuildContext context, int index) {
    // BlocProvider.of<TaskCubit>(context).updateTaskStatus();
    return List.generate(
        BlocProvider.of<TaskCubit>(context).taskModel!.subTasksModel!.length,
        (index) {
      return BlocProvider(
        create: (context) => SubTaskCubit(),
        child: SubTaskWidget(
          subTaskIndex: index,
        ),
      );
    });
  }
}
