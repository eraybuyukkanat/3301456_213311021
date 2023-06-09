import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/posts_page/comments/post_comments_view.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';

import '../../../../sources/comment/comment_model.dart';
import '../../../../sources/comment/service.dart';
import '../../../../sources/showalertdialog.dart';

class PostCommentsViewModel extends ChangeNotifier {
  PostCommentsViewModel(widgetId) {
    this.widgetId = widgetId;
    commentService = CommentService(service); //BASEURL
    _bind();
  }
  late String widgetId;

  TextEditingController commentTextEditingController = TextEditingController();

  TextEditingController commentEditEditingController = TextEditingController();

  late final ICommentService commentService;

  StreamController<List<Comment>> streamController =
      StreamController<List<Comment>>.broadcast();

  final service =
      Dio(BaseOptions(baseUrl: "https://uni-social-gb6h.onrender.com/"));

  List<Comment> resources = [];

  String isEditingNow = "";
  void changeIsEditingNow(commentId, oldDescription) {
    commentEditEditingController.text = oldDescription;

    isEditingNow = commentId;
    notifyListeners();
  }

  bool isLoading = false;
  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> postComments(widgetId) async {
    String commentText = commentTextEditingController.value.text;
    String id = widgetId.toString();
    if (commentText.isNotEmpty) {
      await commentService.postCommentItem(
          commentText, id, FirebaseAuth.instance.currentUser!.email.toString());

      commentTextEditingController.clear();
      _bind();
    } else {
      print("test");
    }
  }

  Future<void> deleteComment(widgetId, id) async {
    await commentService.deleteCommentItem(widgetId, id);
    _bind();
  }

  Future<void> updateComment(widgetId, commentId, description) async {
    await commentService.updateCommentItem(widgetId, commentId, description);
    _bind();
    isEditingNow = "";
    notifyListeners();
  }

  Future<List<Comment>> fetch(String id) async {
    return (await commentService.fetchCommentItem(id))?.comments ?? [];
  }

  _bind() async {
    changeLoading();
    resources = await fetch(widgetId);
    streamController.sink.add(resources.reversed.toList());
    changeLoading();
  }

  String pageTitle = LocaleKeys.commentsPage_commentsAppBar;
}
