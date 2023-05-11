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
  LoginScreen? authScreen = LoginScreen();
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
      /*appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 5.w,
          elevation: 0,
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
      */
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              // APPBAR
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.maxFinite,
                    height: 2.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tekrar Hoşgeldin,",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          color: ColorManager.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${FirebaseAuth.instance.currentUser!.displayName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          color: ColorManager.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "12 Mayıs",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ),

              // IMAGES
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
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
                  ),
                ),
              ),
              // TITLE
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ders Programı",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 18),
                            ),
                            Text(
                              "Tümünü Göster",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorManager.primary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // DERS PROGRAMI
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 10,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pazartesi",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: double.maxFinite,
                                height: 3,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("13.00"),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text("Mühendislik Matematiği"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("15.00"),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text("Mühendislik Matematiği"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("13.00"),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text("Mühendislik Matematiği"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("13.00"),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text("Mühendislik Matematiği"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              //KAYDIRILABİLİR MENÜ
              Expanded(
                flex: 1,
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
                                              ColorManager.primary!)),
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
            ],
          ),
        ),
      ),
    );
  }
}
