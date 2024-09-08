import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';

class CustomTrailingExpansionTileWidget extends StatelessWidget {
  const CustomTrailingExpansionTileWidget({
    super.key,
    required this.statusTerxt,
    required this.isCompleted,
    required this.isExpanded,
  });

  final String statusTerxt;
  final bool isCompleted;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          statusTerxt,
          style: isCompleted
              ? AppStyle.styleSemibold14
                  .copyWith(color: const Color(0xff34C759))
              : AppStyle.styleSemibold14,
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(isExpanded
            ? Icons.keyboard_arrow_up_sharp
            : Icons.keyboard_arrow_down_sharp)
      ],
    );
  }
}
