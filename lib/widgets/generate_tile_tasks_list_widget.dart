import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/widgets/custom_expansion_tile_task_widget.dart';

class GenerateTileTasksListWidget extends StatelessWidget {
  const GenerateTileTasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) => const CustomExpansionTileTaskWidget(
        title: "07:00 AM",
      ),
    );
  }
}
