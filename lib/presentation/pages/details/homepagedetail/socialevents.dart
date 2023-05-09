import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/sources/buttons.dart';

import '../../../../sources/colors.dart';

class SocialEventsPage extends StatefulWidget {
  const SocialEventsPage({super.key});

  @override
  State<SocialEventsPage> createState() => _SocialEventsPageState();
}

class _SocialEventsPageState extends State<SocialEventsPage> {
  @override
  Widget build(BuildContext context) {
    String? pageTitle = "Sosyal Etkinlikler";
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 3.h,
          elevation: 10,
          backgroundColor: ColorManager.white,
          toolbarHeight: 10.h,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/mainpage");
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.black,
            ),
          ),
          title: Text(
            pageTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          )),
    );
  }
}
