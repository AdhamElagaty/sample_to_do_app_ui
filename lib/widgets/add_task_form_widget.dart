import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_state.dart';
import 'package:sample_to_do_app_ui/widgets/add_sub_task_form.dart';
import 'package:sample_to_do_app_ui/widgets/custom_elevated_button_widget.dart';
import 'package:sample_to_do_app_ui/widgets/custom_text_form_field_widget.dart';
import 'package:sample_to_do_app_ui/widgets/data_picker_widget.dart';

class AddTaskFormWidget extends StatelessWidget {
  const AddTaskFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: BlocProvider.of<AddTaskCubit>(context).formKey,
            autovalidateMode:
                BlocProvider.of<AddTaskCubit>(context).autovalidateMode,
            child: Column(
              children: [
                DataPickerWidget(
                  title: "Date",
                  customTextFormFieldWidget: CustomTextFormFieldWidget(
                    width: 220,
                    controller:
                        BlocProvider.of<AddTaskCubit>(context).dateController,
                    onTap: () async {
                      BlocProvider.of<AddTaskCubit>(context).getDate(context);
                    },
                    prefixIcon: Icons.calendar_today,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Date";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                DataPickerWidget(
                  title: "Time",
                  customTextFormFieldWidget: CustomTextFormFieldWidget(
                    width: 220,
                    controller:
                        BlocProvider.of<AddTaskCubit>(context).timeController,
                    onTap: () async {
                      BlocProvider.of<AddTaskCubit>(context).getTime(context);
                    },
                    prefixIcon: Icons.access_time,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Time";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                const AddSubTaskForm(),
                const SizedBox(height: 12),
                state is AddTaskFailure
                    ? Center(
                        child: Text(
                          state.errorMessage,
                          style: TextStyle(
                            color: Colors.red[700],
                          ),
                        ),
                      )
                    : const SizedBox(),
                CustomElevatedButtonWidget(
                    textName: "Confirm",
                    onPressed: () async {
                      await BlocProvider.of<AddTaskCubit>(context)
                          .confirmTask();
                    }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
