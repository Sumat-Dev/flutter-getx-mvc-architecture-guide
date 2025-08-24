# Flutter GetX MVC Architecture Guide

A comprehensive Flutter project demonstrating MVC (Model-View-Controller) architecture with GetX state management.

## 🏗️ Project Structure

```bash
lib/
├── app/
│   ├── bindings/           # Dependency injection bindings
│   │   └── initial_binding.dart
│   ├── data/               # Data layer
│   │   ├── models/         # Data models
│   │   │   ├── user.dart
│   │   │   ├── product.dart
│   │   │   ├── order.dart
│   │   │   └── profile.dart
│   │   ├── providers/      # API providers
│   │   │   └── api_provider.dart
│   │   └── repositories/   # Data repositories
│   │       ├── auth_repository.dart
│   │       ├── product_repository.dart
│   │       ├── order_repository.dart
│   │       └── profile_repository.dart
│   ├── middlewares/        # Route middlewares
│   │   └── auth_middleware.dart
│   ├── modules/            # Feature modules
│   │   ├── auth/           # Authentication module
│   │   │   ├── login_binding.dart
│   │   │   ├── login_controller.dart
│   │   │   └── login_view.dart
│   │   ├── home/           # Home module
│   │   │   ├── home_binding.dart
│   │   │   ├── home_controller.dart
│   │   │   └── home_view.dart
│   │   ├── products/       # Products module
│   │   │   ├── products_binding.dart
│   │   │   ├── products_controller.dart
│   │   │   └── products_view.dart
│   │   ├── orders/         # Orders module
│   │   │   ├── orders_binding.dart
│   │   │   ├── orders_controller.dart
│   │   │   └── orders_view.dart
│   │   └── profile/        # Profile module
│   │       ├── profile_binding.dart
│   │       ├── profile_controller.dart
│   │       └── profile_view.dart
│   ├── routes/             # App routing
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   ├── services/           # Business logic services
│   │   └── auth_service.dart
│   ├── theme/              # App theming
│   │   └── app_theme.dart
│   └── utils/              # Utility functions
│       └── validators.dart
└── main.dart               # App entry point
```

## 🎯 Architecture Overview

### **MVC Pattern with GetX**

This project follows the **Model-View-Controller** pattern enhanced with GetX for state management:

- **Model**: Data models and repositories in the `data/` folder
- **View**: UI components in the `modules/*/views/` folders
- **Controller**: Business logic in the `modules/*/controllers/` folders

### **Key Components**

#### 1. **Bindings** (`app/bindings/`)

- Dependency injection setup for each module
- Manages the lifecycle of controllers and services

#### 2. **Data Layer** (`app/data/`)

- **Models**: Data structures with JSON serialization
- **Providers**: HTTP client for API communication
- **Repositories**: Data access abstraction layer

#### 3. **Modules** (`app/modules/`)

- Feature-based organization
- Each module contains its own MVC components
- Self-contained with bindings, controllers, and views

#### 4. **Services** (`app/services/`)

- Business logic that spans multiple modules
- Authentication, notifications, etc.

#### 5. **Routes** (`app/routes/`)

- Centralized routing configuration
- Route guards and middleware support

## 📱 Features

### **Authentication Module**

- User login/logout
- Route protection with middleware
- Session management

### **Home Module**

- Dashboard with navigation
- Bottom navigation bar
- Module overview

### **Products Module**

- Product listing with search
- Category filtering
- Product details

### **Orders Module**

- Order management
- Status tracking
- Order history

### **Profile Module**

- User profile management
- Editable form fields
- Avatar handling

## 🛠️ Dependencies

### **Core Dependencies**

- **get**: ^4.6.6 - State management and routing
- **http**: ^1.1.0 - HTTP client for API calls

### **Dev Dependencies**

- **very_good_analysis**: ^9.0.0 - Comprehensive code analysis and linting

## 📚 Usage Examples

### **Creating a New Module**

1.**Create the module folder structure**:

```bash
   lib/app/modules/new_feature/
   ├── new_feature_binding.dart
   ├── new_feature_controller.dart
   └── new_feature_view.dart
   ```

2.**Add the binding**:

   ```dart
   class NewFeatureBinding extends Bindings {
     @override
     void dependencies() {
       Get.lazyPut<NewFeatureController>(() => NewFeatureController());
     }
   }
   ```

3.**Create the controller**:

   ```dart
   class NewFeatureController extends GetxController {
     final _data = ''.obs;
     
     String get data => _data.value;
     
     void updateData(String value) => _data.value = value;
   }
   ```

4.**Build the view**:

   ```dart
   class NewFeatureView extends GetView<NewFeatureController> {
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: Text('New Feature')),
         body: Center(
           child: Obx(() => Text(controller.data)),
         ),
       );
     }
   }
   ```

5.**Add to routes**:

   ```dart
   GetPage(
     name: '/new-feature',
     page: () => NewFeatureView(),
     binding: NewFeatureBinding(),
   ),
   ```

### **Using Controllers**

```dart
class ExampleController extends GetxController {
  final _count = 0.obs;
  
  int get count => _count.value;
  
  void increment() => _count.value++;
  void decrement() => _count.value--;
}
```

### **Reactive UI with Obx**

```dart
Obx(() => Text('Count: ${controller.count}'))
```

## 📖 Best Practices

### **1. Module Organization**

- Keep modules self-contained
- Use consistent naming conventions
- Separate concerns (UI, logic, data)

### **2. State Management**

- Use `.obs` for reactive variables
- Keep controllers focused and lightweight
- Avoid business logic in views

### **3. Error Handling**

- Implement proper error handling in repositories
- Show user-friendly error messages
- Log errors for debugging

### **4. Performance**

- Use `Get.lazyPut()` for lazy loading
- Implement proper disposal in controllers
- Optimize list views with `ListView.builder`

## 🔒 Security

### **Authentication**

- Implement proper token management
- Use secure storage for sensitive data
- Validate user permissions

### **API Security**

- Use HTTPS for all API calls
- Implement proper authentication headers
- Validate API responses

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
