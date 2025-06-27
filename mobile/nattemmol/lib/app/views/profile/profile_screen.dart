import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      body: Container(
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
              // Header
              _buildHeader(authController),
              // Profile Content
              Expanded(
                child: _buildProfileContent(authController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AuthController authController) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              authController.logout();
              Get.offAllNamed(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(AuthController authController) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Obx(() {
        if (!authController.isLoggedIn) {
          return const Center(
            child: Text('Not logged in'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Avatar
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF667eea),
                child: Text(
                  (authController.username ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // User Info
              Text(
                authController.username ?? 'User',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                authController.email ?? 'user@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),
              // Profile Options
              _buildProfileOption(
                icon: Icons.edit,
                title: 'Edit Profile',
                onTap: () {
                  // TODO: Navigate to edit profile
                },
              ),
              _buildProfileOption(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  // TODO: Navigate to settings
                },
              ),
              _buildProfileOption(
                icon: Icons.help,
                title: 'Help & Support',
                onTap: () {
                  // TODO: Navigate to help
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
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
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
