import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/events_model.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/socialevents_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';

import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../sources/colors.dart';

class SocialEventsView extends StatefulWidget {
  const SocialEventsView({super.key});

  @override
  State<SocialEventsView> createState() => _SocialEventsViewState();
}

class _SocialEventsViewState extends State<SocialEventsView> {
  @override
  Widget build(BuildContext context) {
    String? pageTitle = LocaleKeys.socialevents_socialAppBar;
    return ChangeNotifierProvider<SocialEventsViewModel>(
      create: (context) => SocialEventsViewModel(),
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
              fontSize: 30,
              color: ColorManager.black,
            )),
        body: SafeArea(
            child: context.watch<SocialEventsViewModel>().isLoading
                ? Center(child: loadingWidget())
                : ListView.builder(
                    itemCount:
                        context.read<SocialEventsViewModel>().events.length,
                    itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            color: ColorManager.white,
                            child: Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height: 40.h,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          opacity: 150,
                                          image: NetworkImage(
                                              "https://scckonya.com/" +
                                                  context
                                                      .watch<
                                                          SocialEventsViewModel>()
                                                      .events[index]
                                                      .image),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorManager.black
                                              .withOpacity(0.6)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                headlineMediumText(
                                                  text: context
                                                      .read<
                                                          SocialEventsViewModel>()
                                                      .events[index]
                                                      .title,
                                                  fontSize: 32,
                                                  color: ColorManager.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                bodyLargeText(
                                                  text: context
                                                      .read<
                                                          SocialEventsViewModel>()
                                                      .events[index]
                                                      .place
                                                      .toString(),
                                                  fontSize: 20,
                                                  color: ColorManager.white,
                                                  fontWeight: FontWeight.w400,
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                widthSizedButton(
                                                  color: ColorManager.primary,
                                                  text: "Detaylar",
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            SocialEventsViewModel>()
                                                        .launchLink(
                                                            "https://scckonya.com" +
                                                                context
                                                                    .read<
                                                                        SocialEventsViewModel>()
                                                                    .events[
                                                                        index]
                                                                    .detailLink
                                                                    .toString());
                                                  },
                                                ),
                                                bodyMediumText(
                                                  text: context
                                                      .read<
                                                          SocialEventsViewModel>()
                                                      .events[index]
                                                      .date,
                                                  fontSize: 18,
                                                  color: ColorManager.white,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))),
      ),
    );
  }
}
