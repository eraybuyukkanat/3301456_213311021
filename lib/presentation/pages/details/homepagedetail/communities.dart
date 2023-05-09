import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/sources/buttons.dart';

import '../../../../sources/colors.dart';

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
  @override
  Widget build(BuildContext context) {
    String? pageTitle = "Topluluklar";
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
          )),
      body: ListView(
        children: [
          communityCard(
              title: "Selçuk Bilişim Teknolojileri Topluluğu",
              subtitle: "Selçuk Üniversitesi Bilişim Teknolojileri Topluluğu",
              memberCount: 72,
              imageLink:
                  "https://media.licdn.com/dms/image/C560BAQHCLhNpbCY7fg/company-logo_200_200/0/1619351368187?e=1688601600&v=beta&t=xYxkvLuFdb6mmpGMFxLUDFoV8Nq5jMoULdSLBY3cozg"),
          communityCard(
            title: "ESN",
            subtitle: "Erasmus Student Network",
            imageLink:
                "https://deedmob-prod.imgix.net/o-prod/undefined/3107743_1621338992133%40600x334.png?fit=fill&fill=solid",
            memberCount: 50,
          ),
          communityCard(
              title: "GİKAT",
              subtitle: "Girişimcilik ve Kariyer Topluluğu",
              memberCount: 152,
              imageLink:
                  "https://media.licdn.com/dms/image/C4D0BAQGQC5dNaoGtjQ/company-logo_200_200/0/1540469680396?e=1688601600&v=beta&t=YMG77ynLCNO38aPR7M3oqIdtLoU7xv00jR0EvDTzmmo"),
          communityCard(
              title: "Siber Güvenlik Topluluğu",
              subtitle: "Selçuk Siber Güvenlik Topluluğu",
              memberCount: 87,
              imageLink:
                  "https://pbs.twimg.com/profile_images/1097150372018294784/HvaB81T4_400x400.jpg"),
          communityCard(
              title: "Selçuk Sepya Topluluğu",
              subtitle: "Selçuk Sepya Yatırım Topluluğu",
              memberCount: 72,
              imageLink:
                  "https://yt3.googleusercontent.com/rNpLCqvsNB1t0HWcL76MJ5kAdDYRT4O9RwTG7LMzzvmq3Ok-2nDoC-3MEzyqma1osjWBkpTawg=s900-c-k-c0x00ffffff-no-rj"),
          communityCard(
              title: "SÜİAT",
              subtitle: "Selçuk Üniversitesi İnsansız Araçlar Topluluğu",
              memberCount: 152,
              imageLink:
                  "https://media.licdn.com/dms/image/C4D0BAQG6Dmz6g8XtRA/company-logo_200_200/0/1667930064021?e=1688601600&v=beta&t=Z1taXl0Kpp6e0V-57VdmFTqgLbULel2EN3lDKbl_lE4"),
        ],
      ),
    );
  }
}

class communityCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? imageLink;
  final int? memberCount;

  const communityCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageLink,
    required this.memberCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title!),
        subtitle: Text(subtitle!),
        trailing: Icon(Icons.arrow_forward_ios),
        leading: Image.network(imageLink!),
        contentPadding: const EdgeInsets.all(10),
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                String? joinText = "Topluluğa Katıl";
                String? closeText = "KAPAT";
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 100,
                            width: 130,
                            child: Center(
                              child: Text(
                                this.title!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: ColorManager.black),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            child: Image.network(imageLink!),
                          ),
                        ],
                      ),
                      Text(
                        this.subtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: ColorManager.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Üye Sayısı: ${this.memberCount}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: ColorManager.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: double.maxFinite,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                            ),
                            onPressed: null,
                            child: Text(
                              joinText,
                            )),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      widthSizedButton(
                          color: ColorManager.redAccent,
                          text: closeText,
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
