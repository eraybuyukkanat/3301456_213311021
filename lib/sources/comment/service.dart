import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'comment_model.dart';

//FUNCTIONS - GET - POST - PUT - DELETE

abstract class ICommentService {
  ICommentService(this.dio);
  final Dio dio;

  Future<commentModel?> fetchCommentItem(String id);
  Future<commentModel?> postCommentItem(
      String commentText, String id, String email);
  Future<commentModel?> deleteCommentItem(String postId, String commentId);
}

class CommentService extends ICommentService {
  CommentService(Dio dio) : super(dio);

  @override
  Future<commentModel?> fetchCommentItem(String id) async {
    final response = await dio.get('comments/${id}');
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return commentModel.fromJson(jsonBody);
      }
    }
    return null;
  }

  Future<commentModel?> postCommentItem(
      String commentText, String id, String email) async {
    final response = await dio.post('createComment/${id}',
        data: {'description': commentText, 'email': email});
  }

  @override
  Future<commentModel?> deleteCommentItem(
      String postId, String commentId) async {
    final response = await dio.delete("deleteComment/${postId}/${commentId}");
  }
}
