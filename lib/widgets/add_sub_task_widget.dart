import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';

class AddSubTaskWidget extends StatelessWidget {
  const AddSubTaskWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: const Color.fromARGB(113, 0, 0, 0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: AppStyle.styleRegular18.copyWith(fontSize: 24),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.delete,
                size: 34,
              ),
            )
          ],
        ),
      ),
    );
  }
}
