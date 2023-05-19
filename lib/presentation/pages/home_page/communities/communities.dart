import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/sources/buttons.dart';

import '../../../../sources/colors.dart';

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
  String pageTitle = "Topluluklar";
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
            )),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                communityCard(title: "Test", subtitle: "subtitle"),
              ],
            ),
          ),
        ));
  }
}

class communityCard extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const communityCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.secondary,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: ColorManager.secondary,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text("TOPLULUK ADI"),
                SizedBox(height: 2.h),
                Text("TOPLULUK AÇILIMI"),
                SizedBox(height: 2.h),
                Text("TOPLULUK AÇILIMI"),
                SizedBox(height: 2.h),
                Text("TOPLULUĞA KATIL BUTONU"),
              ],
            ),
          ),
        ));
  }
}
