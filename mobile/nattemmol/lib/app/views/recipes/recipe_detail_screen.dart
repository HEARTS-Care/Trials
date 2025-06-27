import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recipe_controller.dart';
import '../../data/models/recipe.dart';
import '../../routes/app_routes.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();
    final Recipe? recipe = recipeController.getRecipeById(recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Not Found'),
          backgroundColor: const Color(0xFF667eea),
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('Recipe not found'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Image
          _buildSliverAppBar(recipe, recipeController),
          // Recipe Content
          SliverToBoxAdapter(
            child: _buildRecipeContent(recipe, recipeController),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(Recipe recipe, RecipeController recipeController) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: const Color(0xFF667eea),
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Hero Image
            Image.network(
              recipe.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.restaurant,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Recipe Info Overlay
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.rating} (${recipe.reviewCount} reviews)',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.totalTime} min',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Favorite Button
        Obx(() {
          final isFavorite = recipeController.isFavorite(recipe.id);
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => recipeController.toggleFavorite(recipe.id),
          );
        }),
        // Save Button
        Obx(() {
          final isSaved = recipeController.isSaved(recipe.id);
          return IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? Colors.blue : Colors.white,
            ),
            onPressed: () => recipeController.toggleSaved(recipe.id),
          );
        }),
        // Share Button
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            Get.snackbar(
              'Share',
              'Sharing ${recipe.name}...',
              backgroundColor: const Color(0xFF667eea),
              colorText: Colors.white,
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecipeContent(Recipe recipe, RecipeController recipeController) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Info Cards
          _buildQuickInfoCards(recipe),
          const SizedBox(height: 30),

          // Description
          _buildSection(
            'Description',
            Text(
              recipe.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Ingredients
          _buildSection(
            'Ingredients',
            Column(
              children: recipe.ingredients
                  .map((ingredient) => _buildIngredientItem(ingredient))
                  .toList(),
            ),
          ),
          const SizedBox(height: 30),

          // Instructions
          _buildSection(
            'Instructions',
            Column(
              children: recipe.instructions.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final instruction = entry.value;
                return _buildInstructionItem(index, instruction);
              }).toList(),
            ),
          ),
          const SizedBox(height: 30),

          // Nutrition Information
          _buildSection(
            'Nutrition Information',
            _buildNutritionInfo(recipe.nutritionInfo),
          ),
          const SizedBox(height: 30),

          // Author Info
          _buildAuthorInfo(recipe),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildQuickInfoCards(Recipe recipe) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            'Prep Time',
            '${recipe.prepTime} min',
            Icons.timer,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Cook Time',
            '${recipe.cookTime} min',
            Icons.restaurant,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Servings',
            '${recipe.servings}',
            Icons.people,
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildIngredientItem(Ingredient ingredient) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF667eea),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              ingredient.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${ingredient.amount} ${ingredient.unit}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(int stepNumber, String instruction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF667eea),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              instruction,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionInfo(NutritionInfo nutrition) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF667eea).withOpacity(0.1),
            const Color(0xFF764ba2).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF667eea).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutritionItem('Calories', '${nutrition.calories}', 'kcal'),
              _buildNutritionItem('Protein', '${nutrition.protein}g', ''),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutritionItem('Carbs', '${nutrition.carbohydrates}g', ''),
              _buildNutritionItem('Fat', '${nutrition.fat}g', ''),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutritionItem('Fiber', '${nutrition.fiber}g', ''),
              _buildNutritionItem('Sugar', '${nutrition.sugar}g', ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String label, String value, String unit) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF667eea),
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo(Recipe recipe) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFF667eea),
            child: Text(
              recipe.authorName[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'By ${recipe.authorName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Created ${_formatDate(recipe.createdAt)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
