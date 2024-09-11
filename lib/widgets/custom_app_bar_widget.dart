import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_cubit.dart';
import 'package:sample_to_do_app_ui/cubits/tasks_view_cubit/tasks_view_state.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';
import 'package:sample_to_do_app_ui/utils/helper.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksViewCubit, TasksViewState>(
      builder: (context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getTenseswidget(context),
                GestureDetector(
                  onTap: () async {
                    await BlocProvider.of<TasksViewCubit>(context)
                        .selectDate(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        Helper.formatDateToString(
                            BlocProvider.of<TasksViewCubit>(context).dateTime),
                        style: AppStyle.styleRegular16,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: Color(0xff757575),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getTenseswidget(BuildContext context) {
    switch (BlocProvider.of<TasksViewCubit>(context).getDateTense()) {
      case 1:
        {
          return Text(
            "Future",
            style:
                AppStyle.styleBold22.copyWith(color: const Color(0xff34C759)),
          );
        }
      case 2:
        {
          return Text(
            "Past",
            style: AppStyle.styleBold22
                .copyWith(color: const Color.fromARGB(255, 240, 70, 76)),
          );
        }
      default:
        {
          return const Text(
            "Today",
            style: AppStyle.styleBold22,
          );
        }
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 46);
}
