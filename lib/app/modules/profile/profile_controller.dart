import 'package:flutter_getx_mvc_architecture_guide/app/data/models/profile.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/profile_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository = Get.find<ProfileRepository>();
  
  final _profile = Rx<Profile?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isEditing = false.obs;

  Profile? get profile => _profile.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isEditing => _isEditing.value;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final profile = await _profileRepository.getProfile();
      _profile.value = profile;
    } catch (e) {
      _errorMessage.value = 'Failed to load profile: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleEditing() {
    _isEditing.value = !_isEditing.value;
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,
  }) async {
    if (_profile.value == null) return;

    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final updatedProfile = await _profileRepository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address,
        city: city,
        state: state,
        zipCode: zipCode,
        country: country,
      );
      _profile.value = updatedProfile;
      _isEditing.value = false;
    } catch (e) {
      _errorMessage.value = 'Failed to update profile: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }

  @override
  void onClose() {
    _profile.close();
    _isLoading.close();
    _errorMessage.close();
    _isEditing.close();
    super.onClose();
  }
}
