import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';

class UserProvider extends GetxController {
  final _storage = GetStorage();
  final Rxn<User> _currentUser = Rxn<User>();
  final RxList<String> _favoriteRecipes = <String>[].obs;
  final RxList<String> _savedRecipes = <String>[].obs;
  final RxBool _isLoading = false.obs;

  User? get currentUser => _currentUser.value;
  List<String> get favoriteRecipes => _favoriteRecipes;
  List<String> get savedRecipes => _savedRecipes;
  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _currentUser.value != null;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final userData = _storage.read('user');
    if (userData != null) {
      _currentUser.value = User.fromJson(userData);
      _favoriteRecipes.value =
          List<String>.from(userData['favoriteRecipes'] ?? []);
      _savedRecipes.value = List<String>.from(userData['savedRecipes'] ?? []);
    }
  }

  Future<void> saveUserData() async {
    if (_currentUser.value != null) {
      final userData = _currentUser.value!.toJson();
      userData['favoriteRecipes'] = _favoriteRecipes;
      userData['savedRecipes'] = _savedRecipes;
      await _storage.write('user', userData);
    }
  }

  void updateUser(User user) {
    _currentUser.value = user;
    saveUserData();
  }

  void addToFavorites(String recipeId) {
    if (!_favoriteRecipes.contains(recipeId)) {
      _favoriteRecipes.add(recipeId);
      saveUserData();
    }
  }

  void removeFromFavorites(String recipeId) {
    _favoriteRecipes.remove(recipeId);
    saveUserData();
  }

  void addToSaved(String recipeId) {
    if (!_savedRecipes.contains(recipeId)) {
      _savedRecipes.add(recipeId);
      saveUserData();
    }
  }

  void removeFromSaved(String recipeId) {
    _savedRecipes.remove(recipeId);
    saveUserData();
  }

  bool isFavorite(String recipeId) {
    return _favoriteRecipes.contains(recipeId);
  }

  bool isSaved(String recipeId) {
    return _savedRecipes.contains(recipeId);
  }

  void clearUserData() {
    _currentUser.value = null;
    _favoriteRecipes.clear();
    _savedRecipes.clear();
    _storage.remove('user');
  }

  void updatePreferences(Map<String, dynamic> preferences) {
    if (_currentUser.value != null) {
      final updatedUser = _currentUser.value!.copyWith(
        preferences: preferences,
      );
      _currentUser.value = updatedUser;
      saveUserData();
    }
  }

  Map<String, dynamic> getPreferences() {
    return _currentUser.value?.preferences ?? {};
  }
}
