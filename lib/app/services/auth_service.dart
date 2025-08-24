import 'package:get/get.dart';

class AuthService extends GetxService {
  final RxBool _isAuthenticated = false.obs;
  final _user = Rx<User?>(null);

  bool get isAuthenticated => _isAuthenticated.value;
  User? get user => _user.value;

  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock user data
      _user.value = User(
        id: '1',
        email: email,
        name: 'John Doe',
      );
      _isAuthenticated.value = true;
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    _isAuthenticated.value = false;
    _user.value = null;
  }

  Future<bool> checkAuthStatus() async {
    // Check if user is still authenticated
    return _isAuthenticated.value;
  }
}

class User {

  User({
    required this.id,
    required this.email,
    required this.name,
  });
  final String id;
  final String email;
  final String name;
}
