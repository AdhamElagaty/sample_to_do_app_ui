import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_state.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';
import 'package:sample_to_do_app_ui/widgets/custom_text_form_field_widget.dart';
import 'package:sample_to_do_app_ui/widgets/generate_add_sub_task_list.dart';

class AddSubTaskForm extends StatelessWidget {
  const AddSubTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return Form(
          key: BlocProvider.of<AddTaskCubit>(context).formKeySubTak,
          autovalidateMode:
              BlocProvider.of<AddTaskCubit>(context).autoSUbTaskvalidateMode,
          child: Column(
            children: [
              CustomTextFormFieldWidget(
                hintText: "my task",
                labelText: "Add Task",
                controller:
                    BlocProvider.of<AddTaskCubit>(context).taskController,
                validator: (value) => BlocProvider.of<AddTaskCubit>(context)
                    .validateTaskText(value),
              ),
              const SizedBox(height: 12),
              IconButton(
                style: IconButton.styleFrom(
                  fixedSize: const Size(68, 40),
                  backgroundColor: const Color.fromARGB(255, 213, 213, 213),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: BlocProvider.of<AddTaskCubit>(context).addSubTask,
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 241, 241),
                  border: Border.all(
                      width: 4,
                      color: const Color.fromARGB(255, 213, 213, 213)),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 260,
                child: (BlocProvider.of<AddTaskCubit>(context)
                        .isSubTaskInitialState())
                    ? Center(
                        child: Text(
                          "No Tasks To View",
                          style: AppStyle.styleBold18.copyWith(
                              color: const Color(0xff000000).withOpacity(0.5)),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GenerateAddSubTaskList(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
