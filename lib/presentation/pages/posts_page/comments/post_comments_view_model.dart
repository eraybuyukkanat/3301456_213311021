import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/posts_page/comments/post_comments_view.dart';

import '../../../../sources/comment/comment_model.dart';
import '../../../../sources/comment/service.dart';
import '../../../../sources/showalertdialog.dart';

abstract class PostCommentsViewModel extends State<PostCommentsView> {
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

  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> postComments() async {
    String commentText = commentTextEditingController.value.text;
    String id = widget.id.toString();
    if (commentText.isNotEmpty) {
      await commentService.postCommentItem(
          commentText, id, FirebaseAuth.instance.currentUser!.email.toString());

      commentTextEditingController.clear();
      _bind();
    } else {
      showAlertDialog("Boş bırakamazsınız..", context);
    }
  }

  Future<void> deleteComment(id) async {
    await commentService.deleteCommentItem(widget.id, id);

    _bind();
  }

  Future<List<Comment>> fetch(String id) async {
    return (await commentService.fetchCommentItem(id))?.comments ?? [];
  }

  _bind() async {
    changeLoading();
    resources = await fetch(widget.id);
    streamController.sink.add(resources.reversed.toList());
    changeLoading();
  }

  String? pageTitle = "Yorumlar";
}
