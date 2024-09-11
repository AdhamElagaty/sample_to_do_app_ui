import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_state.dart';
import 'package:sample_to_do_app_ui/widgets/add_sub_task_widget.dart';

class GenerateAddSubTaskList extends StatelessWidget {
  const GenerateAddSubTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: BlocProvider.of<AddTaskCubit>(context)
              .taskModel
              .subTasksModel!
              .length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: AddSubTaskWidget(
              text: BlocProvider.of<AddTaskCubit>(context)
                  .taskModel
                  .subTasksModel![index]
                  .title,
              onPressed: () {
                BlocProvider.of<AddTaskCubit>(context).removeSubTask(index);
              },
            ),
          ),
        );
      },
    );
  }
}
