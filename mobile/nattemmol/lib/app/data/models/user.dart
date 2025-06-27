class User {
  final String id;
  final String username;
  final String email;
  final String? profileImage;
  final String? bio;
  final List<String> favoriteRecipes;
  final List<String> savedRecipes;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic> preferences;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
    this.bio,
    this.favoriteRecipes = const [],
    this.savedRecipes = const [],
    required this.createdAt,
    this.lastLoginAt,
    this.preferences = const {},
  });

  // Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
      bio: json['bio'],
      favoriteRecipes: List<String>.from(json['favoriteRecipes'] ?? []),
      savedRecipes: List<String>.from(json['savedRecipes'] ?? []),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      preferences: Map<String, dynamic>.from(json['preferences'] ?? {}),
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profileImage': profileImage,
      'bio': bio,
      'favoriteRecipes': favoriteRecipes,
      'savedRecipes': savedRecipes,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'preferences': preferences,
    };
  }

  // Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? profileImage,
    String? bio,
    List<String>? favoriteRecipes,
    List<String>? savedRecipes,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
      savedRecipes: savedRecipes ?? this.savedRecipes,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
