import 'package:flutter/material.dart';

void viewBottomSheet(BuildContext context, Widget bottomSheetBody) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: const Color(0xffF7F7F7),
    context: context,
    builder: (context) {
      return bottomSheetBody;
    },
  );
}
