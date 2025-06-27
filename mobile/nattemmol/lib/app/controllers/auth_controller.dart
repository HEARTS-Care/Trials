import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final RxnString _username = RxnString();
  final RxnString _email = RxnString();
  final RxBool _isLoggedIn = false.obs;

  String? get username => _username.value;
  String? get email => _email.value;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() {
    final user = _storage.read('user');
    if (user != null) {
      _username.value = user['username'];
      _email.value = user['email'];
      _isLoggedIn.value = true;
    }
  }

  Future<bool> login(String email, String password) async {
    final user = _storage.read('user');
    if (user != null &&
        user['email'] == email &&
        user['password'] == password) {
      _username.value = user['username'];
      _email.value = user['email'];
      _isLoggedIn.value = true;
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String email, String password) async {
    final user = _storage.read('user');
    if (user != null && user['email'] == email) {
      return false; // Email already exists
    }
    await _storage.write('user', {
      'username': username,
      'email': email,
      'password': password,
    });
    _username.value = username;
    _email.value = email;
    _isLoggedIn.value = true;
    return true;
  }

  void logout() {
    _isLoggedIn.value = false;
    _username.value = null;
    _email.value = null;
    // Optionally clear user data
    // _storage.remove('user');
  }
}
