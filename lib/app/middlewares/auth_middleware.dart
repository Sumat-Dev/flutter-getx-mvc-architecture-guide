import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/services/auth_service.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();

    if (!authService.isAuthenticated) {
      return const RouteSettings(name: '/login');
    }

    return null;
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authService = Get.find<AuthService>();

    if (!authService.isAuthenticated) {
      return GetNavConfig.fromRoute('/login');
    }

    return super.redirectDelegate(route);
  }
}
