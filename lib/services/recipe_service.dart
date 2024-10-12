import 'package:flutter_mvvm/models/recipe.dart';

class RecipeService {
  final List<Recipe> _recipeList = [
    Recipe(
        0,
        "Study MVVM",
        "In order to avoid ugly state management librares and collect continuously technical debt, I should study proper state management patterns",
        false),
  ];

  void addRecipe(Recipe recipe) {
    recipe.id = _recipeList.length;
    _recipeList.add(recipe);
  }

  void removeRecipe(Recipe recipe) {
    _recipeList.remove(recipe);
  }

  void updateRecipe(Recipe recipe) {
    _recipeList[_recipeList.indexWhere((element) => element.id == recipe.id)] =
        recipe;
  }

  Future<List<Recipe>> loadRecipes() async {
    // Simulate a http request
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_recipeList);
  }
}
