import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../data/providers/recipe_provider.dart';
import '../data/providers/user_provider.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeProvider>(() => RecipeProvider());
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<RecipeController>(() => RecipeController());
  }
}
