import 'package:flutter/material.dart';
import 'package:my_profile/home_task_11/services/post_service.dart';
import '../models/comment.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;

  const CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  bool loading = true;
  String? error;
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  Future<void> loadComments() async {
    try {
      comments = await PostService().getComments(widget.postId);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Коментарі")),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : error != null
                ? Center(child: Text(error!))
                : ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (_, i) {
                      final c = comments[i];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(c.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.email,
                                  style: TextStyle(color: Colors.blue)),
                              SizedBox(height: 8),
                              Text(c.body),
                            ],
                          ),
                        ),
                      );
                    },
                  )
    );
  }
}
