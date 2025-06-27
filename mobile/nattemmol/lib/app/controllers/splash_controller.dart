import 'package:get/get.dart';
import 'auth_controller.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthController _authController = Get.find();
  final RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 3));

    // Check authentication status
    if (_authController.isLoggedIn) {
      // User is logged in, navigate to main layout
      Get.offAllNamed(AppRoutes.mainLayout);
    } else {
      // User is not logged in, navigate to login
      Get.offAllNamed(AppRoutes.login);
    }

    _isLoading.value = false;
  }
}
