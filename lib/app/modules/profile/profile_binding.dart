import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/profile_repository.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(ProfileRepository.new);
    Get.lazyPut<ProfileController>(ProfileController.new);
  }
}
