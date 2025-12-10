import 'package:flutter/material.dart';
import 'home_task_8/screens/todo_homepager.dart';
import 'package:provider/provider.dart';

import 'home_task_10/async_example.dart';
import 'home_task_9/providers/recipe_provider.dart';
import 'home_task_9/screens/recipe_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
      child: const MyApp(),
    ),
  );
}

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
        '/home_task_8': (_) => ToDoHomePage(),
        '/home_task_9': (_) => RecipeListScreen(),
        '/home_task_10': (_) => AsyncExample(),
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
            TaskButton(title: 'Home task #8', route: '/home_task_8'),
            TaskButton(title: 'Home task #9', route: '/home_task_9'),
            TaskButton(title: 'Home task #10', route: '/home_task_10'),
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
