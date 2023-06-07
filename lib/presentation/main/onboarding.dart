import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/config/constants.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view.dart';
import 'package:social_media_app_demo/sources/colors.dart';

import 'package:flutter/material.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../cache/shared_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List texts = [
    LocaleKeys.onboarding_slide1Title,
    LocaleKeys.onboarding_slide2Title,
    LocaleKeys.onboarding_slide3Title
  ];
  List dscrp = [
    LocaleKeys.onboarding_slide1Description,
    LocaleKeys.onboarding_slide2Description,
    LocaleKeys.onboarding_slide3Description,
  ];
  SharedManager sharedManager = SharedManager();

  String appName = LocaleKeys.onboarding_appName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      print(context.locale.languageCode);
                      context.locale.languageCode == "tr"
                          ? context.setLocale(AppConstants.EN_LOCALE)
                          : context.setLocale(AppConstants.TR_LOCALE);
                    },
                    child: headlineMediumText(
                      text: context.locale.languageCode.toUpperCase(),
                      fontSize: 18,
                      color: ColorManager.black,
                    )),
                Divider(
                  color: ColorManager.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headlineMediumText(
                            text: texts[index],
                            fontSize: 30,
                            color: ColorManager.black,
                          ),
                          titleMediumText(
                            text: appName,
                            fontSize: 30,
                            color: ColorManager.primary,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 70.w,
                                child: bodyLargeText(
                                  text: dscrp[index],
                                  fontSize: 18,
                                  padding: EdgeInsets.only(top: 20),
                                ),
                              ),
                            ],
                          ),
                          index == 2
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      sharedManager.saveOnboarding(1);
                                      Navigator.pushNamed(
                                          context, "/loginpage");
                                    },
                                    child: SizedBox(
                                        width: 70.w,
                                        child: Icon(Icons.arrow_right)),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                ColorManager.primary)),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: List.generate(3, ((indexDots) {
                              return Container(
                                width: 2.w,
                                height: index == indexDots ? 5.h : 2.h,
                                margin: const EdgeInsets.only(bottom: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: index == indexDots
                                      ? ColorManager.primary
                                      : ColorManager.grey,
                                ),
                              );
                            })),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
