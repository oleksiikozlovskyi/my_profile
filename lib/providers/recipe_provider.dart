import 'package:flutter/material.dart';
import 'package:my_profile/models/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }
}