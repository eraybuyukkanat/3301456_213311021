import 'package:flutter/material.dart';

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
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
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
