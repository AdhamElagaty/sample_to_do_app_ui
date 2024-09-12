import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_state.dart';
import 'package:sample_to_do_app_ui/cubits/task_cubit/task_cubit.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';

class SubTaskWidget extends StatelessWidget {
  const SubTaskWidget({
    super.key,
    required this.subTaskIndex,
  });

  final int subTaskIndex;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubTaskCubit>(context).subTaskModel =
        BlocProvider.of<TaskCubit>(context)
            .taskModel!
            .subTasksModel![subTaskIndex];
    final subTaskCubit = BlocProvider.of<SubTaskCubit>(context);
    return BlocConsumer<SubTaskCubit, SubTaskState>(
      listener: (context, state) {
        if (state is SubTaskCompleted || state is SubTaskNotCompleted) {
          BlocProvider.of<TaskCubit>(context).changeStateOfTask();
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: subTaskCubit.updateSubTaskCompletion,
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Checkbox(
                  activeColor: const Color(0xff34C759),
                  value: subTaskCubit.subTaskModel!.isCompleted,
                  onChanged: (value) {
                    subTaskCubit.updateSubTaskCompletion();
                  },
                ),
                Text(
                  subTaskCubit.subTaskModel!.title,
                  style: subTaskCubit.subTaskModel!.isCompleted
                      ? AppStyle.styleRegular16.copyWith(
                          decoration: TextDecoration.lineThrough,
                        )
                      : AppStyle.styleRegular16.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
