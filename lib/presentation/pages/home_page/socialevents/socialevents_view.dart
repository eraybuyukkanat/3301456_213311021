import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/events_model.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/socialevents_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';

import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import '../../../../sources/colors.dart';

class SocialEventsView extends StatefulWidget {
  const SocialEventsView({super.key});

  @override
  State<SocialEventsView> createState() => _SocialEventsViewState();
}

class _SocialEventsViewState extends SocialEventsViewModel {
  @override
  Widget build(BuildContext context) {
    String? pageTitle = "Sosyal Etkinlikler";
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
        ),
      ),
      body: SafeArea(
          child: isLoading
              ? Center(child: loadingWidget())
              : ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) => Padding(
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
                                                events[index].image),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                                text: events[index].title,
                                                fontSize: 32,
                                                color: ColorManager.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              bodyLargeText(
                                                text: events[index]
                                                    .place
                                                    .toString(),
                                                fontSize: 20,
                                                color: ColorManager.white,
                                                fontWeight: FontWeight.w400,
                                              )
                                            ],
                                          ),
                                          bodyMediumText(
                                            text: events[index].date,
                                            fontSize: 18,
                                            color: ColorManager.white,
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
    );
  }
}
