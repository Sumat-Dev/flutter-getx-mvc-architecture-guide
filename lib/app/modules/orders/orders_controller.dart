import 'package:flutter_getx_mvc_architecture_guide/app/data/models/order.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/order_repository.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();
  
  final RxList<Order> _orders = <Order>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _selectedStatus = ''.obs;
  final RxList<String> _statuses = <String>[].obs;

  List<Order> get orders => _orders.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get selectedStatus => _selectedStatus.value;
  List<String> get statuses => _statuses.value;

  @override
  void onInit() {
    super.onInit();
    loadStatuses();
    loadOrders();
  }

  void setStatus(String status) {
    _selectedStatus.value = status;
    loadOrders();
  }

  Future<void> loadStatuses() async {
    try {
      final statuses = await _orderRepository.getOrderStatuses();
      _statuses.value = statuses;
    } catch (e) {
      _errorMessage.value = 'Failed to load statuses: $e';
    }
  }

  Future<void> loadOrders() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final orders = await _orderRepository.getOrders(
        status: _selectedStatus.value.isNotEmpty ? _selectedStatus.value : null,
      );
      _orders.value = orders;
    } catch (e) {
      _errorMessage.value = 'Failed to load orders: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void clearFilters() {
    _selectedStatus.value = '';
    loadOrders();
  }

  @override
  void onClose() {
    _orders.close();
    _isLoading.close();
    _errorMessage.close();
    _selectedStatus.close();
    _statuses.close();
    super.onClose();
  }
}
