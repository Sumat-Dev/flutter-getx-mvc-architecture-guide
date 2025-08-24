import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/auth_repository.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/auth/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(AuthRepository.new);
    Get.lazyPut<LoginController>(LoginController.new);
  }
}
