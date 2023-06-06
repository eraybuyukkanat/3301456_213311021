import 'package:flutter/material.dart';
import 'package:social_media_app_demo/config/extensions.dart';

class bodySmallText extends StatelessWidget {
  bodySmallText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontWeight,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  FontWeight? fontWeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: fontSize, color: color, fontWeight: fontWeight),
      ),
    );
  }
}

class bodyMediumText extends StatelessWidget {
  bodyMediumText(
      {super.key,
      required this.text,
      this.fontWeight,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  FontWeight? fontWeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: fontSize, color: color, fontWeight: fontWeight),
      ),
    );
  }
}

class bodyLargeText extends StatelessWidget {
  bodyLargeText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontWeight,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  FontWeight? fontWeight;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: fontWeight, fontSize: fontSize, color: color),
      ),
    );
  }
}

class titleSmallText extends StatelessWidget {
  titleSmallText(
      {super.key,
      required this.text,
      this.fontWeight,
      required this.fontSize,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  FontWeight? fontWeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: fontWeight, fontSize: fontSize, color: color),
      ),
    );
  }
}

class titleMediumText extends StatelessWidget {
  titleMediumText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontWeight,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  FontWeight? fontWeight;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: fontWeight, fontSize: fontSize, color: color),
      ),
    );
  }
}

class titleLargeText extends StatelessWidget {
  titleLargeText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontWeight,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  FontWeight? fontWeight;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: fontSize, color: color, fontWeight: fontWeight),
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
      this.fontWeight,
      this.color});

  final String text;
  final double fontSize;
  FontWeight? fontWeight;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: fontSize, color: color, fontWeight: fontWeight),
      ),
    );
  }
}

class headlineMediumText extends StatelessWidget {
  headlineMediumText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontWeight,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  EdgeInsets? padding;
  FontWeight? fontWeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: fontSize, color: color, fontWeight: fontWeight),
      ),
    );
  }
}

class headlineLargeText extends StatelessWidget {
  headlineLargeText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontWeight,
      this.padding,
      this.color});

  final String text;
  final double fontSize;
  FontWeight? fontWeight;
  EdgeInsets? padding;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Text(
        text.locale,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: fontSize, color: color, fontWeight: fontWeight),
      ),
    );
  }
}
