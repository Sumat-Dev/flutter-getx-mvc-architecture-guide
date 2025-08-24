import 'package:flutter_getx_mvc_architecture_guide/app/data/models/profile.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/providers/api_provider.dart';

class ProfileRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<Profile> getProfile() async {
    try {
      final response = await _apiProvider.get('/profile');
      return Profile.fromJson(response['profile'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  Future<Profile> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    DateTime? dateOfBirth,
    String? avatar,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (firstName != null) body['first_name'] = firstName;
      if (lastName != null) body['last_name'] = lastName;
      if (phone != null) body['phone'] = phone;
      if (address != null) body['address'] = address;
      if (city != null) body['city'] = city;
      if (state != null) body['state'] = state;
      if (zipCode != null) body['zip_code'] = zipCode;
      if (country != null) body['country'] = country;
      if (dateOfBirth != null) {
        body['date_of_birth'] = dateOfBirth.toIso8601String();
      }
      if (avatar != null) body['avatar'] = avatar;

      final response = await _apiProvider.put(
        '/profile',
        body: body,
      );

      return Profile.fromJson(response['profile'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> uploadAvatar(String filePath) async {
    try {
      // Implementation for file upload would go here
      // This is a placeholder for the actual implementation
      await _apiProvider.post('/profile/avatar');
    } catch (e) {
      throw Exception('Failed to upload avatar: $e');
    }
  }

  Future<void> deleteAvatar() async {
    try {
      await _apiProvider.delete('/profile/avatar');
    } catch (e) {
      throw Exception('Failed to delete avatar: $e');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiProvider.put(
        '/profile/password',
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }
}
