import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/events_model.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/socialevents_view.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

abstract class SocialEventsViewModel extends State<SocialEventsView> {
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
                    .children[0].children[0].nodes[0].text
                    .toString(),
                place: element.children[0].children[0].children[0].children[1]
                    .children[0].children[0].nodes[2].text
                    .toString(),
                date: element.children[0].children[0].children[0].children[1]
                    .children[2].nodes[1].text
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
}
