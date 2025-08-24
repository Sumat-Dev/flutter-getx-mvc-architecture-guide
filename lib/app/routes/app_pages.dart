import 'package:flutter_getx_mvc_architecture_guide/app/modules/auth/login_binding.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/auth/login_view.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/home/home_binding.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/home/home_view.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/orders/orders_binding.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/orders/orders_view.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/products/products_binding.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/products/products_view.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/profile/profile_binding.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/profile/profile_view.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const String INITIAL = Routes.INITIAL;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.LOGIN,
      page: LoginView.new,
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: HomeView.new,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTS,
      page: ProductsView.new,
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: OrdersView.new,
      binding: OrdersBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: ProfileView.new,
      binding: ProfileBinding(),
    ),
  ];
}
