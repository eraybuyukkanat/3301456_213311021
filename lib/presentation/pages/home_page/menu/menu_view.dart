import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/menu/menu_view_model.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import 'package:path_provider/path_provider.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  String pageTitle = LocaleKeys.menupage_menuAppBar;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuViewModel>(
      create: (context) => MenuViewModel(),
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
            title: headlineMediumText(
              text: pageTitle,
              fontSize: 32,
              color: ColorManager.black,
            )),
        body: SafeArea(
            child: context.watch<MenuViewModel>().isLoading
                ? Center(child: loadingWidget())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: context.read<MenuViewModel>().menu.length,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                            elevation: 10,
                            color: ColorManager.white,
                            child: Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorManager.yellow),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          headlineMediumText(
                                            text: context
                                                .read<MenuViewModel>()
                                                .menu[index]
                                                .day
                                                .toString(),
                                            fontSize: 22,
                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                context
                                            .read<MenuViewModel>()
                                            .menu[index]
                                            .isThere ==
                                        false
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: bodyMediumText(
                                                text: context
                                                    .read<MenuViewModel>()
                                                    .menu[index]
                                                    .emptyText
                                                    .toString(),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            bodyMediumText(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                text: context
                                                    .read<MenuViewModel>()
                                                    .menu[index]
                                                    .item1
                                                    .toString(),
                                                fontSize: 13),
                                            bodyMediumText(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                text: context
                                                    .read<MenuViewModel>()
                                                    .menu[index]
                                                    .item2
                                                    .toString(),
                                                fontSize: 13),
                                            bodyMediumText(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                text: context
                                                    .read<MenuViewModel>()
                                                    .menu[index]
                                                    .item3
                                                    .toString(),
                                                fontSize: 12),
                                            bodyMediumText(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                text: context
                                                    .read<MenuViewModel>()
                                                    .menu[index]
                                                    .item4
                                                    .toString(),
                                                fontSize: 13),
                                            bodyMediumText(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                text: context
                                                    .read<MenuViewModel>()
                                                    .menu[index]
                                                    .cal
                                                    .toString(),
                                                fontSize: 13),
                                          ],
                                        ),
                                      ),
                              ],
                            ))))),
      ),
    );
  }
}
