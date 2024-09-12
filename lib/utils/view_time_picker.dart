import 'package:flutter/material.dart';

Future<TimeOfDay?> viewTimePicker(BuildContext context) async {
  final TimeOfDay? selectedDate = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return selectedDate;
}
