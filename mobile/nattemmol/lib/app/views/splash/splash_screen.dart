import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Logo animation
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Text animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    // Loading animation
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.linear,
    ));

    // Start animations
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _textController.forward();
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      _loadingController.repeat();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.find();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFf093fb),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Top section with animated background
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            // Animated background circles
                            Positioned(
                              top: 50,
                              left: 30,
                              child: AnimatedBuilder(
                                animation: _loadingAnimation,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle:
                                        _loadingAnimation.value * 2 * 3.14159,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.1),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 150,
                              right: 40,
                              child: AnimatedBuilder(
                                animation: _loadingAnimation,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle:
                                        -_loadingAnimation.value * 2 * 3.14159,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.15),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Main content
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Logo/Icon
                                  AnimatedBuilder(
                                    animation: _logoAnimation,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: _logoAnimation.value,
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 20,
                                                offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.restaurant_menu,
                                            size: 60,
                                            color: Color(0xFF667eea),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  // App name
                                  AnimatedBuilder(
                                    animation: _textAnimation,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            0, 20 * (1 - _textAnimation.value)),
                                        child: Opacity(
                                          opacity: _textAnimation.value,
                                          child: const Text(
                                            'Recipe Master',
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  AnimatedBuilder(
                                    animation: _textAnimation,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            0, 20 * (1 - _textAnimation.value)),
                                        child: Opacity(
                                          opacity: _textAnimation.value,
                                          child: const Text(
                                            'Discover Amazing Recipes',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white70,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bottom section with loading indicator
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Custom loading indicator
                            SizedBox(
                              width: 200,
                              child: Obx(() {
                                return LinearProgressIndicator(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.3),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                  minHeight: 4,
                                );
                              }),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Loading...',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
