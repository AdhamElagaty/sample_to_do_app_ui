import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_cubit.dart';
import 'package:sample_to_do_app_ui/utils/view_bottom_sheet.dart';
import 'package:sample_to_do_app_ui/widgets/add_task_bottom_sheet_body_widget.dart';
import 'package:sample_to_do_app_ui/widgets/custom_app_bar_widget.dart';
import 'package:sample_to_do_app_ui/widgets/custom_elevated_button_widget.dart';
import 'package:sample_to_do_app_ui/widgets/generate_tile_tasks_list_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksViewCubit(),
      child: const Stack(
        alignment: Alignment.bottomCenter,
        children: [
          HomeScaffoldViewWidget(),
          HomeFloatBottomViewWidget(),
        ],
      ),
    );
  }
}

class HomeScaffoldViewWidget extends StatelessWidget {
  const HomeScaffoldViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: CustomAppBarWidget(),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GenerateTileTasksListWidget(),
      ),
    );
  }
}

class HomeFloatBottomViewWidget extends StatelessWidget {
  const HomeFloatBottomViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 18,
      ),
      child: CustomElevatedButtonWidget(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        textName: "Add Task",
        onPressed: () {
          viewBottomSheet(
            context,
            BlocProvider.value(
              value: BlocProvider.of<TasksViewCubit>(context),
              child: const AddTaskBottomSheetBodyWidget(),
            ),
          );
        },
      ),
    );
  }
}
