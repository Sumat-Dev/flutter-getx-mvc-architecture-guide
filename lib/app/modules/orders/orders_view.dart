import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/models/order.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/orders/orders_controller.dart';
import 'package:get/get.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        controller.errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.loadOrders,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.orders.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No orders found',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return _buildOrderCard(order);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => DropdownButtonFormField<String>(
                initialValue: controller.selectedStatus.isNotEmpty
                    ? controller.selectedStatus
                    : null,
                hint: const Text('All Statuses'),
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('All Statuses'),
                  ),
                  ...controller.statuses.map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.setStatus(value);
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: controller.clearFilters,
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${order.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total: \$${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            Chip(
              label: Text(order.status ?? ''),
              backgroundColor: _getStatusColor(order.status ?? ''),
            ),
          ],
        ),
        subtitle: Text(
          'Created: ${_formatDate(order.createdAt ?? DateTime.now())}',
          style: const TextStyle(fontSize: 12),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...(order.items ?? []).map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('${item.productName} x${item.quantity}'),
                        ),
                        Text('\$${item.price?.toStringAsFixed(2) ?? '0.00'}'),
                      ],
                    ),
                  ),
                ),
                if (order.shippingAddress != null) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Shipping Address:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(order.shippingAddress ?? 'No address provided'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange[100]!;
      case 'processing':
        return Colors.blue[100]!;
      case 'shipped':
        return Colors.purple[100]!;
      case 'delivered':
        return Colors.green[100]!;
      case 'cancelled':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
