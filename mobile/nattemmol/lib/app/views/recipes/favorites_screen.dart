import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recipe_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header section
            _buildHeader(recipeController),
            // Recipe list
            Expanded(
              child: _buildFavoriteList(recipeController),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(RecipeController recipeController) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Favorites',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                    '${recipeController.getFavoriteRecipes().length} favorite recipes',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteList(RecipeController recipeController) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Obx(() {
        final favoriteRecipes = recipeController.getFavoriteRecipes();

        if (favoriteRecipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorite recipes yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start adding recipes to your favorites!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.home),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667eea),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Browse Recipes'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => recipeController.refreshRecipes(),
          color: const Color(0xFF667eea),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            itemCount: favoriteRecipes.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final recipe = favoriteRecipes[index];
              return RecipeCard(
                recipe: recipe,
                onTap: () {
                  Get.toNamed('${AppRoutes.recipeDetail}?id=${recipe.id}');
                },
              );
            },
          ),
        );
      }),
    );
  }
}
