import 'package:social_media_app_demo/presentation/authpages/login.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/texts.dart';

import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List? texts = ["Uygulamaya Hoşgeldin!", "Kampüs Elinde!", "Hemen Katıl!"];
  List? dscrp = [
    "Uygulama ile üniversitenden haberdar olabilir, topluluklara katılabilirsin. Akademik takvim, bilimsel ve sosyal etkinlikleri keşfedebilirsin.",
    "Bölümüne göre istediğin alanları takip et, sınav haftası hazırlıksız yakalanma. Arkadaşlarınla çalış.",
    "Devam etmek için butona tıkla, hesabın var ise giriş yap yok ise üye ol.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: texts!.length,
        itemBuilder: (context, index) {
          return Container(
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
                      AppLargeText(
                        text: texts![index],
                      ),
                      AppText(
                        text: "Üniversitem",
                        color: ColorManager.primary,
                        size: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 250,
                        child: AppText(text: dscrp![index]),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      index == 2
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/authpage");
                              },
                              child: SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: Icon(Icons.arrow_right)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          ColorManager.primary!)),
                            )
                          : SizedBox(),
                    ],
                  ),
                  Column(
                      children: List.generate(3, ((indexDots) {
                    return Container(
                      width: 8,
                      height: index == indexDots ? 25 : 8,
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
