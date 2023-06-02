import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key, required this.color, required this.size});
  final color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SpinKitFadingCircle(
            color: color,
            size: size,
          ),
          ColorFiltered(
            colorFilter:
                ColorFilter.mode(ColorManager.primary, BlendMode.modulate),
            child: Lottie.asset(
              "assets/json_assets/loading.json",
              width: 30.w,
              height: 15.h,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

class loadingWidget extends StatelessWidget {
  loadingWidget({
    super.key,
    this.color,
  });

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingBar(
          color: color ?? ColorManager.primary,
          size: 45,
        ),
      ],
    );
  }
}
