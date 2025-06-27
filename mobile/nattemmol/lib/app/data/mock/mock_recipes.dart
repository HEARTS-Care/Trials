import '../models/recipe.dart';

class MockRecipes {
  static List<Recipe> getRecipes() {
    final List<String> cuisines = [
      'Italian',
      'Indian',
      'Japanese',
      'Thai',
      'Mexican',
      'French',
      'American',
      'Chinese',
      'Greek',
      'Spanish'
    ];
    final List<String> authors = [
      'Chef Marco',
      'Chef Priya',
      'Chef Hiroshi',
      'Chef Anna',
      'Chef Juan',
      'Chef Marie',
      'Chef John',
      'Chef Li',
      'Chef Nikos',
      'Chef Sofia'
    ];
    final List<String> difficulties = ['Easy', 'Medium', 'Hard'];

    // Real food images from Unsplash
    final List<String> foodImages = [
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400', // Pizza
      'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400', // Curry
      'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400', // Sushi
      'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=400', // Pad Thai
      'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?w=400', // Pasta
      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400', // Burger
      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400', // Salad
      'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=400', // Soup
      'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=400', // Dessert
      'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=400', // Breakfast
    ];

    final List<Recipe> recipes = [];

    // Recipe names and descriptions
    final List<Map<String, String>> recipeData = [
      {
        'name': 'Margherita Pizza',
        'description':
            'Classic Italian pizza with fresh mozzarella, basil, and tomato sauce.',
        'tags': 'pizza, italian, vegetarian'
      },
      {
        'name': 'Chicken Tikka Masala',
        'description':
            'Creamy and spicy Indian curry with tender chicken pieces.',
        'tags': 'curry, chicken, spicy'
      },
      {
        'name': 'California Roll Sushi',
        'description':
            'Fresh sushi roll with avocado, cucumber, and crab meat.',
        'tags': 'sushi, seafood, healthy'
      },
      {
        'name': 'Pad Thai Noodles',
        'description':
            'Stir-fried rice noodles with tofu, vegetables, and tangy sauce.',
        'tags': 'noodles, thai, vegetarian'
      },
      {
        'name': 'Spaghetti Carbonara',
        'description': 'Creamy pasta with eggs, cheese, and crispy pancetta.',
        'tags': 'pasta, italian, quick'
      },
      {
        'name': 'Classic Burger',
        'description':
            'Juicy beef burger with lettuce, tomato, and special sauce.',
        'tags': 'burger, american, beef'
      },
      {
        'name': 'Greek Salad',
        'description':
            'Fresh salad with feta cheese, olives, and Mediterranean vegetables.',
        'tags': 'salad, greek, healthy'
      },
      {
        'name': 'Tomato Basil Soup',
        'description': 'Creamy tomato soup with fresh basil and garlic.',
        'tags': 'soup, italian, vegetarian'
      },
      {
        'name': 'Chocolate Lava Cake',
        'description':
            'Warm chocolate cake with molten center, served with vanilla ice cream.',
        'tags': 'dessert, chocolate, sweet'
      },
      {
        'name': 'Avocado Toast',
        'description':
            'Toasted bread topped with mashed avocado, eggs, and herbs.',
        'tags': 'breakfast, healthy, vegetarian'
      },
    ];

    for (int i = 1; i <= 120; i++) {
      final recipeIndex = i % recipeData.length;
      final recipe = recipeData[recipeIndex];
      final tags = recipe['tags']!.split(', ');

      recipes.add(
        Recipe(
          id: i.toString(),
          name: '${recipe['name']} #$i',
          description: recipe['description']!,
          imageUrl: foodImages[recipeIndex],
          cuisine: cuisines[i % cuisines.length],
          tags: tags,
          prepTime: 10 + (i % 20),
          cookTime: 15 + (i % 30),
          servings: 2 + (i % 5),
          difficulty: difficulties[i % difficulties.length],
          ingredients: [
            Ingredient(
                name: 'Main Ingredient',
                amount: (100 + i).toDouble(),
                unit: 'g'),
            Ingredient(
                name: 'Seasoning', amount: (5 + i % 10).toDouble(), unit: 'g'),
            Ingredient(
                name: 'Vegetables',
                amount: (50 + i % 30).toDouble(),
                unit: 'g'),
          ],
          instructions: [
            'Prepare the main ingredients for ${recipe['name']}',
            'Cook according to traditional methods',
            'Serve hot and enjoy!',
          ],
          nutritionInfo: NutritionInfo(
            calories: 200 + (i % 300),
            protein: 10 + (i % 20),
            carbohydrates: 30 + (i % 40),
            fat: 5 + (i % 15),
            fiber: 2 + (i % 5),
            sugar: 1 + (i % 10),
            sodium: 100 + (i % 500),
          ),
          authorId: 'chef${(i % authors.length) + 1}',
          authorName: authors[i % authors.length],
          createdAt: DateTime.now().subtract(Duration(days: i)),
          updatedAt: DateTime.now(),
          rating: 3.5 + ((i % 15) * 0.1),
          reviewCount: 10 + (i % 200),
          isVegetarian: i % 2 == 0,
          isVegan: i % 3 == 0,
          isGlutenFree: i % 4 == 0,
        ),
      );
    }
    return recipes;
  }

  static List<String> getCuisines() {
    return ['All', 'Italian', 'Indian', 'Japanese', 'Thai', 'Mexican', 'Greek'];
  }
}
