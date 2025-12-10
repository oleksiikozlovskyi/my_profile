import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_task_8/screens/todo_homepager.dart';
import 'home_task_9/providers/recipe_provider.dart';
import 'home_task_9/screens/recipe_list_screen.dart';
import 'home_task_10/async_example.dart';
import 'home_task_11/screens/posts_screen.dart';
import 'home_task_11/providers/posts_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => PostsProvider()..loadPosts()),
      ],
      child: const MyApp(),
    ),
  );
}

const String ht_8 = '/home_task_8';
const String ht_9 = '/home_task_9';
const String ht_10 = '/home_task_10';
const String ht_11 = '/home_task_11';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        ht_8: (_) => ToDoHomePage(),
        ht_9: (_) => RecipeListScreen(),
        ht_10: (_) => AsyncExample(),
        ht_11: (_) => PostsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home tasks')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TaskButton(title: 'Home task #8', route: ht_8),
            TaskButton(title: 'Home task #9', route: ht_9),
            TaskButton(title: 'Home task #10', route: ht_10),
            TaskButton(title: 'Home task #11', route: ht_11),
          ],
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  final String title;
  final String route;

  const TaskButton({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(18)),
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
