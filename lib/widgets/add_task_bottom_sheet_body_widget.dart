import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:sample_to_do_app_ui/widgets/add_task_form_widget.dart';
import 'package:sample_to_do_app_ui/widgets/bottom_sheet_header_widget.dart';

class AddTaskBottomSheetBodyWidget extends StatelessWidget {
  const AddTaskBottomSheetBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeaderWidget(
                title: "Add Task",
              ),
              AddTaskFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
