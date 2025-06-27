import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recipe_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/recipe_card.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !recipeController.isLoading) {
        recipeController.loadNextPage();
      }
    });

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
            // Search and filter section
            _buildSearchAndFilter(recipeController),
            // Recipe list
            Expanded(
              child: _buildRecipeList(recipeController, scrollController),
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
                'Recipe Master',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                    '${recipeController.displayedRecipes.length} recipes found',
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
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    // TODO: Implement advanced search
                  },
                ),
              ),
              const SizedBox(width: 12),
              Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(RecipeController recipeController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              onChanged: recipeController.searchRecipes,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: Obx(() {
                  if (recipeController.searchQuery.isNotEmpty) {
                    return IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () => recipeController.searchRecipes(''),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Cuisine filter
          SizedBox(
            height: 50,
            child: Obx(() {
              final cuisines = recipeController.availableCuisines;
              final selectedCuisine = recipeController.selectedCuisine;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cuisines.length,
                itemBuilder: (context, index) {
                  final cuisine = cuisines[index];
                  final isSelected = selectedCuisine == cuisine;

                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => recipeController.filterByCuisine(cuisine),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          cuisine,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF667eea)
                                : Colors.white,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRecipeList(
      RecipeController recipeController, ScrollController scrollController) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Obx(() {
        if (recipeController.isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667eea)),
                ),
                SizedBox(height: 16),
                Text(
                  'Loading recipes...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        if (recipeController.displayedRecipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No recipes found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search or filters',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: recipeController.clearFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667eea),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Clear Filters'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => recipeController.refreshRecipes(),
          color: const Color(0xFF667eea),
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            itemCount: recipeController.displayedRecipes.length + 1,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < recipeController.displayedRecipes.length) {
                final recipe = recipeController.displayedRecipes[index];
                return RecipeCard(
                  recipe: recipe,
                  onTap: () {
                    Get.toNamed('${AppRoutes.recipeDetail}?id=${recipe.id}');
                  },
                );
              } else {
                // Show loading indicator at the bottom if more data is being loaded
                return Obx(() => recipeController.isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF667eea)),
                          ),
                        ),
                      )
                    : const SizedBox.shrink());
              }
            },
          ),
        );
      }),
    );
  }
}
