import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/auth/auth.dart';
import 'package:social_media_app_demo/main.dart';
import 'package:social_media_app_demo/presentation/authpages/login.dart';
import 'package:social_media_app_demo/presentation/pages/details/homepagedetail/communities.dart';
import 'package:social_media_app_demo/presentation/pages/details/homepagedetail/socialevents.dart';
import 'package:social_media_app_demo/sources/post/service.dart';

import '../../sources/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AuthScreen? authScreen = AuthScreen();
  Map sosyalList = {
    0: "Topluluklar",
    1: "Sosyal Etkinlikler",
    2: "Yakındaki Seminerler",
    3: "Konserler"
  };
  Map dersList = {
    0: "Akademik Takvim",
    1: "Ders Programı",
    2: "Notlar",
  };

  List imageNetworkList = [
    "https://webadmin.selcuk.edu.tr/contents/GenelDosyalar/slider/11846/swis0/YO%CC%88K_slider_638162127146312176.jpg",
    "https://webadmin.selcuk.edu.tr/contents/GenelDosyalar/slider/10950/swis0/Deprem_Slider_638127661897348673.jpg",
    "https://webadmin.selcuk.edu.tr/contents/GenelDosyalar/slider/10490/swis0/Nakdi_Yard%C4%B1m_Slider_638116419399283047.jpg",
    "https://webadmin.selcuk.edu.tr/contents/GenelDosyalar/slider/11518/swis0/I%CC%87lk_19'da_Slider_638150166776577771.jpg",
    "https://webadmin.selcuk.edu.tr/contents/GenelDosyalar/slider/11541/swis0/Teknokent_Slider_638150815641478840.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    String? appBarTitle = "SAYFAM";
    String? tabbarText1 = "ÜNİVERSİTE DUYURULARI";
    String? tabbarText2 = "YEMEKHANE MENÜSÜ";
    String? menuTitle = "BUGÜNÜN MENÜSÜ";
    String? date = "06/04/2023";
    String? menuItem1 = "- KARIŞIK KIZARTMA -";
    String? menuItem2 = "- TAVUK SOTE -";
    String? menuItem3 = "- YOĞURT -";
    String? menuItem4 = "- EZOGELİN ÇORBASI -";
    String? listViewTitle1 = "Sosyal";
    String? listViewTitle2 = "Ders";
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 5.w,
          elevation: 10,
          backgroundColor: ColorManager.white,
          toolbarHeight: 10.h,
          centerTitle: false,
          title: Text(
            appBarTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          )),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            color: ColorManager.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  labelPadding: const EdgeInsets.only(right: 20, left: 20),
                  controller: _tabController,
                  labelColor: ColorManager.black,
                  unselectedLabelColor: ColorManager.grey,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator:
                      CircleTabIndicator(color: ColorManager.black!, radius: 4),
                  tabs: [
                    Tab(text: tabbarText1),
                    Tab(
                      text: tabbarText2,
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            height: 30.h,
            width: double.infinity,
            child: SizedBox(
              child: Container(
                child: TabBarView(controller: _tabController, children: [
                  PageView.builder(
                    itemCount: imageNetworkList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: double.maxFinite,
                        child: Container(
                          child: Image.network(
                            imageNetworkList[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  menuTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: ColorManager.black,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              date,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              menuItem1,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              menuItem2,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              menuItem3,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              menuItem4,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listViewTitle1,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            height: 10.h,
            width: double.maxFinite,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sosyalList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 7.h,
                          width: 45.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        ColorManager.primary!)),
                            onPressed: () {
                              if (index == 0) {
                                Navigator.pushNamed(context, "/communities");
                              } else if (index == 1) {
                                Navigator.pushNamed(context, "/socialevents");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(sosyalList[index].toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listViewTitle2,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            height: 10.h,
            width: double.maxFinite,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dersList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 7.h,
                          width: 45.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        ColorManager.primary!)),
                            onPressed: () {
                              if (index == 0) {}
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(dersList[index].toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color? color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(radius: radius, color: color!);
  }
}

class _CirclePainter extends BoxPainter {
  final Color? color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color!;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
