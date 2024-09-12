import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_state.dart';
import 'package:sample_to_do_app_ui/cubits/task_cubit/task_cubit.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';
import 'package:sample_to_do_app_ui/widgets/edit_sub_task_form_dialog_body.dart';

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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 197, 192, 192),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: subTaskCubit.updateSubTaskCompletion,
                    child: Container(
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
                                : AppStyle.styleRegular16
                                    .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xfff19e00),
                      ),
                      onPressed: () {
                        BlocProvider.of<SubTaskCubit>(context).updateSupTask(
                          context,
                          BlocProvider.value(
                            value: BlocProvider.of<SubTaskCubit>(context),
                            child: const EditSubTaskFormDialogBody(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<TaskCubit>(context)
                            .deleteSupTask(subTaskIndex);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
