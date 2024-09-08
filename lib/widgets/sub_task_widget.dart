import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';

class SubTaskWidget extends StatefulWidget {
  const SubTaskWidget({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  State<SubTaskWidget> createState() => _SubTaskWidgetState();
}

class _SubTaskWidgetState extends State<SubTaskWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange();
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Checkbox(
              activeColor: const Color(0xff34C759),
              value: isChecked,
              onChanged: (value) {
                onChange();
              },
            ),
            Text(
              "Cold shower",
              style: isChecked
                  ? AppStyle.styleRegular16.copyWith(
                      decoration: TextDecoration.lineThrough,
                    )
                  : AppStyle.styleRegular16.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void onChange() {
    widget.onTap;
    isChecked = !isChecked;
    setState(() {});
  }
}
