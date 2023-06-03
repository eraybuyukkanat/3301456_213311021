import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/menu/events_model.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/menu/menu_view.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Menu {
  String? item1;
  String? item2;
  String? item3;
  String? item4;
  String? cal;
  String? day;
  String? emptyText;
  bool? isThere;
  Menu(
      {this.cal,
      this.item1,
      this.item2,
      this.item3,
      this.item4,
      this.day,
      this.emptyText,
      this.isThere});
}

abstract class MenuViewModel extends State<MenuView> {
  List<Menu> menu = [];

  bool isLoading = false;
  changeIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  var url = Uri.parse("https://yemek.selcuk.edu.tr/Menu/MenuGetir");

  Future<void> getDays() async {
    changeIsLoading();
    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("table-fixed")[0]
        .getElementsByTagName("td")
        .forEach(
      (element) {
        setState(() {
          element.children.length == 0
              ? menu.add(Menu(
                  day: "",
                  emptyText: "Öğün Yok",
                  isThere: false,
                ))
              : menu.add(Menu(
                  day: element.children[0].text.toString(),
                  item1: element.children[1].children[0].children[0].children[0]
                      .children[0].text
                      .trim()
                      .toString(),
                  item2: element.children[1].children[0].children[0].children[0]
                      .children[1].text
                      .trim()
                      .toString(),
                  item3: element.children[1].children[0].children[0].children[0]
                      .children[2].text
                      .trim()
                      .toString(),
                  item4: element.children[1].children[0].children[0].children[0]
                      .children[3].text
                      .trim()
                      .toString(),
                  cal: element.children[1].children[1].children[0].children[0]
                      .children[0].text
                      .trim()
                      .toString()));
        });
      },
    );
    changeIsLoading();
  }

  @override
  void initState() {
    super.initState();
    getDays();
  }
}
