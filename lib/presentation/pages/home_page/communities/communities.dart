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
    return Card(
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 200,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "d",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: ColorManager.white),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Text(
                  "c",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.white),
                  maxLines: 2,
                ),
                Text(
                  "b",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.white),
                  maxLines: 2,
                ),
                Text(
                  "a",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.white),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ));
  }
}
