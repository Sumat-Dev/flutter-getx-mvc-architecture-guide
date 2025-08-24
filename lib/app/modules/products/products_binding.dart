import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/product_repository.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/products/products_controller.dart';
import 'package:get/get.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(ProductRepository.new);
    Get.lazyPut<ProductsController>(ProductsController.new);
  }
}
