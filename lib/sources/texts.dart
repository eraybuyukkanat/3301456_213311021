import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  AppLargeText(
      {super.key,
      this.size = 30,
      required this.text,
      this.color = Colors.black});

  double? size;
  final String? text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}

class AppText extends StatelessWidget {
  AppText(
      {super.key,
      this.size = 16,
      required this.text,
      this.color = Colors.black54});

  double? size;
  final String? text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: size),
    );
  }
}
