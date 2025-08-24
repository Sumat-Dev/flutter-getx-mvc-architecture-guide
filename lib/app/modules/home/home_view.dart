import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      body: Obx(() => _buildBody(controller.currentIndex)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: controller.changePage,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildProductsContent();
      case 2:
        return _buildOrdersContent();
      case 3:
        return _buildProfileContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 16),
          Text(
            'Welcome to Flutter GetX MVC',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'A complete architecture guide',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag,
            size: 100,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          const Text(
            'Products Module',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Get.toNamed('/products'),
            child: const Text('Go to Products'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart,
            size: 100,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          const Text(
            'Orders Module',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Get.toNamed('/orders'),
            child: const Text('Go to Orders'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person,
            size: 100,
            color: Colors.purple,
          ),
          const SizedBox(height: 16),
          const Text(
            'Profile Module',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Get.toNamed('/profile'),
            child: const Text('Go to Profile'),
          ),
        ],
      ),
    );
  }
}
