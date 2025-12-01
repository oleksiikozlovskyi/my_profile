import 'package:flutter/material.dart';
import 'package:my_profile/providers/recipe_provider.dart';
import 'package:my_profile/screens/recipe_list_screen.dart';
import 'package:provider/provider.dart';

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
      title: 'Книга рецептів',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RecipeListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
