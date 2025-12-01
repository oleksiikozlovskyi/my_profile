import 'package:flutter/material.dart';
import 'package:my_profile/models/recipe.dart';
import 'package:my_profile/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class RecipeAddScreen extends StatefulWidget {
  const RecipeAddScreen({super.key});

  @override
  State<RecipeAddScreen> createState() => _RecipeAddScreenState();
}

class _RecipeAddScreenState extends State<RecipeAddScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Додати рецепт")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Назва"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Опис"),
            ),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(
                  labelText: "Інгредієнти (кожен з нового рядка)"),
              maxLines: 5,
            ),
            TextField(
              controller: instructionController,
              decoration: const InputDecoration(
                  labelText: "Інструкції (кожна з нового рядка)"),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final recipe = Recipe(
                  title: titleController.text,
                  description: descriptionController.text,
                  ingredients: ingredientsController.text.split("\n"),
                  instructions: instructionController.text.split("\n"),
                );

                context.read<RecipeProvider>().addRecipe(recipe);

                Navigator.pop(context);
              },
              child: const Text("Зберегти"),
            )
          ],
        ),
      ),
    );
  }
}
