import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/posts_page/posts/posts_page_view.dart';

import '../../../../sources/post/post_model.dart';
import '../../../../sources/post/service.dart';
import '../../../../sources/showalertdialog.dart';

abstract class PostsPageViewModel extends State<PostsPageView>
    with TickerProviderStateMixin {
  TextEditingController? postTitleTextEditingController =
      TextEditingController();
  TextEditingController? postDescriptionTextEditingController =
      TextEditingController();

  ScrollController scrollController = ScrollController();

  String? selected_faculty = "";

  late final IPostService postService;

  final service =
      Dio(BaseOptions(baseUrl: "https://uni-social-gb6h.onrender.com/"));

  StreamController<List<Post>> streamController =
      StreamController<List<Post>>.broadcast();
  StreamController<bool> streamController2 = StreamController<bool>.broadcast();

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
    String title = postTitleTextEditingController!.value.text;
    String description = postDescriptionTextEditingController!.value.text;
    String faculty = "Fakülte";
    String email = FirebaseAuth.instance.currentUser!.email.toString();

    if (title.isNotEmpty && description.isNotEmpty && faculty.isNotEmpty) {
      await postService.postResourceItem(title, description, email);

      _bind();
      postDescriptionTextEditingController!.clear();
      postTitleTextEditingController!.clear();
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

  String src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  String appBarTitle = "AKIŞ";
}
