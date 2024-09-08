import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.date,
  });

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewPadding,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppStyle.styleBold22,
            ),
            Row(
              children: [
                Text(
                  date,
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
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 46);
}
