import 'package:flutter/material.dart';

Future<DateTime?> viewDatePicker(BuildContext context, {DateTime? date}) async {
  final DateTime initialDate = date ?? DateTime.now();

  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2224),
  );

  return selectedDate;
}
