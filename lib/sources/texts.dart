import 'package:flutter/material.dart';

class bodySmallText extends StatelessWidget {
  bodySmallText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.normal, fontSize: fontSize, color: color),
      ),
    );
  }
}

class bodyMediumText extends StatelessWidget {
  bodyMediumText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold, fontSize: fontSize, color: color),
      ),
    );
  }
}

class bodyLargeText extends StatelessWidget {
  bodyLargeText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold, fontSize: fontSize, color: color),
      ),
    );
  }
}

class titleSmallText extends StatelessWidget {
  titleSmallText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.normal, fontSize: fontSize, color: color),
      ),
    );
  }
}

class titleMediumText extends StatelessWidget {
  titleMediumText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.normal, fontSize: fontSize, color: color),
      ),
    );
  }
}

class titleLargeText extends StatelessWidget {
  titleLargeText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontSize: fontSize, color: color),
      ),
    );
  }
}

class headlineSmallText extends StatelessWidget {
  headlineSmallText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontSize: fontSize, color: color),
      ),
    );
  }
}

class headlineMediumText extends StatelessWidget {
  headlineMediumText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontSize: fontSize, color: color),
      ),
    );
  }
}

class headlineLargeText extends StatelessWidget {
  headlineLargeText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineLarge
            ?.copyWith(fontSize: fontSize, color: color),
      ),
    );
  }
}
