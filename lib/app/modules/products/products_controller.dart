import 'package:flutter_getx_mvc_architecture_guide/app/data/models/product.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/data/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final ProductRepository _productRepository = Get.find<ProductRepository>();
  
  final RxList<Product> _products = <Product>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _searchQuery = ''.obs;
  final RxString _selectedCategory = ''.obs;
  final RxList<String> _categories = <String>[].obs;

  List<Product> get products => _products.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get searchQuery => _searchQuery.value;
  String get selectedCategory => _selectedCategory.value;
  List<String> get categories => _categories.value;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadProducts();
  }

  void setSearchQuery(String query) {
    _searchQuery.value = query;
    loadProducts();
  }

  void setCategory(String category) {
    _selectedCategory.value = category;
    loadProducts();
  }

  Future<void> loadCategories() async {
    try {
      final categories = await _productRepository.getCategories();
      _categories.value = categories;
    } catch (e) {
      _errorMessage.value = 'Failed to load categories: $e';
    }
  }

  Future<void> loadProducts() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final products = await _productRepository.getProducts(
        category: _selectedCategory.value.isNotEmpty ? _selectedCategory.value : null,
        search: _searchQuery.value.isNotEmpty ? _searchQuery.value : null,
      );
      _products.value = products;
    } catch (e) {
      _errorMessage.value = 'Failed to load products: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  void clearFilters() {
    _searchQuery.value = '';
    _selectedCategory.value = '';
    loadProducts();
  }

  @override
  void onClose() {
    _products.close();
    _isLoading.close();
    _errorMessage.close();
    _searchQuery.close();
    _selectedCategory.close();
    _categories.close();
    super.onClose();
  }
}
