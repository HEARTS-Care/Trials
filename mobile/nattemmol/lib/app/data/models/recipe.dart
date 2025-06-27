class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String cuisine;
  final List<String> tags;
  final int prepTime; // in minutes
  final int cookTime; // in minutes
  final int servings;
  final String difficulty; // Easy, Medium, Hard
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final NutritionInfo nutritionInfo;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double rating;
  final int reviewCount;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;

  int get totalTime => prepTime + cookTime;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.cuisine,
    this.tags = const [],
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.difficulty,
    required this.ingredients,
    required this.instructions,
    required this.nutritionInfo,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isGlutenFree = false,
  });

  // Factory constructor to create Recipe from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      cuisine: json['cuisine'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      prepTime: json['prepTime'] ?? 0,
      cookTime: json['cookTime'] ?? 0,
      servings: json['servings'] ?? 1,
      difficulty: json['difficulty'] ?? 'Medium',
      ingredients: (json['ingredients'] as List?)
              ?.map((e) => Ingredient.fromJson(e))
              .toList() ??
          [],
      instructions: List<String>.from(json['instructions'] ?? []),
      nutritionInfo: NutritionInfo.fromJson(json['nutritionInfo'] ?? {}),
      authorId: json['authorId'] ?? '',
      authorName: json['authorName'] ?? '',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isVegetarian: json['isVegetarian'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isGlutenFree: json['isGlutenFree'] ?? false,
    );
  }

  // Convert Recipe to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'cuisine': cuisine,
      'tags': tags,
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'difficulty': difficulty,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'instructions': instructions,
      'nutritionInfo': nutritionInfo.toJson(),
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'rating': rating,
      'reviewCount': reviewCount,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'isGlutenFree': isGlutenFree,
    };
  }

  // Create a copy of Recipe with updated fields
  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? cuisine,
    List<String>? tags,
    int? prepTime,
    int? cookTime,
    int? servings,
    String? difficulty,
    List<Ingredient>? ingredients,
    List<String>? instructions,
    NutritionInfo? nutritionInfo,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? rating,
    int? reviewCount,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      cuisine: cuisine ?? this.cuisine,
      tags: tags ?? this.tags,
      prepTime: prepTime ?? this.prepTime,
      cookTime: cookTime ?? this.cookTime,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
    );
  }

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, cuisine: $cuisine)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recipe && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Ingredient {
  final String name;
  final double amount;
  final String unit;
  final String? notes;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    this.notes,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      unit: json['unit'] ?? '',
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
      'notes': notes,
    };
  }

  @override
  String toString() {
    return '$amount $unit $name${notes != null ? ' ($notes)' : ''}';
  }
}

class NutritionInfo {
  final int calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;

  NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
  });

  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: json['calories'] ?? 0,
      protein: (json['protein'] ?? 0.0).toDouble(),
      carbohydrates: (json['carbohydrates'] ?? 0.0).toDouble(),
      fat: (json['fat'] ?? 0.0).toDouble(),
      fiber: (json['fiber'] ?? 0.0).toDouble(),
      sugar: (json['sugar'] ?? 0.0).toDouble(),
      sodium: (json['sodium'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
    };
  }
}
