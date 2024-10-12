import 'package:flutter_mvvm/models/recipe.dart';
import 'package:flutter_mvvm/mvvm/view_model.dart';
import 'package:flutter_mvvm/services/recipe_service.dart';
import 'package:flutter_mvvm/mvvm/event_observer.dart';

class RecipeViewModel extends EventViewModel {
  final RecipeService _repository;

  RecipeViewModel(this._repository);

  void loadRecipes() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadRecipes().then((value) {
      notify(RecipesLoadedEvent(recipes: value));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class RecipesLoadedEvent extends ViewEvent {
  final List<Recipe> recipes;

  RecipesLoadedEvent({required this.recipes}) : super("RecipesLoadedEvent");
}

class RecipeCreatedEvent extends ViewEvent {
  final Recipe recipe;

  RecipeCreatedEvent(this.recipe) : super("RecipeCreatedEvent");
}
