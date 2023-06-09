import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/communities/communities_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';

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

class _CommunitiesPageViewState extends State<CommunitiesPageView> {
  String pageTitle = "Topluluklar";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommunitiesViewModel>(
      create: (context) => CommunitiesViewModel(),
      builder: (context, child) => Scaffold(
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
        body: context.watch<CommunitiesViewModel>().isLoading
            ? loadingWidget()
            : ListView.builder(
                itemCount:
                    context.read<CommunitiesViewModel>().communities.length,
                itemBuilder: (_, index) => Card(
                  child: ListTile(
                    title: Text(context
                        .read<CommunitiesViewModel>()
                        .communities[index]
                        .name),
                  ),
                ),
              ),
      ),
    );
  }
}
