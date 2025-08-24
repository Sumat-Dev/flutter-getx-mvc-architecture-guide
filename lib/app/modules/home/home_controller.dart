import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  final RxString _title = 'Home'.obs;

  int get currentIndex => _currentIndex.value;
  String get title => _title.value;

  void changePage(int index) {
    _currentIndex.value = index;
    _updateTitle(index);
  }

  void _updateTitle(int index) {
    switch (index) {
      case 0:
        _title.value = 'Home';
      case 1:
        _title.value = 'Products';
      case 2:
        _title.value = 'Orders';
      case 3:
        _title.value = 'Profile';
    }
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/home');
      case 1:
        Get.offAllNamed('/products');
      case 2:
        Get.offAllNamed('/orders');
      case 3:
        Get.offAllNamed('/profile');
    }
  }
}
