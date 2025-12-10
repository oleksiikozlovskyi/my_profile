import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.description,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              const Text("Інгредієнти",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              ...recipe.ingredients.map((i) => Text("- $i")).toList(),
              const SizedBox(height: 20),
              const Text("Інструкції",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              ...recipe.instructions.map((i) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text("- $i"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
