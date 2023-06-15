import 'dart:async';
import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/home_page_view_model.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/texts.dart';

import '../../../sources/colors.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin, projectDate {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return ChangeNotifierProvider<HomePageViewModel>(
      create: (context) => HomePageViewModel(),
      builder: (context, child) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                // APPBAR
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            welcomingText(),
                            appBarDate(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // IMAGES
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    onLongPress: () {
                      context.read<HomePageViewModel>().launchLink(
                          context.read<HomePageViewModel>().url.toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: context.watch<HomePageViewModel>().isLoading
                          ? Center(child: loadingWidget())
                          : imageWidget(
                              imageNetworkList:
                                  context.read<HomePageViewModel>().images),
                    ),
                  ),
                ),

                // DAY TITLE
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: scheduleDayWidget(),
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/schedulepage");
                        },
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(10)),
                            width: double.maxFinite,
                            child: context
                                    .read<HomePageViewModel>()
                                    .lessonList
                                    .isEmpty
                                ? Center(
                                    child: bodyMediumText(
                                        text: context
                                            .read<HomePageViewModel>()
                                            .emptyListLesson,
                                        fontSize: 18,
                                        color: ColorManager.white))
                                : PageView.builder(
                                    controller: context
                                        .read<HomePageViewModel>()
                                        .lessonsPageController,
                                    scrollDirection: Axis.vertical,
                                    itemCount: context
                                        .read<HomePageViewModel>()
                                        .lessonList
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ListTile(
                                              title: bodyLargeText(
                                                text: context
                                                    .read<HomePageViewModel>()
                                                    .lessonList[index]
                                                    .lessonName
                                                    .toString(),
                                                fontSize: 18,
                                                color: ColorManager.white,
                                              ),
                                              subtitle: bodyMediumText(
                                                text: context
                                                        .read<HomePageViewModel>()
                                                        .days[
                                                    context
                                                        .read<
                                                            HomePageViewModel>()
                                                        .lessonList[index]
                                                        .lessonDay],
                                                fontSize: 14,
                                                color: ColorManager.white,
                                              ),
                                              trailing: Column(
                                                children: [
                                                  bodyMediumText(
                                                    text: context
                                                        .read<
                                                            HomePageViewModel>()
                                                        .lessonList[index]
                                                        .lessonClass
                                                        .toString(),
                                                    fontSize: 16,
                                                    color: ColorManager.white,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                  ),
                                                  bodyMediumText(
                                                    text: context
                                                        .read<
                                                            HomePageViewModel>()
                                                        .lessonList[index]
                                                        .lessonTime
                                                        .toString(),
                                                    fontSize: 16,
                                                    color: ColorManager.white,
                                                  ),
                                                ],
                                              )),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ),
                      )),
                ),
                // BUTTON
                context.read<HomePageViewModel>().lessonList.isEmpty ||
                        context.read<HomePageViewModel>().lessonList.length == 1
                    ? SizedBox()
                    : IconButton(
                        onPressed: () {
                          context
                              .read<HomePageViewModel>()
                              .lessonsPageController
                              .nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                        },
                        icon: Icon(Icons.arrow_drop_down),
                      ),

                //KAYDIRILABİLİR MENÜ
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            context.read<HomePageViewModel>().sosyalList.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 7.h,
                                  width: 40.w,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                ColorManager.primary)),
                                    onPressed: () {
                                      if (index == 0) {
                                        Navigator.pushNamed(
                                            context, "/communities");
                                      } else if (index == 1) {
                                        Navigator.pushNamed(
                                            context, "/socialevents");
                                      } else if (index == 2) {
                                        Navigator.pushNamed(
                                            context, "/scienceevents");
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(context
                                          .read<HomePageViewModel>()
                                          .sosyalList[index]
                                          .toString()
                                          .locale),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class scheduleDayWidget extends StatelessWidget with projectDate {
  scheduleDayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bodyMediumText(
              text: context.locale.languageCode == "tr"
                  ? currentDayTR().toString()
                  : DateFormat('EEEE').format(date),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ],
    );
  }
}

class imageWidget extends StatelessWidget {
  const imageWidget({
    super.key,
    required this.imageNetworkList,
  });

  final List imageNetworkList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: PageView.builder(
        itemCount: imageNetworkList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageNetworkList[index],
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}

class welcomingText extends StatelessWidget {
  welcomingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headlineSmallText(
          text: LocaleKeys.homepage_appBarTitle,
          fontSize: 20,
          color: ColorManager.primary,
          fontWeight: FontWeight.w500,
        ),
        headlineLargeText(
            text: FirebaseAuth.instance.currentUser!.displayName.toString(),
            fontSize: 25,
            color: ColorManager.black,
            fontWeight: FontWeight.w800)
      ],
    );
  }
}

class appBarDate extends StatelessWidget with projectDate {
  appBarDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.date_range),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: bodyMediumText(
              text: context.locale.languageCode == "tr"
                  ? currentDateTR()
                  : DateFormat('MMM-d-yyyy').format(date),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )),
        bodySmallText(
          text: context.locale.languageCode == "tr"
              ? currentDayTR().toString()
              : DateFormat('EEEE').format(date),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorManager.primary,
        )
      ],
    );
  }
}
