import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

class widthSizedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? textColor;
  Color? color;
  widthSizedButton({
    required this.color,
    required this.text,
    this.onPressed,
    this.textColor,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: color ?? ColorManager.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textColor ?? ColorManager.white,
                ),
          )),
    );
  }
}
