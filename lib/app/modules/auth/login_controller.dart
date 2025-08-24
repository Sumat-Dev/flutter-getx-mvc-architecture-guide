import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final RxString _email = ''.obs;
  final RxString _password = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  String get email => _email.value;
  String get password => _password.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  void setEmail(String value) => _email.value = value;
  void setPassword(String value) => _password.value = value;

  Future<void> login() async {
    if (_email.value.isEmpty || _password.value.isEmpty) {
      _errorMessage.value = 'Please fill in all fields';
      return;
    }

    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final user = await _authRepository.login(_email.value, _password.value);

      Get.offAllNamed('/home');
        } catch (e) {
      _errorMessage.value = 'Login failed: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }

  @override
  void onClose() {
    _email.close();
    _password.close();
    _isLoading.close();
    _errorMessage.close();
    super.onClose();
  }
}
