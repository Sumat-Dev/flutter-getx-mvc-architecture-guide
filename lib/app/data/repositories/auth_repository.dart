import 'package:flutter_getx_mvc_architecture_guide/app/data/models/user.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/providers/api_provider.dart';

class AuthRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiProvider.post(
        '/auth/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      return User.fromJson(response['user'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _apiProvider.post(
        '/auth/register',
        body: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      return User.fromJson(response['user'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _apiProvider.post('/auth/logout');
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _apiProvider.get('/auth/me');
      return User.fromJson(response['user'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  Future<void> refreshToken() async {
    try {
      await _apiProvider.post('/auth/refresh');
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }
}
