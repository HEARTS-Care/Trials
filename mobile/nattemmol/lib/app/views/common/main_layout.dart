import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/drawer_menu.dart';
import '../recipes/recipe_list_screen.dart';
import '../recipes/favorites_screen.dart';
import '../recipes/saved_recipes_screen.dart';
import '../profile/profile_screen.dart';
import '../../controllers/recipe_controller.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const RecipeListScreen(),
    const FavoritesScreen(),
    const SavedRecipesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawerMenu(),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
