import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import '../../../../sources/colors.dart';
import '../../../../sources/comment/comment_model.dart';
import '../../../../sources/comment/service.dart';
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

    Navigator.pop(context);
  }

  Future<List<Comment>> fetch(String id) async {
    return (await commentService.fetchCommentItem(id))?.comments ?? [];
  }

  _bind() async {
    resources = await fetch(widget.id);
    streamController.sink.add(resources.reversed.toList());
  }

  String? pageTitle = "Gönderi Detayı";
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: postWidget(
                widget: widget,
                src: src,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Yorumlar",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 7.h,
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
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: StreamBuilder<List<Comment>>(
                  stream: streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return SpinKitFadingCircle(
                        color: ColorManager.black,
                        size: 40.0,
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              height: 10.h,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.primary),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data![index].description!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize: 15,
                                                color: ColorManager.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class postWidget extends StatelessWidget {
  const postWidget({
    super.key,
    required this.widget,
    required this.src,
  });

  final PostDetailPage widget;

  final String? src;

  @override
  Widget build(BuildContext context) {
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
        color: ColorManager.white,
      ),
      width: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10.h,
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "${widget.description}",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? "HATA",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.black, fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.email,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: ColorManager.black, fontSize: 15),
                    ),
                    Container(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: ColorManager.primary,
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
                  ],
                ),
                Text(
                  widget.createdAt,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorManager.black, fontSize: 15),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*

                      */