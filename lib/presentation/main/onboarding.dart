import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view.dart';
import 'package:social_media_app_demo/sources/colors.dart';

import 'package:flutter/material.dart';
import 'package:social_media_app_demo/sources/texts.dart';

import '../../cache/shared_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List texts = ["Uygulamaya Hoşgeldin!", "Kampüs Elinde!", "Hemen Katıl!"];
  List dscrp = [
    "Uygulama ile üniversitenden haberdar olabilir, topluluklara katılabilirsin. Akademik takvim, bilimsel ve sosyal etkinlikleri keşfedebilirsin.",
    "Bölümüne göre istediğin alanları takip et, sınav haftası hazırlıksız yakalanma. Arkadaşlarınla çalış.",
    "Devam etmek için butona tıkla, hesabın var ise giriş yap yok ise üye ol.",
  ];
  SharedManager sharedManager = SharedManager();

  String appName = "Üniversitem";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            height: double.maxFinite,
            child: Container(
              margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
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
                      Container(
                        width: 80.w,
                        child: bodyLargeText(
                          text: dscrp[index],
                          fontSize: 18,
                          padding: EdgeInsets.only(top: 20),
                        ),
                      ),
                      index == 2
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  sharedManager.saveOnboarding(1);
                                  Navigator.pushNamed(context, "/loginpage");
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
                  }))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
