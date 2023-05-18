import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key, required this.color, required this.size});
  final color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpinKitFadingCircle(
        color: color,
        size: size,
      ),
    );
  }
}

class loadingWidget extends StatelessWidget {
  const loadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingBar(
          color: ColorManager.black,
          size: 45,
        ),
      ],
    );
  }
}
