import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/order_repository.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/orders/orders_controller.dart';
import 'package:get/get.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(OrderRepository.new);
    Get.lazyPut<OrdersController>(OrdersController.new);
  }
}
