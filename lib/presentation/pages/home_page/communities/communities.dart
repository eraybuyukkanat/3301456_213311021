import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/communities/communities_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';

import '../../../../sources/colors.dart';

class CommunityModel {
  String name;
  CommunityModel({required this.name});
}

class CommunitiesPageView extends StatefulWidget {
  const CommunitiesPageView({super.key});

  @override
  State<CommunitiesPageView> createState() => _CommunitiesPageViewState();
}

class _CommunitiesPageViewState extends CommunitiesViewModel {
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
        itemCount: communities.length,
        itemBuilder: (_, index) => Card(
          child: ListTile(
            title: Text(communities[index].name),
          ),
        ),
      ),
    );
  }
}
