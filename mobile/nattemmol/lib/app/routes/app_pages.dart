import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../bindings/splash_binding.dart';
import '../bindings/recipe_binding.dart';
import '../views/splash/splash_screen.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/profile/profile_screen.dart';
import '../views/recipes/recipe_list_screen.dart';
import '../views/recipes/recipe_detail_screen.dart';
import '../views/recipes/favorites_screen.dart';
import '../views/recipes/saved_recipes_screen.dart';
import '../views/common/main_layout.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const RecipeListScreen(),
      binding: RecipeBinding(),
    ),
    GetPage(
      name: AppRoutes.mainLayout,
      page: () => const MainLayout(),
      binding: RecipeBinding(),
    ),
    GetPage(
      name: AppRoutes.recipeDetail,
      page: () => RecipeDetailScreen(recipeId: Get.parameters['id'] ?? ''),
      binding: RecipeBinding(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
      binding: RecipeBinding(),
    ),
    GetPage(
      name: AppRoutes.savedRecipes,
      page: () => const SavedRecipesScreen(),
      binding: RecipeBinding(),
    ),
  ];
}
