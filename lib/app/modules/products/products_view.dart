import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/models/product.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/products/products_controller.dart';
import 'package:get/get.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
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
                        onPressed: controller.loadProducts,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.products.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No products found',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return _buildProductCard(product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: controller.setSearchQuery,
            decoration: const InputDecoration(
              hintText: 'Search products...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    initialValue: controller.selectedCategory.isNotEmpty
                        ? controller.selectedCategory
                        : null,
                    hint: const Text('All Categories'),
                    items: [
                      const DropdownMenuItem(
                        value: '',
                        child: Text('All Categories'),
                      ),
                      ...controller.categories.map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setCategory(value);
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
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: product.image != null
              ? ClipOval(
                  child: Image.network(
                    product.image!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image, color: Colors.grey);
                    },
                  ),
                )
              : const Icon(Icons.image, color: Colors.grey),
        ),
        title: Text(
          product.name ?? 'No name',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description ?? 'No description'),
            const SizedBox(height: 4),
            Row(
              children: [
                Chip(
                  label: Text(product.category ?? 'No category'),
                  backgroundColor: Colors.blue[100],
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('Stock: ${product.stock}'),
                  backgroundColor: Colors.green[100],
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              'ID: ${product.id}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
