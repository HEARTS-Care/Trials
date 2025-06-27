import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';

class CustomDrawerMenu extends StatelessWidget {
  const CustomDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Drawer(
      child: Container(
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
        child: Column(
          children: [
            // User Profile Section
            _buildUserProfile(authController),
            const SizedBox(height: 20),

            // Navigation Items
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildNavItem(
                        icon: Icons.home,
                        title: 'Home',
                        subtitle: 'Browse all recipes',
                        onTap: () {
                          Get.back();
                          Get.offAllNamed(AppRoutes.home);
                        },
                      ),
                      _buildNavItem(
                        icon: Icons.favorite,
                        title: 'Favorites',
                        subtitle: 'Your favorite recipes',
                        onTap: () {
                          Get.back();
                          Get.toNamed(AppRoutes.favorites);
                        },
                      ),
                      _buildNavItem(
                        icon: Icons.bookmark,
                        title: 'Saved Recipes',
                        subtitle: 'Recipes you saved',
                        onTap: () {
                          Get.back();
                          Get.toNamed(AppRoutes.savedRecipes);
                        },
                      ),
                      _buildNavItem(
                        icon: Icons.search,
                        title: 'Search',
                        subtitle: 'Find specific recipes',
                        onTap: () {
                          Get.back();
                          // TODO: Navigate to search
                          Get.snackbar(
                            'Search',
                            'Advanced search coming soon!',
                            backgroundColor: const Color(0xFF667eea),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      const Divider(height: 32),
                      _buildNavItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        subtitle: 'App preferences',
                        onTap: () {
                          Get.back();
                          // TODO: Navigate to settings
                          Get.snackbar(
                            'Settings',
                            'Settings feature coming soon!',
                            backgroundColor: const Color(0xFF667eea),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      _buildNavItem(
                        icon: Icons.help,
                        title: 'Help & Support',
                        subtitle: 'Get help and contact us',
                        onTap: () {
                          Get.back();
                          // TODO: Navigate to help
                          Get.snackbar(
                            'Help & Support',
                            'Help feature coming soon!',
                            backgroundColor: const Color(0xFF667eea),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      _buildNavItem(
                        icon: Icons.info,
                        title: 'About',
                        subtitle: 'App information',
                        onTap: () {
                          Get.back();
                          // TODO: Navigate to about
                          Get.snackbar(
                            'About',
                            'About feature coming soon!',
                            backgroundColor: const Color(0xFF667eea),
                            colorText: Colors.white,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      // Logout Button
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.back();
                              authController.logout();
                              Get.offAllNamed(AppRoutes.login);
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Logout'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(AuthController authController) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Obx(() {
          final username = authController.username ?? 'User';
          final email = authController.email ?? 'user@example.com';

          return Column(
            children: [
              const SizedBox(height: 20),
              // User Avatar
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Text(
                  username[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // User Info
              Column(
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Profile Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.profile);
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF667eea).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF667eea),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
