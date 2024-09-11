import 'package:flutter/material.dart';

Future<DateTime?> viewDatePicker(BuildContext context) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2224),
  );
  return selectedDate;
}
