import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostsProvider with ChangeNotifier {
  final PostService _service = PostService();

  List<Post> posts = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadPosts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      posts = await _service.getPosts();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> deletePost(int id) async {
    final success = await _service.deletePost(id);
    if (success) {
      posts.removeWhere((item) => item.id == id);
      notifyListeners();
    }
    return success;
  }
}
