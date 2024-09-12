import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';

Future<void> viewCustomDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  String? confirmButtonText,
  String? cancelButtonText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: AppStyle.styleRegular16,
        ),
        content: content,
        actions: <Widget>[
          if (cancelButtonText != null)
            TextButton(
              onPressed: () {
                if (onCancel != null) {
                  onCancel();
                }
                Navigator.of(context).pop();
              },
              child: Text(
                cancelButtonText,
                style: AppStyle.styleSemibold14,
              ),
            ),
          if (confirmButtonText != null)
            TextButton(
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm();
                }
                Navigator.of(context).pop();
              },
              child: Text(
                confirmButtonText,
                style: AppStyle.styleSemibold14.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
        ],
      );
    },
  );
}
