import 'package:flutter/material.dart';
import 'package:sample_to_do_app_ui/utils/app_style.dart';
import 'package:sample_to_do_app_ui/widgets/custom_text_form_field_widget.dart';

class DataPickerWidget extends StatelessWidget {
  const DataPickerWidget({
    super.key,
    required this.title,
    required this.customTextFormFieldWidget,
  });

  final String title;
  final CustomTextFormFieldWidget customTextFormFieldWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            title,
            style: AppStyle.styleBold18,
          ),
        ),
        customTextFormFieldWidget,
      ],
    );
  }
}
