import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/scienceevents/sciencevents_view_model.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class ScienceEventsView extends StatefulWidget {
  const ScienceEventsView({super.key});

  @override
  State<ScienceEventsView> createState() => _ScienceEventsViewState();
}

class _ScienceEventsViewState extends ScienceEventsViewModel {
  String pageTitle = "Bilimsel Etkinlikler";
  @override
  Widget build(BuildContext context) {
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
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) => Card(
            elevation: 10,
            color: ColorManager.white,
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
