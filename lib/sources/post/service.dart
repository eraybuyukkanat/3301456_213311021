import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'post_model.dart';

//FUNCTIONS - GET - POST - PUT - DELETE

abstract class IPostService {
  IPostService(this.dio);
  final Dio dio;

  Future<postModel?> fetchResourceItem();
  Future<postModel?> postResourceItem(
      String title, String description, String email);
  Future<void> deleteResourceItem(id);
}

class PostService extends IPostService {
  PostService(Dio dio) : super(dio);

  @override
  Future<postModel?> fetchResourceItem() async {
    final response = await dio.get('allPosts');
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return postModel.fromJson(jsonBody);
      }
    }
    return null;
  }

  Future<postModel?> postResourceItem(
      String title, String description, String email) async {
    final response = await dio.post('createPost',
        data: {'title': title, 'description': description, 'email': email});
  }

  Future<void> deleteResourceItem(id) async {
    final response = await dio.delete("deletePost/${id}");
  }
}
