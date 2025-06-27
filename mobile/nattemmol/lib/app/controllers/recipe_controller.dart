import 'package:get/get.dart';
import '../data/providers/recipe_provider.dart';
import '../data/providers/user_provider.dart';
import '../data/models/recipe.dart';

class RecipeController extends GetxController {
  final RecipeProvider _recipeProvider = Get.find();
  final UserProvider _userProvider = Get.find();

  final RxBool _isLoading = false.obs;
  final RxString _selectedCuisine = 'All'.obs;
  final RxString _searchQuery = ''.obs;
  final RxList<Recipe> _displayedRecipes = <Recipe>[].obs;

  final int _pageSize = 20;
  int _currentPage = 0;
  bool _isLoadingMore = false;

  bool get isLoading => _isLoading.value;
  String get selectedCuisine => _selectedCuisine.value;
  String get searchQuery => _searchQuery.value;
  List<Recipe> get displayedRecipes => _displayedRecipes;
  List<String> get availableCuisines => _recipeProvider.availableCuisines;
  bool get isLoggedIn => _userProvider.isLoggedIn;

  @override
  void onInit() {
    super.onInit();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    _isLoading.value = true;
    await _recipeProvider.loadRecipes();
    _displayedRecipes.clear();
    _currentPage = 0;
    await loadNextPage();
    _isLoading.value = false;
  }

  Future<void> loadNextPage() async {
    if (_isLoadingMore || _isLoading.value) return;
    _isLoadingMore = true;
    final nextPage = _recipeProvider.getRecipesPage(_currentPage, _pageSize);
    if (nextPage.isNotEmpty) {
      _displayedRecipes.addAll(nextPage);
      _currentPage++;
    }
    _isLoadingMore = false;
  }

  void filterByCuisine(String cuisine) {
    _selectedCuisine.value = cuisine;
    _recipeProvider.filterByCuisine(cuisine);
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  void searchRecipes(String query) {
    _searchQuery.value = query;
    _recipeProvider.searchRecipes(query);
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  void clearFilters() {
    _selectedCuisine.value = 'All';
    _searchQuery.value = '';
    _recipeProvider.clearFilters();
    _displayedRecipes.clear();
    _currentPage = 0;
    loadNextPage();
  }

  void toggleFavorite(String recipeId) {
    if (_userProvider.isFavorite(recipeId)) {
      _userProvider.removeFromFavorites(recipeId);
    } else {
      _userProvider.addToFavorites(recipeId);
    }
  }

  void toggleSaved(String recipeId) {
    if (_userProvider.isSaved(recipeId)) {
      _userProvider.removeFromSaved(recipeId);
    } else {
      _userProvider.addToSaved(recipeId);
    }
  }

  bool isFavorite(String recipeId) {
    return _userProvider.isFavorite(recipeId);
  }

  bool isSaved(String recipeId) {
    return _userProvider.isSaved(recipeId);
  }

  Recipe? getRecipeById(String id) {
    return _recipeProvider.getRecipeById(id);
  }

  List<Recipe> getTopRatedRecipes() {
    return _recipeProvider.getTopRatedRecipes();
  }

  List<Recipe> getQuickRecipes() {
    return _recipeProvider.getQuickRecipes();
  }

  List<Recipe> getVegetarianRecipes() {
    return _recipeProvider.getVegetarianRecipes();
  }

  List<Recipe> getFavoriteRecipes() {
    return _recipeProvider.allRecipes
        .where((recipe) => _userProvider.isFavorite(recipe.id))
        .toList();
  }

  List<Recipe> getSavedRecipes() {
    return _recipeProvider.allRecipes
        .where((recipe) => _userProvider.isSaved(recipe.id))
        .toList();
  }

  Future<void> refreshRecipes() async {
    await _loadRecipes();
  }
}
