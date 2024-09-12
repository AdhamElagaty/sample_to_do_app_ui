import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:sample_to_do_app_ui/widgets/custom_text_form_field_widget.dart';

class EditSubTaskFormDialogBody extends StatelessWidget {
  const EditSubTaskFormDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SubTaskCubit>(context).formKeyEditSubTask,
      child: CustomTextFormFieldWidget(
        hintText: "my task",
        labelText: "Add Your Updated Task",
        controller:
            BlocProvider.of<SubTaskCubit>(context).subTaskEditController,
        validator: (value) =>
            BlocProvider.of<SubTaskCubit>(context).validateTaskText(value),
      ),
    );
  }
}
