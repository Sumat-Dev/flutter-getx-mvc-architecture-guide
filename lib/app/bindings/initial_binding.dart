import 'package:flutter_getx_mvc_architecture_guide/app/services/auth_service.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.lazyPut<AuthService>(AuthService.new, fenix: true);
    
    // Add other core dependencies here
  }
}
