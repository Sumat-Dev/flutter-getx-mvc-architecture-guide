import 'package:flutter_getx_mvc_architecture_guide/app/data/models/order.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/providers/api_provider.dart';

class OrderRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<Order>> getOrders({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        if (status != null) 'status': status,
      };

      final response = await _apiProvider.get(
        '/orders',
        queryParams: queryParams,
      );

      return (response['orders'] as List)
          .map((order) => Order.fromJson(order as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  Future<Order> getOrderById(String id) async {
    try {
      final response = await _apiProvider.get('/orders/$id');
      return Order.fromJson(response['order'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  Future<Order> createOrder({
    required List<OrderItem> items,
    required String shippingAddress,
  }) async {
    try {
      final response = await _apiProvider.post(
        '/orders',
        body: {
          'items': items.map((item) => item.toJson()).toList(),
          'shipping_address': shippingAddress,
        },
      );

      return Order.fromJson(response['order'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<Order> updateOrderStatus({
    required String id,
    required String status,
  }) async {
    try {
      final response = await _apiProvider.put(
        '/orders/$id/status',
        body: {
          'status': status,
        },
      );

      return Order.fromJson(response['order'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  Future<void> cancelOrder(String id) async {
    try {
      await _apiProvider.put(
        '/orders/$id/cancel',
        body: {'status': 'cancelled'},
      );
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }

  Future<List<String>> getOrderStatuses() async {
    try {
      final response = await _apiProvider.get('/orders/statuses');
      return List<String>.from(response['statuses'] as Iterable<dynamic>);
    } catch (e) {
      throw Exception('Failed to get order statuses: $e');
    }
  }
}
