import 'package:flutter_getx_mvc_architecture_guide/app/data/models/product.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/providers/api_provider.dart';

class ProductRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        if (category != null) 'category': category,
        if (search != null) 'search': search,
      };

      final response = await _apiProvider.get(
        '/products',
        queryParams: queryParams,
      );

      return (response['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await _apiProvider.get('/products/$id');
      return Product.fromJson(response['product']);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  Future<Product> createProduct({
    required String name,
    required String description,
    required double price,
    required int stock,
    required String category,
    String? image,
  }) async {
    try {
      final response = await _apiProvider.post(
        '/products',
        body: {
          'name': name,
          'description': description,
          'price': price,
          'stock': stock,
          'category': category,
          if (image != null) 'image': image,
        },
      );

      return Product.fromJson(response['product']);
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  Future<Product> updateProduct({
    required String id,
    String? name,
    String? description,
    double? price,
    int? stock,
    String? category,
    String? image,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (description != null) body['description'] = description;
      if (price != null) body['price'] = price;
      if (stock != null) body['stock'] = stock;
      if (category != null) body['category'] = category;
      if (image != null) body['image'] = image;

      final response = await _apiProvider.put(
        '/products/$id',
        body: body,
      );

      return Product.fromJson(response['product']);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _apiProvider.delete('/products/$id');
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _apiProvider.get('/products/categories');
      return List<String>.from(response['categories']);
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }
}
