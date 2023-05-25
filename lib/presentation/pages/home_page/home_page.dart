import 'dart:async';
import 'package:intl/intl.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:social_media_app_demo/config/database.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:social_media_app_demo/sources/texts.dart';

import '../../../sources/colors.dart';
import '../settings_page/pages/schedule/lesson_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, projectDate {
  DatabaseManager databaseManager = DatabaseManager();
  List<Lesson> lessonList = [];

  Future<void> getTodayList() async {
    lessonList = await databaseManager.getTodayList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTodayList();
  }

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

  String? appBarTitle = "SAYFAM";
  String? tabbarText1 = "ÜNİVERSİTE DUYURULARI";
  String? listViewTitle1 = "Sosyal";
  String? listViewTitle2 = "Ders";
  String emptyListLesson = "Bugün hiç dersin yok";
  PageController pageController = PageController();
  PageController lessonsPageController = PageController();

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: imageWidget(imageNetworkList: imageNetworkList),
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
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(10)),
                        width: double.maxFinite,
                        child: lessonList.isEmpty
                            ? Center(
                                child: bodyMediumText(
                                    text: emptyListLesson,
                                    fontSize: 18,
                                    color: ColorManager.white))
                            : PageView.builder(
                                controller: lessonsPageController,
                                scrollDirection: Axis.vertical,
                                itemCount: lessonList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                          title: bodyLargeText(
                                            text: lessonList[index]
                                                .lessonName
                                                .toString(),
                                            fontSize: 18,
                                            color: ColorManager.white,
                                          ),
                                          subtitle: bodyMediumText(
                                            text: lessonList[index]
                                                .lessonDay
                                                .toString(),
                                            fontSize: 14,
                                            color: ColorManager.white,
                                          ),
                                          trailing: Column(
                                            children: [
                                              bodyMediumText(
                                                text: lessonList[index]
                                                    .lessonClass
                                                    .toString(),
                                                fontSize: 16,
                                                color: ColorManager.white,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                              ),
                                              bodyMediumText(
                                                text: lessonList[index]
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
                    )),
              ),
              // BUTTON
              lessonList.isEmpty || lessonList.length == 1
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        lessonsPageController.nextPage(
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
                      itemCount: sosyalList.length,
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
              ),
              Spacer(
                flex: 1,
              ),
            ],
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
              text: currentDayTR().toString(),
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
          text: "Tekrar Hoşgeldin,",
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
              text: currentDateTR(),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )),
        bodySmallText(
          text: currentDayTR().toString(),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorManager.primary,
        )
      ],
    );
  }
}
