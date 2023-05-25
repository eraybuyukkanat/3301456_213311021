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
  TextEditingController? postEditTitleTextEditingController =
      TextEditingController();
  TextEditingController? postEditDescriptionTextEditingController =
      TextEditingController();

  StreamController<bool> EditTitleController =
      StreamController<bool>.broadcast();
  StreamController<bool> EditDescriptionController =
      StreamController<bool>.broadcast();

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
  void dispose() {
    postTitleTextEditingController!.dispose();
    postDescriptionTextEditingController!.dispose();
    postEditTitleTextEditingController!.dispose();
    postEditDescriptionTextEditingController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    postService = PostService(service); //BASEURL

    _bind();
  }

  String isEditingNow = "";
  void changeIsEditingNow(id, oldTitle, oldDescription) {
    postEditDescriptionTextEditingController!.text = oldDescription;
    postEditTitleTextEditingController!.text = oldTitle;

    setState(() {
      isEditingNow = id;
    });
  }

  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<List<Post>> fetch() async {
    return (await postService.fetchResourceItem())?.post ?? [];
  }

  Future<void> postValues() async {
    String title = postTitleTextEditingController!.value.text;
    String description = postDescriptionTextEditingController!.value.text;
    String faculty = "Fakülte";
    String email = FirebaseAuth.instance.currentUser!.email.toString();
    Navigator.pop(context);

    if (title.isNotEmpty && description.isNotEmpty && faculty.isNotEmpty) {
      await postService.postResourceItem(title, description, email,
          FirebaseAuth.instance.currentUser!.displayName.toString());

      _bind();
      postDescriptionTextEditingController!.clear();
      postTitleTextEditingController!.clear();
    } else {
      showAlertDialog("Boş bırakamazsınız..", context);
    }
  }

  Future<void> updatePost(
      postId, newTitle, newDescription, email, creator, oldDescription) async {
    changeLoading();

    await postService.updateResourceItem(
        postId, newTitle, newDescription, email, creator);
    _bind();
    isEditingNow = "";

    changeLoading();

    postEditTitleTextEditingController!.clear();
    postEditDescriptionTextEditingController!.clear();
  }

  Future<void> deletePost(id) async {
    changeLoading();
    await postService.deleteResourceItem(id);
    changeLoading();
    _bind();
  }

  _bind() async {
    changeLoading();
    resources = await fetch();
    streamController.sink.add(resources.reversed.toList());
    changeLoading();
  }

  String src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  String appBarTitle = "AKIŞ";
}
