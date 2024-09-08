import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';
import 'package:sample_to_do_app_ui/widgets/sub_task_widget.dart';
import 'package:sample_to_do_app_ui/widgets/custom_trailing_expansion_tile_widget.dart';

class CustomExpansionTileTaskWidget extends StatefulWidget {
  const CustomExpansionTileTaskWidget({super.key, required this.title});

  final String title;

  @override
  State<CustomExpansionTileTaskWidget> createState() =>
      _CustomExpansionTileTaskWidgetState();
}

class _CustomExpansionTileTaskWidgetState
    extends State<CustomExpansionTileTaskWidget> {
  bool isExpanded = false;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        backgroundColor: const Color(0xfff7f7f7),
        collapsedBackgroundColor: const Color(0xfff7f7f7),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        collapsedShape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        expandedAlignment: Alignment.centerLeft,
        trailing: CustomTrailingExpansionTileWidget(
            statusTerxt: isCompleted ? "Completed" : "1/3 Task Completed",
            isCompleted: isCompleted,
            isExpanded: isExpanded),
        onExpansionChanged: (value) {
          isExpanded = value;
          isCompleted = value;
          setState(() {});
        },
        showTrailingIcon: true,
        title: Text(
          widget.title,
          style: AppStyle.styleBold18,
        ),
        children: [
          SubTaskWidget(
            onTap: () {},
          ),
          SubTaskWidget(
            onTap: () {},
          ),
          SubTaskWidget(
            onTap: () {},
          ),
          SubTaskWidget(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
