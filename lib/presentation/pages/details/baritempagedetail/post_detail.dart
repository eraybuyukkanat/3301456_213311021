import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/sources/post/service.dart';

import '../../../../sources/colors.dart';
import '../../../../sources/comment/comment_model.dart';
import '../../../../sources/comment/service.dart';
import '../../../../sources/post/post_model.dart';
import '../../../../sources/showalertdialog.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage(
      {super.key,
      required this.index,
      required this.id,
      required this.title,
      required this.description,
      required this.email,
      required this.createdAt});
  final int index;
  final String title;
  final String id;
  final String description;
  final String email;
  final String createdAt;
  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  TextEditingController commentTextEditingController = TextEditingController();

  late final ICommentService commentService;

  StreamController<List<Comment>> streamController =
      StreamController<List<Comment>>.broadcast();

  final service =
      Dio(BaseOptions(baseUrl: "https://uni-social-gb6h.onrender.com/"));

  List<Comment> resources = [];

  @override
  void initState() {
    super.initState();
    commentService = CommentService(service); //BASEURL

    _bind();
  }

  Future<void> postComments() async {
    String commentText = commentTextEditingController.value.text;
    String id = widget.id.toString();
    if (commentText.isNotEmpty) {
      await commentService.postCommentItem(commentText, id);

      commentTextEditingController.clear();
    } else {
      showAlertDialog("Boş bırakamazsınız..", context);
    }
    _bind();
  }

  Future<List<Comment>> fetch(String id) async {
    return (await commentService.fetchCommentItem(id))?.comments ?? [];
  }

  _bind() async {
    resources = await fetch(widget.id);
    streamController.sink.add(resources.reversed.toList());
  }

  String? pageTitle = "Yorumlar";
  String? src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 3.h,
            elevation: 10,
            backgroundColor: ColorManager.white,
            toolbarHeight: 10.h,
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.black,
              ),
            ),
            title: Text(
              pageTitle!,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: ColorManager.black),
            )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 8.h,
                        width: 80.w,
                        child: TextFormField(
                          controller: commentTextEditingController,
                          decoration: InputDecoration(
                              hintText: "Yorumunuzu giriniz...",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            postComments();
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: StreamBuilder<List<Comment>>(
                      stream: streamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return SpinKitFadingCircle(
                            color: ColorManager.black,
                            size: 40.0,
                          );
                        }
                        return snapshot.data?.length != 0
                            ? ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          commentView(snapshot, index, context),
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                "Henüz hiç yorum yok",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ));
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}

/*

                      */

Container commentView(
    AsyncSnapshot<List<Comment>> resources, int index, BuildContext context) {
  return Container(
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
    ),
    width: double.maxFinite,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(5)),
              //POST TITLE
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        resources.data![index].description ?? "HATA",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PopupMenuButton<String>(
                          color: ColorManager.white,
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                child: Text("Gönderiyi Sil"),
                                value: "aa",
                                onTap: () {},
                              )
                            ];
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
