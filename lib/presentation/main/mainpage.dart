import 'package:flutter/material.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';

import '../pages/posts_page/posts/posts_page_view.dart';
import '../pages/home_page/home_page_view.dart';
import '../pages/settings_page/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List? pages = [
    HomePageView(),
    PostsPageView(),
    SettingsPage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: pages![currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: ColorManager.grey,
        selectedItemColor: ColorManager.black,
        showSelectedLabels: false,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        showUnselectedLabels: false,
        elevation: 0,
        onTap: onTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            label: "Posts",
            icon: Icon(Icons.post_add),
          ),
          BottomNavigationBarItem(
            label: "MyPage",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
