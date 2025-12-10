import 'dart:convert';

import 'package:my_profile/home_task_11/models/comment.dart';

import '../models/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse("$baseUrl/posts"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception("Помилка завантаження постів");
    }
  }

  Future<List<Comment>> getComments(int postId) async {
    final response =
        await http.get(Uri.parse("$baseUrl/posts/$postId/comments"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw Exception("Помилка завантаження коментарів");
    }
  }

  Future<bool> deletePost(int postId) async {
    final response = await http.delete(Uri.parse("$baseUrl/posts/$postId"));

    return response.statusCode == 200;
  }
}
