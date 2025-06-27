import 'package:get/get.dart';
import '../models/recipe.dart';
import '../mock/mock_recipes.dart';

class RecipeProvider extends GetxController {
  final RxList<Recipe> _allRecipes = <Recipe>[].obs;
  final RxList<Recipe> _filteredRecipes = <Recipe>[].obs;
  final RxString _selectedCuisine = 'All'.obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isLoading = false.obs;

  List<Recipe> get allRecipes => _allRecipes;
  List<Recipe> get filteredRecipes => _filteredRecipes;
  String get selectedCuisine => _selectedCuisine.value;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;
  List<String> get availableCuisines => MockRecipes.getCuisines();

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    _isLoading.value = true;

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1000));

    _allRecipes.value = MockRecipes.getRecipes();
    _filteredRecipes.value = _allRecipes;

    _isLoading.value = false;
  }

  void filterByCuisine(String cuisine) {
    _selectedCuisine.value = cuisine;
    _applyFilters();
  }

  void searchRecipes(String query) {
    _searchQuery.value = query;
    _applyFilters();
  }

  void _applyFilters() {
    List<Recipe> filtered = _allRecipes;

    // Filter by cuisine
    if (_selectedCuisine.value != 'All') {
      filtered = filtered
          .where((recipe) => recipe.cuisine == _selectedCuisine.value)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((recipe) =>
              recipe.name
                  .toLowerCase()
                  .contains(_searchQuery.value.toLowerCase()) ||
              recipe.description
                  .toLowerCase()
                  .contains(_searchQuery.value.toLowerCase()) ||
              recipe.tags.any((tag) =>
                  tag.toLowerCase().contains(_searchQuery.value.toLowerCase())))
          .toList();
    }

    _filteredRecipes.value = filtered;
  }

  void clearFilters() {
    _selectedCuisine.value = 'All';
    _searchQuery.value = '';
    _filteredRecipes.value = _allRecipes;
  }

  Recipe? getRecipeById(String id) {
    try {
      return _allRecipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Recipe> getRecipesByCuisine(String cuisine) {
    return _allRecipes.where((recipe) => recipe.cuisine == cuisine).toList();
  }

  List<Recipe> getVegetarianRecipes() {
    return _allRecipes.where((recipe) => recipe.isVegetarian).toList();
  }

  List<Recipe> getQuickRecipes() {
    return _allRecipes.where((recipe) => recipe.totalTime <= 30).toList();
  }

  List<Recipe> getTopRatedRecipes() {
    List<Recipe> sorted = List.from(_allRecipes);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(5).toList();
  }

  // Pagination: Get a page of filtered recipes
  List<Recipe> getRecipesPage(int page, int pageSize) {
    final start = page * pageSize;
    final end = (start + pageSize) > _filteredRecipes.length
        ? _filteredRecipes.length
        : (start + pageSize);
    if (start >= _filteredRecipes.length) return [];
    return _filteredRecipes.sublist(start, end);
  }
}
