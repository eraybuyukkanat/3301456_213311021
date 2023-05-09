import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/details/baritempagedetail/post_detail.dart';
import 'package:social_media_app_demo/sources/post/service.dart';
import 'package:social_media_app_demo/sources/post/post_model.dart';
import '../../sources/buttons.dart';
import '../../sources/colors.dart';
import '../../sources/showalertdialog.dart';

const List<String> facultyList = <String>[
  'Teknoloji Fakültesi',
  'Hukuk Fakültesi',
  'Tıp Fakültesi',
  'Edebiyat Fakültesi',
  'Ziraat Fakültesi',
  'Sağlık Bilimleri Fakültesi'
];

class BarItemPage extends StatefulWidget {
  const BarItemPage({super.key});

  @override
  State<BarItemPage> createState() => _BarItemPageState();
}

class _BarItemPageState extends State<BarItemPage> {
  String? dropdownValue = facultyList.first;

  TextEditingController? _postTitleTextEditingController =
      TextEditingController();
  TextEditingController? _postDescriptionTextEditingController =
      TextEditingController();

  String? selected_faculty = "";

  late final IPostService postService;

  final service =
      Dio(BaseOptions(baseUrl: "https://uni-social-gb6h.onrender.com/"));

  StreamController<List<Post>> streamController =
      StreamController<List<Post>>.broadcast();
  StreamController<bool> streamController2 = StreamController<bool>.broadcast();
  bool _isLoading = false;
  _changeLoading() {
    streamController2.sink.add(_isLoading);
  }

  DropdownButtonFormField _dropDownFiltreKismi(String _selectedField) {
    return DropdownButtonFormField(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: ColorManager.primary,
        ),
        decoration: InputDecoration(label: Text(_selectedField)),
        items: facultyList.map((values) {
          return DropdownMenuItem(
            child: Text(values),
            value: values,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selected_faculty = value.toString();
          });
        });
  }

  List<Post> resources = [];

  @override
  void initState() {
    super.initState();
    postService = PostService(service); //BASEURL
    _bind();
  }

  Future<List<Post>> fetch() async {
    return (await postService.fetchResourceItem())?.post ?? [];
  }

  Future<void> postValues() async {
    _changeLoading();
    String title = _postTitleTextEditingController!.value.text;
    String description = _postDescriptionTextEditingController!.value.text;
    String faculty = "Fakülte";
    String email = FirebaseAuth.instance.currentUser!.email.toString();

    if (title.isNotEmpty && description.isNotEmpty && faculty.isNotEmpty) {
      await postService.postResourceItem(title, description, email);

      _bind();
      _postDescriptionTextEditingController!.clear();
      _postTitleTextEditingController!.clear();
    } else {
      showAlertDialog("Boş bırakamazsınız..", context);
    }

    Navigator.pop(context);
  }

  Future<void> deletePost(id) async {
    await postService.deleteResourceItem(id);
    _bind();
  }

  _bind() async {
    resources = await fetch();
    streamController.sink.add(resources.reversed.toList());
  }

  String? src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  @override
  Widget build(BuildContext context) {
    String? appBarTitle = "AKIŞ";
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 5.w,
          elevation: 10,
          backgroundColor: ColorManager.white,
          toolbarHeight: 10.h,
          centerTitle: false,
          title: Text(
            appBarTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  addPostPage(context);
                },
                icon: Icon(
                  Icons.add,
                  color: ColorManager.black,
                ),
              ),
            )
          ]),

      //BODY
      body: StreamBuilder<List<Post>>(
          stream: streamController.stream,
          builder: (context, resources) {
            if (resources.data == null) {
              return Center(
                  child: CircularProgressIndicator(
                color: ColorManager.primary,
              ));
            }
            return resources.data?.length != 0
                ? ListView.builder(
                    itemCount: resources.data!.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        elevation: 0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: ColorManager.white,
                            ),
                            width: double.maxFinite,
                            height: 50.h,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 10.h,
                                        decoration: BoxDecoration(
                                            color: ColorManager.primary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  resources
                                                          .data![index].title ??
                                                      "HATA",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorManager
                                                              .white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                resources.data![index].email ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.email
                                                    ? PopupMenuButton<String>(
                                                        color:
                                                            ColorManager.white,
                                                        itemBuilder:
                                                            (BuildContext
                                                                context) {
                                                          return [
                                                            PopupMenuItem(
                                                              child: Text(
                                                                  "Gönderiyi Sil"),
                                                              value: "aa",
                                                              onTap: () {
                                                                deletePost(
                                                                    resources
                                                                        .data![
                                                                            index]
                                                                        .sId);
                                                              },
                                                            )
                                                          ];
                                                        })
                                                    : SizedBox(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        "${resources.data![index].description}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FirebaseAuth.instance.currentUser!
                                                .displayName ??
                                            "HATA",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: ColorManager.black,
                                                fontSize: 15),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            resources.data![index].email ??
                                                "HATA",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: ColorManager.black,
                                                    fontSize: 15),
                                          ),
                                          Container(
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  ColorManager.primary,
                                              child: CircleAvatar(
                                                radius: 35,
                                                child: ClipOval(
                                                  child: Image.network(
                                                    src!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: IconButton(
                                              icon: Icon(Icons.comment),
                                              iconSize: 30,
                                              color: ColorManager.black,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PostDetailPage(
                                                      index: index,
                                                      title: resources
                                                          .data![index].title
                                                          .toString(),
                                                      description: resources
                                                          .data![index]
                                                          .description
                                                          .toString(),
                                                      email: resources
                                                          .data![index].email
                                                          .toString(),
                                                      createdAt: resources
                                                          .data![index]
                                                          .createdAt
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        resources.data![index].createdAt ??
                                            "HATA",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: ColorManager.black,
                                                fontSize: 15),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(child: Text("Henüz hiç gönderi yok :("));
          }),
    );
  }

  Future<dynamic> addPostPage(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          String? pageTitle = "Gönderi Paylaş";
          String? title = "Konu Başlığı";
          String? description = "Açıklama";
          String? buttonText = "YAYINLA";

          return StreamBuilder<bool>(
              stream: streamController2.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.only(top: 60, right: 20, left: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pageTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 25),
                            ),
                            snapshot.hasData
                                ? CircularProgressIndicator(
                                    color: ColorManager.primary,
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Form(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(title,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                            StreamBuilder<String?>(
                                builder: (context, snapshot) {
                              String? hintText1 = 'Gönderi başlığı giriniz...';
                              return TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: hintText1,
                                ),
                                controller: _postTitleTextEditingController,
                                maxLength: 25,
                              );
                            }),
                          ],
                        ),
                      )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Form(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(description,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              StreamBuilder<String?>(
                                  builder: (context, snapshot) {
                                String? hintText2 =
                                    'Gönderi açıklaması giriniz...';
                                return TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: hintText2,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLength: 200,
                                  controller:
                                      _postDescriptionTextEditingController,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      widthSizedButton(
                        color: ColorManager.primary,
                        text: buttonText,
                        onPressed: () {
                          postValues();
                        },
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
