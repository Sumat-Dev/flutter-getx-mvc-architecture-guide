import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/bindings/initial_binding.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/routes/app_pages.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/theme/app_theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX MVC',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
