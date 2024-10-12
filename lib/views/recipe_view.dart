import 'package:flutter/material.dart';
import 'package:flutter_mvvm/models/recipe.dart';
import 'package:flutter_mvvm/mvvm/event_observer.dart';
import 'package:flutter_mvvm/services/recipe_service.dart';
import 'package:flutter_mvvm/view_models/recipe_view_model.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RecipeViewState();
  }
}

class _RecipeViewState extends State<RecipeView> implements EventObserver {
  final RecipeViewModel _viewModel = RecipeViewModel(RecipeService());
  bool _isLoading = false;
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
  }

  @override
  void deactivate() {
    super.deactivate();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("RecipeApp 2000"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _viewModel.loadRecipes();
          },
          child: const Icon(Icons.refresh),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recipes[index].title),
                    subtitle: Text(_recipes[index].description),
                  );
                },
              ));
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is RecipesLoadedEvent) {
      setState(() {
        _recipes = event.recipes;
      });
    }
  }
}
