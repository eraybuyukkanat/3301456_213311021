import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/events_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:social_media_app_demo/sources/loading_bar.dart';
import '../../../../sources/colors.dart';

class SocialEventsPage extends StatefulWidget {
  const SocialEventsPage({super.key});

  @override
  State<SocialEventsPage> createState() => _SocialEventsPageState();
}

class _SocialEventsPageState extends State<SocialEventsPage> {
  var url = Uri.parse("https://scckonya.com/Etkinlik/EtkinlikListesi");
  bool isLoading = false;
  changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  List<EventModel> events = [];
  Future<void> getData() async {
    changeLoading();
    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("HomeBodyEventsFirstLine")[0]
        .getElementsByClassName("HomeBodyEventsSmallBox EventBoxItem")
        .forEach(
      (element) {
        setState(() {
          events.add(
            EventModel(
                image: element.attributes["style"].toString().split('\'')[1],
                title: element.children[0].children[0].children[0].children[1]
                    .children[0].children[0].text
                    .toString(),
                date: element.children[0].children[0].children[0].children[1]
                    .children[2].text
                    .toString()),
          );
        });
      },
    );
    changeLoading();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemCount: events.length,
                  itemBuilder: (context, index) => Card(
                        elevation: 10,
                        color: ColorManager.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network("https://scckonya.com/" +
                                  events[index].image),
                            ),
                            Text(events[index].title),
                            Text(events[index].date),
                          ],
                        ),
                      ))),
    );
  }
}
