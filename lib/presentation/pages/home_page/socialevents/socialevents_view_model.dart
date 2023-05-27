import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/events_model.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/socialevents_view.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart';

abstract class SocialEventsViewModel extends State<SocialEventsView> {
  var url = Uri.parse("https://scckonya.com/Etkinlik/EtkinlikListesi");

  bool isLoading = false;
  changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> launchLink(link) async {
    final Uri _url = Uri.parse(link);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
        setState(
          () {
            events.add(
              EventModel(
                  image: element.attributes["style"].toString().split('\'')[1],
                  title: element.children[0].children[0].children[0].children[1]
                      .children[0].children[0].nodes[0].text
                      .toString(),
                  place: element.children[0].children[0].children[0].children[1]
                      .children[0].children[0].nodes[2].text
                      .toString(),
                  date: element.children[0].children[0].children[0].children[1].children[2].nodes[1].text
                      .toString(),
                  detailLink: element
                              .children[0]
                              .children[0]
                              .children[0]
                              .children[1]
                              .children[4]
                              .children[0]
                              .children
                              .length ==
                          2
                      ? element
                          .children[0]
                          .children[0]
                          .children[0]
                          .children[1]
                          .children[4]
                          .children[0]
                          .children[1]
                          .children[0]
                          .attributes["href"]
                          .toString()
                      : element
                          .children[0]
                          .children[0]
                          .children[0]
                          .children[1]
                          .children[4]
                          .children[0]
                          .children[0]
                          .children[0]
                          .attributes["href"]
                          .toString()),
            );
          },
        );
      },
    );
    changeLoading();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}
