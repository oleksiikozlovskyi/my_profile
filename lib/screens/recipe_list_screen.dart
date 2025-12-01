import 'package:flutter/material.dart';
import 'package:my_profile/providers/recipe_provider.dart';
import 'package:my_profile/screens/recipe_add_screen.dart';
import 'package:my_profile/screens/recipe_detail_screen.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = context.watch<RecipeProvider>().recipes;

    return Scaffold(
      appBar: AppBar(title: const Text("Книга рецептів")),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (_, i) {
          final recipe = recipes[i];
          return ListTile(
            title: Text(recipe.title),
            subtitle: Text(recipe.description),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RecipeAddScreen()),
          );
        },
      ),
    );
  }
}
