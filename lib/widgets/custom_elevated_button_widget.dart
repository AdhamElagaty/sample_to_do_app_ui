import 'package:flutter/material.dart';

import '../utils/app_style.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    super.key,
    required this.textName,
    required this.onPressed,
    this.icon,
  });

  final String textName;
  final void Function()? onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(42))),
          backgroundColor: Colors.black,
          fixedSize: const Size(340, 60),
          minimumSize: const Size(260, 52)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: icon == null ? 0 : 14.0),
            child: icon,
          ),
          Text(
            textName,
            style: AppStyle.styleBold18.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
